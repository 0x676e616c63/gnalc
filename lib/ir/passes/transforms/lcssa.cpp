#include "../../../../include/ir/passes/transforms/lcssa.hpp"

#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"

#include <deque>

namespace IR {
// Get an available value in a block.
//
// A motivating example:
//
//     Original Value Block
//        |          |
//        V          V
//     Exit1        Exit2
//       |           |
//       v           |
//       A           |
//       |           |
//       v           |
//    Target   <------
//
//
// Uses outside the loop must in the blocks that are reachable from the exit.
// If there is only one exit dominate Target, the value in exit is what we want.
// Because the exits cannot reach each other, that dominator exit must the only exit that can reach it.
//
// However, if there is no such dominator exit, which means there are multiple exits
// that can reach that block, none of them can dominate Target. Thus, new phi nodes
// are needed to merge the LCSSA phis.
//
// The way to check if we need to create a new phi node in a block is to check if the block's idom is in the loop.
// Since values flow through the idom chain, the original must dominates the Target.
// So if the idom is not the loop, we are still below the exits (for example, in Target).
// In that case we don't insert phi and `getValueForBlock` from the idom.
// If the idom is in the loop, a phi is needed to merge the incoming blocks' values.
//
// A generalized tool should be set up in the future.
std::shared_ptr<Value> LCSSAPass::getValueForBlock(
    const Loop& loop,
    const DomTree::Node* node,
    const std::shared_ptr<Value>& value,
    std::map<const DomTree::Node*, std::shared_ptr<Value>>& added_values) {
    auto it = added_values.find(node);
    if (it != added_values.end())
        return it->second;

    auto idom = node->parent();
    Err::gassert(idom != nullptr);
    if (!loop.contains(idom->block())) {
        auto val = getValueForBlock(loop, idom, value, added_values);
        return added_values[node] = val;
    }

    auto phi = std::make_shared<PHIInst>("%lcssa.p" + std::to_string(name_cnt++), value->getType());
    node->block()->addPhiInst(phi);
    for (const auto& pred : node->block()->preds()) {
        auto val = getValueForBlock(loop, domtree[pred.get()].get(), value, added_values);
        phi->addPhiOper(val, pred);
    }
    return added_values[node] = phi;
}

PM::PreservedAnalyses LCSSAPass::run(Function &function, FAM &fam) {
    bool lcssa_inst_modified = false;
    auto loop_info = fam.getResult<LoopAnalysis>(function);
    domtree = fam.getResult<DomTreeAnalysis>(function);
    for (const auto &toplevel : loop_info) {
        // Rewrite uses outside the loop, forming LCSSA phi in the exit blocks.
        // Handle the innermost loop first so that outer one's LCSSA form won't be destroyed.
        auto looppdfv = toplevel->getDFVisitor<Util::DFVOrder::PostOrder>();
        for (const auto &loop : looppdfv) {
            Err::gassert(loop->isSimplifyForm(), "Expected LoopSimplified Form");

            // Since we do this in a post-order, subloop should already be in LCSSA form.
            for (const auto& subloop : *loop)
                Err::gassert(subloop->isRecursivelyLCSSAForm(loop_info));

            // A cache for getting exit blocks
            std::map<Loop*, std::set<BasicBlock*>> exits_map;
            auto curr_loop_exits = loop->getExitBlocks();
            exits_map[loop.get()] = curr_loop_exits;

            if (curr_loop_exits.empty()) {
                Logger::logWarning("[LCSSA] on '", function.getName(), "': Endless loop detected.");
                continue;
            }

            //
            // Collect basic blocks that dominates the exits
            //
            // First get the blocks dominating at least one exit in the loop.
            // If a block dominates no exit, it cannot be used outside the loop.
            //
            // To do this, we start from the exit blocks, checking the immediate dominator
            // of each block, and adding them to worklist.
            // If we meet the header, we are done. Because the header dominates all blocks in the loop.
            std::set<BasicBlock *> exit_dominating_blocks;
            std::vector<BasicBlock *> bb_worklist{curr_loop_exits.begin(), curr_loop_exits.end()};
            while (!bb_worklist.empty()) {
                auto curr = bb_worklist.back();
                bb_worklist.pop_back();
                if (curr == loop->getHeader())
                    continue;

                // Note that the immediate dominator of a block does not necessarily belong to the loop.
                //                  ------------
                //                  |          |
                //                  V          |
                // PreHeader ---> Header -> Exiting -> Exit
                //    |                       ^
                //    |                       |
                //    -------------------------
                //
                // The Exiting is immediately dominated by PreHeader, which is not a part of the loop.
                auto idom = domtree[curr]->parent()->block();
                if (!loop->contains(idom))
                    continue;

                if (exit_dominating_blocks.insert(idom).second)
                    bb_worklist.emplace_back(idom);
            }

            //
            // Collect instructions that might have uses outside the loop
            //
            std::vector<std::shared_ptr<Instruction>> inst_worklist;
            // For each instruction in the exit dominating blocks, check if they have
            // uses outside the loop. If so, rewrite their uses.
            for (const auto& candidate : exit_dominating_blocks) {
                // Since we are iterating the loops in a post-order,
                // skip blocks that are in the subloop. They are in LCSSA already.
                if (loop_info.getLoopFor(candidate) != loop)
                    continue;
                for (const auto& inst : candidate->all_insts()) {
                    if (inst->getUseCount() == 0)
                        continue;
                    // If this inst is only used in this block, skip it.
                    if (auto single_user = inst->getSingleUser()) {
                        auto single_user_inst = std::dynamic_pointer_cast<Instruction>(single_user);
                        if (single_user_inst->getOpcode() != OP::PHI &&
                            single_user_inst->getParent().get() == candidate) {
                            continue;
                        }
                    }
                    inst_worklist.emplace_back(inst);
                }
            }

            while (!inst_worklist.empty()) {
                std::vector<std::shared_ptr<Use>> uses_to_rewrite;
                std::map<const DomTree::Node*, std::shared_ptr<Value>> added_values;
                auto curr_inst = inst_worklist.back();
                inst_worklist.pop_back();
                auto inst_bb = curr_inst->getParent();

                for (const auto& use : curr_inst->self_uses()) {
                    auto user_inst = std::dynamic_pointer_cast<Instruction>(use->getUser());
                    auto user_bb = user_inst->getParent();

                    // For phi, the use of each incoming value is deemed to occur
                    // on the edge from the corresponding predecessor block to the current block.
                    // (See LangRef: https://llvm.org/docs/LangRef.html#id318)
                    // For practical purposes, we consider it occurs in the corresponding predecessor.
                    if (auto phi = std::dynamic_pointer_cast<PHIInst>(user_inst))
                        user_bb = phi->getBlockForValue(use);

                    // A quick path for most uses being in the same block
                    if (inst_bb != user_bb && !loop->contains(user_bb.get()))
                        uses_to_rewrite.emplace_back(use);
                }
                if (uses_to_rewrite.empty())
                    continue;

                // Insert a phi into all the exit blocks that are dominated by the value
                for (const auto& exit : curr_loop_exits) {
                    if (!domtree.ADomB(inst_bb.get(), exit))
                        continue;

                    // Check if there is already what we want
                    auto avail_phi = findLCSSAPhi(exit, curr_inst);
                    if (avail_phi == nullptr) {
                        avail_phi = std::make_shared<PHIInst>(
                            curr_inst->getName() + ".lcssa" + std::to_string(name_cnt++), curr_inst->getType());
                        for (const auto& pred : exit->preds()) {
                            avail_phi->addPhiOper(curr_inst, pred);
                            if (!loop->contains(pred.get())) {
                                uses_to_rewrite.emplace_back
                                    (*std::prev(std::prev(avail_phi->operand_use_end())));
                            }
                        }
                        exit->addPhiInst(avail_phi);
                        Err::gassert(added_values[domtree[exit].get()] == nullptr,
                            "Duplicated phi insertion.");
                    }
                    added_values[domtree[exit].get()] = avail_phi;
                }

                for (const auto& use : uses_to_rewrite) {
                    auto user_inst = std::dynamic_pointer_cast<Instruction>(use->getUser());
                    auto user_bb = user_inst->getParent();
                    if (auto phi = std::dynamic_pointer_cast<PHIInst>(user_inst))
                        user_bb = phi->getBlockForValue(use);

                    auto val = getValueForBlock(*loop,
                        domtree[user_bb.get()].get(), curr_inst, added_values);
                    user_inst->replaceUse(use, val);
                    lcssa_inst_modified = true;
                }
            }
            Err::gassert(loop->isLCSSAForm(), "Failed to transform a loop into LCSSA form.");
        }
    }

    name_cnt = 0;
    domtree = {};
    return lcssa_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR