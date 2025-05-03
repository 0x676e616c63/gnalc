#include "ir/passes/transforms/load_elimination.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"

#include <algorithm>

namespace IR {
PM::PreservedAnalyses LoadEliminationPass::run(Function &function, FAM &fam) {
    bool load_elimination_inst_modified = false;

    auto &aa_res = fam.getResult<AliasAnalysis>(function);
    auto &domtree = fam.getResult<DomTreeAnalysis>(function);
    auto &postdomtree = fam.getResult<PostDomTreeAnalysis>(function);
    std::unordered_set<pInst> unused_load;

    // For each load, collect all possible store/load on its proper dominator block as candidates.
    // Then we consider all other blocks that can reach the load block,
    // instructions in them serve as a killer if it may modify the load's memory.
    // If one candidate must execute after the rest of candidates and all killers,
    // it is the most recent update on the load's memory. And we can replace the load with it.
    auto pdfv = function.getDFVisitor<Util::DFVOrder::PostOrder>();
    for (const auto &load_block : pdfv) {
        for (auto it = load_block->rbegin(); it != load_block->rend(); ++it) {
            auto load = (*it)->as<LOADInst>();
            if (load == nullptr)
                continue;
            auto load_ptr = load->getPtr();

            // First check the local block, this is always safe to replace.
            bool replaced = false;
            bool killed = false;
            for (auto inst_rit = std::next(it); inst_rit != load_block->rend(); ++inst_rit) {
                if (auto store = (*inst_rit)->as<STOREInst>()) {
                    auto store_ptr = store->getPtr();
                    auto aa = aa_res.getAliasInfo(load_ptr, store_ptr);
                    if (aa == AliasInfo::MustAlias) {
                        load->replaceSelf(store->getValue());
                        unused_load.insert(load);
                        replaced = true;
                        Logger::logDebug("[LoadElim]: Replaced '", load->getName(), "' with '", store->getName(),
                                         "''s value.");
                        break;
                    }

                    if (aa == AliasInfo::MayAlias) {
                        killed = true;
                        break;
                    }
                } else if (auto load2 = (*inst_rit)->as<LOADInst>()) {
                    auto load2_ptr = load2->getPtr();
                    auto aa = aa_res.getAliasInfo(load_ptr, load2_ptr);
                    if (aa == AliasInfo::MustAlias) {
                        load->replaceSelf(load2);
                        unused_load.insert(load);
                        replaced = true;
                        Logger::logDebug("[LoadElim]: Replaced '", load->getName(), "' with '", load2->getName(), "'.");
                        break;
                    }
                } else {
                    auto modref = aa_res.getInstModRefInfo(*inst_rit, load_ptr, fam);
                    if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef) {
                        // FIXME: VectorType here.
                        if (load->getType()->is<BType>()) {
                            if (auto call = (*inst_rit)->as<CALLInst>()) {
                                if (call->getFunc()->isIntrinsic() &&
                                    call->getFunc()->hasAttr(FuncAttr::isMemsetIntrinsic)) {
                                    if (load->getType()->as<BType>()->getInner() == IRBTYPE::I32)
                                        load->replaceSelf(function.getConst(0));
                                    else
                                        load->replaceSelf(function.getConst(0.0f));
                                    unused_load.insert(load);
                                    replaced = true;
                                    Logger::logDebug("[LoadElim]: Replaced '", load->getName(), "' with zero.");
                                    break;
                                }
                            }
                        }

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
            //
            // We consider every block that could reach the load block
            // to collect all the possible killers, and, of those properly dominates the load block,
            // collect all the possible candidates.
            //
            // Finally, find the most recent load/store on the load's memory. And replace the
            // load with that load/store. The key is to find the candidate that must execute
            // after every other candidate and killers. IOW, in the post-dominator tree rooted
            // at the load block, find the candidate that post dominates all other candidates
            // and killers.
            //
            // Note that this post dominator tree's root is not exit, but the load block, considering:
            //
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
            // In the first graph, %1 in bb1 post dominates the store in bb2.
            // However, it's wrong to replace %2 in bb3 with %1 in bb1.
            // Because the default post dominator tree is focused on how we reach
            // the exit block, not bb3.
            //
            // However, computing a new post dominator tree every time is too expensive.
            // Besides, in cases where there is no backedge, a normal post dominator tree is enough.
            // A normal post dominator tree might already be in the cache of the PM.
            std::unordered_set<pBlock> visited;
            std::deque<pBlock> worklist{load_block->pred_begin(), load_block->pred_end()};
            // LOADInst/STOREInst that may contribute to the elimination are considered as candidates
            std::vector<pInst> candidates;
            std::vector<pInst> killers;
            bool backedge_detected = false;
            while (!worklist.empty()) {
                auto load_pred = worklist.front();
                visited.emplace(load_pred);
                worklist.pop_front();

                if (load_pred == load_block)
                    backedge_detected = true;

                // For other blocks, if it properly dominates the load block, we can replace the load
                // with a load/store in the dominator block. If not, we still need to look at it
                // to figure out if there is something could kill the opportunity.
                if (load_pred != load_block && domtree.ADomB(load_pred, load_block)) {
                    for (auto inst_rit = load_pred->crbegin(); inst_rit != load_pred->crend(); ++inst_rit) {
                        const auto &inst = *inst_rit;
                        // We only collect the last possible store/load in a block,
                        // So once we find one, break.
                        if (auto store = inst->as<STOREInst>()) {
                            auto store_ptr = store->getPtr();
                            auto aa = aa_res.getAliasInfo(load_ptr, store_ptr);
                            if (aa == AliasInfo::MustAlias) {
                                candidates.emplace_back(store);
                                break;
                            }
                            if (aa == AliasInfo::MayAlias) {
                                killers.emplace_back(inst);
                                break;
                            }
                        } else if (auto load2 = inst->as<LOADInst>()) {
                            auto load2_ptr = load2->getPtr();
                            auto aa = aa_res.getAliasInfo(load_ptr, load2_ptr);
                            if (aa == AliasInfo::MustAlias) {
                                candidates.emplace_back(load2);
                                break;
                            }
                        } else {
                            auto modref = aa_res.getInstModRefInfo(inst, load_ptr, fam);
                            if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef) {
                                // FIXME: VectorType here.
                                if (load->getType()->is<BType>()) {
                                    if (auto call = inst->as<CALLInst>()) {
                                        if (call->getFunc()->isIntrinsic() &&
                                            call->getFunc()->hasAttr(FuncAttr::isMemsetIntrinsic)) {
                                            candidates.emplace_back(inst);
                                            break;
                                        }
                                    }
                                }
                                killers.emplace_back(inst);
                                break;
                            }
                        }
                    }
                } else {
                    for (auto inst_rit = load_pred->crbegin(); inst_rit != load_pred->crend(); ++inst_rit) {
                        const auto &inst = *inst_rit;
                        auto modref = aa_res.getInstModRefInfo(inst, load_ptr, fam);
                        if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef) {
                            killers.emplace_back(inst);
                            break;
                        }
                    }
                }

                for (const auto &p : load_pred->preds()) {
                    if (visited.find(p) == visited.end())
                        worklist.emplace_back(p);
                }
            }

            PostDomTree *real_pdom;
            PostDomTreeBuilder pdbuilder;
            if (backedge_detected) {
                std::vector r_worklist{load_block};
                std::unordered_set<pBlock> r_visited;
                while (!r_worklist.empty()) {
                    auto curr = r_worklist.back();
                    r_visited.emplace(curr);
                    r_worklist.pop_back();
                    for (const auto &pred : curr->preds()) {
                        if (!r_visited.count(pred))
                            r_worklist.emplace_back(pred);
                    }
                }

                std::vector<std::pair<pBlock, pBlock>> unlinked;
                for (const auto &block : r_visited) {
                    auto succs = block->getNextBB();
                    for (const auto &succ : succs) {
                        if (!r_visited.count(succ)) {
                            unlinked.emplace_back(block, succ);
                            unlinkOneEdge(block, succ);
                        }
                    }
                }

                pdbuilder.entry = load_block.get();
                pdbuilder.analyze();
                real_pdom = &pdbuilder.domtree;

                for (const auto &pair : unlinked)
                    linkBB(pair.first, pair.second);
            } else
                real_pdom = &postdomtree;

            // Note that we have collected possible store/load in a post order.
            // In other word, candidates.back() is the earliest one in control flow.
            // Then we do forward traversal of the candidates. If one candidate
            // post dominates all other candidates and killers,
            // it is the most recent update on the load's memory.
            // That is to say, it is the one we should replace the load with.
            pInst target = nullptr;
            for (const auto &candidate : candidates) {
                Err::gassert(candidate->getParent() != load_block);
                bool able_to_replace = true;
                for (const auto &another : candidates) {
                    if (another == candidate)
                        continue;
                    // We only collect one candidate in a block.
                    Err::gassert(candidate->getParent() != another->getParent());
                    if (!real_pdom->ADomB(candidate->getParent(), another->getParent())) {
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
                    } else {
                        if (killer->getParent() == load_block) {
                            Err::gassert(killer->getIndex() > load->getIndex());
                            auto succs = load_block->getNextBB();
                            bool dom_all_succ = true;
                            for (const auto &succ : succs) {
                                if (!real_pdom->isReachable(succ))
                                    continue;

                                if (!real_pdom->ADomB(candidate->getParent(), succ)) {
                                    dom_all_succ = false;
                                    break;
                                }
                            }
                            if (!dom_all_succ) {
                                able_to_replace = false;
                                break;
                            }
                        } else if (!real_pdom->ADomB(candidate->getParent(), killer->getParent())) {
                            able_to_replace = false;
                            break;
                        }
                    }
                }
                if (able_to_replace) {
                    target = candidate;
                    break;
                }
            }

            if (target != nullptr) {
                if (auto target_load = target->as<LOADInst>()) {
                    load->replaceSelf(target_load);
                    unused_load.emplace(load);
                    Logger::logDebug("[LoadElim]: Replaced '", load->getName(), "' with '", target->getName(), "'.");
                } else if (auto target_store = target->as<STOREInst>()) {
                    load->replaceSelf(target_store->getValue());
                    unused_load.emplace(load);
                    Logger::logDebug("[LoadElim]: Replaced '", load->getName(), "' with '", target->getName(),
                                     "''s value.");
                } else if (auto target_call = target->as<CALLInst>()) {
                    Err::gassert(load->getType()->is<BType>() && target_call->getFunc()->isIntrinsic() &&
                                 target_call->getFunc()->hasAttr(FuncAttr::isMemsetIntrinsic));
                    if (load->getType()->as<BType>()->getInner() == IRBTYPE::I32)
                        load->replaceSelf(function.getConst(0));
                    else
                        load->replaceSelf(function.getConst(0.0f));
                    unused_load.emplace(load);
                    Logger::logDebug("[LoadElim]: Replaced '", load->getName(), "' with zero.");
                }
            }
        }

        // Delete unused loads immediately to avoid influence on preceding analysis
        load_elimination_inst_modified |= load_block->delInstIf(
            [&unused_load](const auto &inst) { return unused_load.find(inst) != unused_load.end(); },
            BasicBlock::DEL_MODE::NON_PHI);
        unused_load.clear();
    }

    return load_elimination_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR