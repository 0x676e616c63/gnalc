#include "ir/passes/transforms/lcssa.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/control.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"

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
// If there is only one exit dominate Target, the value in that exit is what we want.
// Because the exits cannot reach each other, that dominator exit must be the only exit that can reach it.
//
// However, if there is no such dominator exit, which means there are multiple exits
// that can reach that block, none of them can dominate Target. Thus, new phi nodes
// are needed to merge the LCSSA phis.
//
// The way to check if we need to create a new phi node in a block is to check if the block's idom is in the loop.
// Since values flow through the idom chain, the original block must dominate the Target.
// So if the idom is not the loop, we are still below the exits (for example, in Target).
// In that case we don't insert phi and use the value in the idom. (`getValueForBlock` from idom)
// If the idom is in the loop, a phi is needed to merge the incoming blocks' values.
//
// A generalized tool should be set up in the future.
pVal LCSSAPass::getValueForBlock(const Loop &loop, const DomTree::Node *node, const pVal &value,
                                 std::map<const DomTree::Node *, pVal> &available_values) {
    auto &domtree = *pdomtree;
    auto it = available_values.find(node);
    if (it != available_values.end())
        return it->second;

    auto idom = node->parent();
    Err::gassert(idom != nullptr, "No such value available.");
    if (!loop.contains(idom->block())) {
        auto val = getValueForBlock(loop, idom.get(), value, available_values);
        return available_values[node] = val;
    }

    auto phi = std::make_shared<PHIInst>("%lcssa.p" + std::to_string(name_cnt++), value->getType());
    node->block()->addPhiInst(phi);
    for (const auto &pred : node->block()->preds()) {
        auto val = getValueForBlock(loop, domtree[pred].get(), value, available_values);
        phi->addPhiOper(val, pred);
    }
    return available_values[node] = phi;
}

bool LCSSAPass::formLCSSAOnInsts(std::deque<pInst> &worklist) {
    auto &domtree = *pdomtree;
    auto &loop_info = *ploop_info;
    bool modified = false;
    std::vector<Use*> uses_to_rewrite;
    std::map<const DomTree::Node *, pVal> available_values;
    while (!worklist.empty()) {
        uses_to_rewrite.clear();
        available_values.clear();

        auto curr_inst = worklist.front();
        worklist.pop_front();
        auto inst_bb = curr_inst->getParent();
        auto loop = loop_info.getLoopFor(inst_bb);
        Err::gassert(loop != nullptr, "Instruction does not in a loop.");
        auto exits = loop->getExitBlocks();

        for (const auto &use : curr_inst->self_uses()) {
            auto user_inst = use->getUser()->as<Instruction>();
            auto user_bb = user_inst->getParent();

            // For phi, the use of each incoming value is deemed to occur
            // on the edge from the corresponding predecessor block to the current block.
            // (See LangRef: https://llvm.org/docs/LangRef.html#id318)
            // For practical purposes, we consider it occurs in the corresponding predecessor.
            if (auto phi = user_inst->as<PHIInst>())
                user_bb = phi->getBlockForValue(use);

            // A quick path for most uses being in the same block
            if (inst_bb != user_bb && !loop->contains(user_bb.get()))
                uses_to_rewrite.emplace_back(use);
        }
        if (uses_to_rewrite.empty())
            continue;

        // Insert a phi into all the exit blocks that are dominated by the value
        for (const auto &exit : exits) {
            if (!domtree.ADomB(inst_bb, exit))
                continue;

            // Check if there is already what we want
            auto avail_phi = findLCSSAPhi(exit, curr_inst);
            if (avail_phi == nullptr) {
                avail_phi = std::make_shared<PHIInst>(curr_inst->getName() + ".lcssa" + std::to_string(name_cnt++),
                                                      curr_inst->getType());
                for (const auto &pred : exit->preds()) {
                    avail_phi->addPhiOper(curr_inst, pred);
                    if (!loop->contains(pred)) {
                        uses_to_rewrite.emplace_back(std::prev(std::prev(avail_phi->getOperands().end()))->get());
                    }
                }
                exit->addPhiInst(avail_phi);
                Err::gassert(available_values[domtree[exit].get()] == nullptr, "Duplicate phi insertion.");
            }
            available_values[domtree[exit].get()] = avail_phi;
        }

        for (const auto &use : uses_to_rewrite) {
            auto user_inst = use->getUser()->as<Instruction>();
            auto user_bb = user_inst->getParent();
            if (auto phi = user_inst->as<PHIInst>())
                user_bb = phi->getBlockForValue(use);

            auto val = getValueForBlock(*loop, domtree[user_bb].get(), curr_inst, available_values);
            use->setValue(val);
            modified = true;
        }

        // getValueForBlock might insert phi in other disjoint loops, update them.
        for (const auto &[node, value] : available_values) {
            auto inst = value->as<Instruction>();
            if (auto loop2 = loop_info.getLoopFor(inst->getParent())) {
                if (!loop->contains(loop2))
                    worklist.emplace_back(inst);
            }
        }
    }
    return modified;
}

PM::PreservedAnalyses LCSSAPass::run(Function &function, FAM &fam) {
    bool lcssa_inst_modified = false;

    ploop_info = &fam.getResult<LoopAnalysis>(function);
    pdomtree = &fam.getResult<DomTreeAnalysis>(function);

    auto &domtree = *pdomtree;
    auto &loop_info = *ploop_info;

    for (const auto &toplevel : loop_info) {
        // Rewrite uses outside the loop, forming LCSSA phi in the exit blocks.
        // Handle the innermost loop first so that outer one's LCSSA form won't be destroyed.
        auto looppdfv = toplevel->getDFVisitor<Util::DFVOrder::PostOrder>();
        for (const auto &loop : looppdfv) {
            Err::gassert(loop->isSimplifyForm(), "Expected LoopSimplified Form");

            // Since we do this in a post-order, subloop should already be in LCSSA form.
            for (const auto &subloop : *loop)
                Err::gassert(subloop->isRecursivelyLCSSAForm(loop_info));

            // A cache for getting exit blocks
            std::map<Loop *, std::set<pBlock>> exits_map;
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
            std::set<pBlock> exit_dominating_blocks;
            std::vector<pBlock> bb_worklist{curr_loop_exits.begin(), curr_loop_exits.end()};
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
            std::deque<pInst> inst_worklist;
            // For each instruction in the exit dominating blocks, check if they have
            // uses outside the loop. If so, rewrite their uses.
            for (const auto &candidate : exit_dominating_blocks) {
                // Since we are iterating the loops in a post-order,
                // skip blocks that are in the subloop. They are in LCSSA already.
                if (loop_info.getLoopFor(candidate) != loop)
                    continue;
                for (const auto &inst : candidate->all_insts()) {
                    if (inst->getUseCount() == 0)
                        continue;
                    // If this inst is only used in this block, skip it.
                    if (auto single_user = inst->getSingleUser()) {
                        auto single_user_inst = single_user->as<Instruction>();
                        if (single_user_inst->getOpcode() != OP::PHI && single_user_inst->getParent() == candidate) {
                            continue;
                        }
                    }
                    inst_worklist.emplace_back(inst);
                }
            }

            lcssa_inst_modified |= formLCSSAOnInsts(inst_worklist);
            Err::gassert(loop->isLCSSAForm(), "Failed to transform a loop into LCSSA form.");
        }
    }

    for (const auto &toplevel : loop_info) {
        auto looppdfv = toplevel->getDFVisitor();
        for (const auto &loop : looppdfv)
            Err::gassert(loop->isLCSSAForm(), "Failed to transform a loop into LCSSA form.");
    }

    pdomtree = nullptr;
    ploop_info = nullptr;
    name_cnt = 0;
    return lcssa_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR