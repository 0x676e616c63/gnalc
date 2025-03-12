#include "../../../../include/ir/passes/transforms/lcssa.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses LCSSAPass::run(Function &function, FAM &fam) {
    bool lcssa_inst_modified = false;
    auto loop_info = fam.getResult<LoopAnalysis>(function);
    auto domtree = fam.getResult<DomTreeAnalysis>(function);
    for (const auto &toplevel : loop_info) {
        auto looppdfv = toplevel->getDFVisitor<Util::DFVOrder::PostOrder>();
        for (const auto &loop : looppdfv) {
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
                auto idom = domtree.nodes[curr]->parent->bb;
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
                // Since we are iterating the loops in a post order,
                // skip blocks that are in the subloop. They are in LCSSA already.
                if (loop_info.getLoopFor(candidate) != loop)
                    continue;
                auto all_insts = candidate->getAllInsts();
                for (const auto& inst : all_insts) {
                    if (inst->getUseCount() == 0)
                        continue;
                    // If this inst is only used in the block, skip it.
                    if (inst->getUseCount() == 1) {
                        auto single_user = inst->getUseList().back()->getUser();
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
                std::map<BasicBlock*, std::shared_ptr<PHIInst>> available_phis;
                auto curr_inst = inst_worklist.back();
                inst_worklist.pop_back();
                auto inst_bb = curr_inst->getParent();

                auto use_list = curr_inst->getUseList();
                for (const auto& use : use_list) {
                    auto user_inst = std::dynamic_pointer_cast<Instruction>(use->getUser());
                    auto user_bb = user_inst->getParent();

                    // For phi, the use of each incoming value is deemed to occur
                    // on the edge from the corresponding predecessor block to the current block.
                    // (See LangRef: https://llvm.org/docs/LangRef.html#id318)
                    // For practical purposes, we consider it occurs in the corresponding predecessor.
                    if (auto phi = std::dynamic_pointer_cast<PHIInst>(user_inst))
                        user_bb = phi->getBlockForValue(use);

                    if (inst_bb != user_bb && !loop->contains(inst_bb.get()))
                        uses_to_rewrite.emplace_back(use);
                }
                if (uses_to_rewrite.empty())
                    continue;

                // Insert a phi into all the exit blocks that are dominated by the value
                for (const auto& exit : curr_loop_exits) {
                    if (!domtree.ADomB(inst_bb.get(), exit))
                        continue;

                    std::shared_ptr<PHIInst> avail_phi;

                    // Check if there is already what we want
                    for (const auto& phi : exit->getPhiInsts()) {
                        auto phi_opers = phi->getPhiOpers();
                        bool ok = true;
                        for (const auto& [val, bb] : phi_opers) {
                            if (val != curr_inst) {
                                ok = false;
                                break;
                            }
                        }
                        if (ok)
                            avail_phi = phi;
                    }
                    if (avail_phi == nullptr) {
                        auto phi = std::make_shared<PHIInst>(
                            curr_inst->getName() + ".lcssa" + std::to_string(name_cnt++), curr_inst->getType());
                        auto preds = exit->getPreBB();
                        for (const auto& pred : preds) {
                            phi->addPhiOper(curr_inst, pred);
                            if (!loop->contains(pred.get())) {
                                uses_to_rewrite.emplace_back
                                    (*std::prev(std::prev(phi->getUseList().end())));
                            }
                        }
                        exit->addPhiInst(phi);
                        Err::gassert(available_phis[exit] == nullptr, "Duplicated phi insertion.");
                    }
                    available_phis[exit] = avail_phi;
                }

                for (const auto& use : uses_to_rewrite) {
                    auto user_inst = std::dynamic_pointer_cast<Instruction>(use->getUser());
                    auto user_bb = user_inst->getParent();
                    if (auto phi = std::dynamic_pointer_cast<PHIInst>(user_inst))
                        user_bb = phi->getBlockForValue(use);

                    // Uses outside the loop must in the blocks that are dominated by at least one exit.
                    // Find that exit and rewrite this use with a phi in it.
                    // If the use is in an exit block, that exit block is what we want.
                    BasicBlock* dom_exit = nullptr;
                    if (loop->isExit(user_bb.get()))
                        dom_exit = user_bb.get();
                    else {
                        for (const auto& exit : curr_loop_exits) {
                            if (domtree.ADomB(exit, user_bb.get())) {
                                dom_exit = exit;
                                break;
                            }
                        }
                    }

                    Err::gassert(dom_exit != nullptr, "Failed to find the correct exit block.");
                    if (auto added = available_phis[dom_exit]) {
                        use->getUser()->replaceUse(use, added);
                    }
                    lcssa_inst_modified = true;
                }
            }
        }
    }

    name_cnt = 0;
    return lcssa_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR