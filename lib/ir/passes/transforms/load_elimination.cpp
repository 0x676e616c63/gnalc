#include "../../../../include/ir/passes/transforms/load_elimination.hpp"

#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"

#include <algorithm>

namespace IR {
PM::PreservedAnalyses LoadEliminationPass::run(Function &function, FAM &fam) {
    bool load_elimination_inst_modified = false;

    auto aa_res = fam.getResult<AliasAnalysis>(function);
    auto domtree = fam.getResult<DomTreeAnalysis>(function);
    auto postdomtree = fam.getResult<PostDomTreeAnalysis>(function);
    std::set<std::shared_ptr<Instruction>> unused_load;

    // For each load, collect all possible store/load on its dominator block as candidates.
    // Then we consider all other blocks that can reach the load block,
    // instructions in them serves as a killer if it may modify the load's memory.
    // If one candidate post dominates the rest of candidates and all killers,
    // it is the most recent update on the load's memory. And we can replace the load with it.
    // Note that we don't replace it if there is a back edge.
    auto pdfv = function.getDFVisitor<Util::DFVOrder::PostOrder>();
    for (const auto &load_block : pdfv) {
        for (auto it = load_block->rbegin(); it != load_block->rend(); ++it) {
            auto load = std::dynamic_pointer_cast<LOADInst>(*it);
            if (load == nullptr)
                continue;
            auto load_ptr = load->getPtr().get();

            // First check the local block, this is always safe to replace.
            bool replaced = false;
            bool killed = false;
            for (auto inst_rit = std::next(it); inst_rit != load_block->rend(); ++inst_rit) {
                if (auto store = std::dynamic_pointer_cast<STOREInst>(*inst_rit)) {
                    auto store_ptr = store->getPtr().get();
                    auto aa = aa_res.getAliasInfo(load_ptr, store_ptr);
                    if (aa == AliasInfo::MustAlias) {
                        load->replaceSelf(store->getValue());
                        unused_load.insert(load);
                        replaced = true;
                        break;
                    }
                } else if (auto load2 = std::dynamic_pointer_cast<LOADInst>(*inst_rit)) {
                    auto load2_ptr = load2->getPtr().get();
                    auto aa = aa_res.getAliasInfo(load_ptr, load2_ptr);
                    if (aa == AliasInfo::MustAlias) {
                        load->replaceSelf(load2);
                        unused_load.insert(load);
                        replaced = true;
                        break;
                    }
                } else {
                    auto modref = aa_res.getInstModRefInfo(inst_rit->get(), load_ptr, fam);
                    if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef) {
                        killed = true;
                        break;
                    }
                }
            }

            // Replaced with store's value or load, go for the next load.
            if (replaced)
                continue;

            // Killed by something we don't know, skip it.
            if (killed)
                continue;

            // Not replaced and not killed
            // check other blocks to collect candidates and killers.
            // Note that we MUST consider each possible predecessor,
            // because each of them is able to invalidate the elimination.
            // For example:
            //
            //  bb0:
            //     store 1, @k
            //     br %bb1
            //  bb1:
            //     br %cond, %bb2, %bb3
            //  bb2:
            //    %v = load @k
            //    store 3, @k
            //    br %bb1
            //
            // When searching for candidates to replace load with, we must not skip the store in bb2.
            // Thus, we consider every block that could reach the load block
            // to collect all the possible killers
            // and, of those dominates the load block, collect all the possible candidates.
            // Finally, find the one that post dominates all other candidates and killers,
            // which is the most recent update on that memory.
            auto predecessors = load_block->getPreBB();
            std::set<std::shared_ptr<BasicBlock>> visited;
            std::deque<std::shared_ptr<BasicBlock>> worklist{predecessors.begin(), predecessors.end()};
            // LOADInst/STOREInst that may contribute to the elimination
            std::vector<std::shared_ptr<Instruction>> candidates;
            std::vector<std::shared_ptr<Instruction>> killers;
            bool backedge_detected = false;
            while (!worklist.empty()) {
                auto load_pred = worklist.front();
                visited.emplace(load_pred);
                worklist.pop_front();

                // If we meet the load block again, there is a back edge,
                // it is not safe to replace the load.
                //           exit <-- bb1 ----> bb2 ----> bb3
                //                    ^                    |
                //                    | -------------------
                //
                //                   bb1 ----> bb2 ----> bb3 ---> exit
                //                    ^                    |   
                //                    | -------------------    
                // bb1:
                //   %1 = load @a
                // bb2:
                //   store 1, @a
                // bb3:
                //   %2 = load @a
                //
                // In the first graph, %1 post dominates the store. However, it's not safe to replace.
                // Because the post dominator tree is focused on how we reach the exit block, not bb3.
                if (load_pred == load_block) {
                    backedge_detected = true;
                    break;
                }

                // For other blocks, if it dominates the load block, we can replace the load
                // with a load/store in the dominator block. If not, we still need to look at it
                // to figure out if there is something could kill the opportunity.
                if (domtree.ADomB(load_pred.get(), load_block.get())) {
                    for (auto inst_rit = load_pred->crbegin(); inst_rit != load_pred->crend(); ++inst_rit) {
                        const auto &inst = *inst_rit;
                        // We only collect the last possible store/load in a block,
                        // So once we find one, break.
                        if (auto store = std::dynamic_pointer_cast<STOREInst>(inst)) {
                            auto store_ptr = store->getPtr().get();
                            auto aa = aa_res.getAliasInfo(load_ptr, store_ptr);
                            if (aa == AliasInfo::MustAlias) {
                                candidates.emplace_back(store);
                                break;
                            }
                            if (aa == AliasInfo::MayAlias) {
                                killers.emplace_back(inst);
                                break;
                            }
                        }
                        else if (auto load2 = std::dynamic_pointer_cast<LOADInst>(inst)) {
                            auto load2_ptr = load2->getPtr().get();
                            auto aa = aa_res.getAliasInfo(load_ptr, load2_ptr);
                            if (aa == AliasInfo::MustAlias) {
                                candidates.emplace_back(load2);
                                break;
                            }
                        }
                        else {
                            auto modref = aa_res.getInstModRefInfo(inst.get(), load_ptr, fam);
                            if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef) {
                                killers.emplace_back(inst);
                                break;
                            }
                        }
                    }
                } else {
                    for (auto inst_rit = load_pred->crbegin(); inst_rit != load_pred->crend(); ++inst_rit) {
                        const auto &inst = *inst_rit;
                        auto modref = aa_res.getInstModRefInfo(inst.get(), load_ptr, fam);
                        if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef) {
                            killers.emplace_back(inst);
                            break;
                        }
                    }
                }

                auto preds = load_pred->getPreBB();
                for (const auto &p : preds) {
                    if (visited.find(p) == visited.end())
                        worklist.emplace_back(p);
                }
            }

            if (!backedge_detected)
            {
                // Note that we have collect possible store/load in a post order.
                // In other word, candidates.back() is the earliest one in control flow.
                // Then we do forward traversal of the candidates. If one candidate
                // post dominates all other candidate and killers,
                // it is the most recent update on the load's memory.
                // That is to say, it is the one we should replace the load with.
                std::shared_ptr<Instruction> target = nullptr;
                for (const auto &candidate : candidates) {
                    bool able_to_replace = true;
                    for (const auto &another : candidates) {
                        if (another == candidate)
                            continue;
                        // We only collect one candidate in a block.
                        Err::gassert(candidate->getParent() != another->getParent());
                        if (!postdomtree.ADomB(candidate->getParent().get(), another->getParent().get())) {
                            able_to_replace = false;
                            break;
                        }
                    }
                    for (const auto &killer : killers) {
                        if (killer->getParent() == candidate->getParent()) {
                            if (killer->getIndex() > candidate->getIndex()) {
                                able_to_replace = false;
                                break;
                            }
                        } else if (!postdomtree.ADomB(candidate->getParent().get(), killer->getParent().get())) {
                            able_to_replace = false;
                            break;
                        }
                    }
                    if (able_to_replace) {
                        target = candidate;
                        break;
                    }
                }

                if (auto target_load = std::dynamic_pointer_cast<LOADInst>(target)) {
                    load->replaceSelf(target_load);
                    unused_load.emplace(load);
                } else if (auto target_store = std::dynamic_pointer_cast<STOREInst>(target)) {
                    load->replaceSelf(target_store->getValue());
                    unused_load.emplace(load);
                }
            }
        }

        // Delete unused loads immediately to avoid influence on preceding analysis
        load_elimination_inst_modified |= load_block->delInstIf(
            [&unused_load](const auto &inst) { return unused_load.find(inst) != unused_load.end(); },
            BasicBlock::DEL_MODE::NON_PHI);
        unused_load.clear();
    }

    if (load_elimination_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        pa.preserve<LoopAnalysis>();
        return pa;
    }
    return PM::PreservedAnalyses::all();
}

} // namespace IR