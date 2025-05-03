#include "ir/passes/transforms/dse.hpp"

#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"

#include <algorithm>

namespace IR {
PM::PreservedAnalyses DSEPass::run(Function &function, FAM &fam) {
    bool dse_inst_modified = false;

    auto &aa_res = fam.getResult<AliasAnalysis>(function);
    auto &domtree = fam.getResult<DomTreeAnalysis>(function);
    auto &postdomtree = fam.getResult<PostDomTreeAnalysis>(function);
    std::set<pInst> unused_store;

    // For each store, collect all possible store on its post dominator block as candidates.
    // Then we consider all other blocks that the block can reach,
    // instructions in them serves as a killer if it may reference the store's memory.
    // If one candidate dominates the rest of candidates and all killers,
    // it is the most recent modification on the store's memory. And we can delete the earlier store.
    auto dfv = function.getDFVisitor();
    for (const auto &store_block : dfv) {
        for (auto it = store_block->begin(); it != store_block->end(); ++it) {
            auto store = (*it)->as<STOREInst>();
            if (store == nullptr)
                continue;
            auto store_ptr = store->getPtr();

            bool erased = false;
            bool killed = false;

            // Eliminate a store if overwritten
            for (auto inst_it = std::next(it); inst_it != store_block->end(); ++inst_it) {
                auto modref = aa_res.getInstModRefInfo(*inst_it, store_ptr, fam);
                if (auto store2 = (*inst_it)->as<STOREInst>()) {
                    auto store2_ptr = store2->getPtr();
                    auto aa = aa_res.getAliasInfo(store_ptr, store2_ptr);
                    if (aa == AliasInfo::MustAlias) {
                        erased = true;
                        unused_store.insert(store);
                        break;
                    }
                } else if (modref == ModRefInfo::Ref || modref == ModRefInfo::ModRef) {
                    killed = true;
                    break;
                }
            }

            // Already referenced within the block, alive, go for the next store.
            // Or already erased, skip it.
            if (killed || erased)
                continue;

            // Eliminate a store if useless
            // %1 = load ptr %x
            // <no modification of %x>
            // %2 = store %1 ptr %x
            auto rit = std::make_reverse_iterator(it);
            for (auto inst_rit = std::next(rit); inst_rit != store_block->rend(); ++inst_rit) {
                auto modref = aa_res.getInstModRefInfo(*inst_rit, store_ptr, fam);
                if (auto load = (*inst_rit)->as<LOADInst>()) {
                    if (store->getValue() == load) {
                        if (aa_res.getAliasInfo(load->getPtr(), store_ptr) == AliasInfo::MustAlias) {
                            erased = true;
                            unused_store.insert(store);
                            break;
                        }
                    }
                } else if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef)
                    break;
            }

            if (erased)
                continue;

            // Not local memory. Reference may happen outside the function.
            if (!aa_res.isLocal(store_ptr)) {
                auto real_store_ptr = store_ptr;
                while (auto gep = real_store_ptr->as<GEPInst>())
                    real_store_ptr = gep->getPtr();
                if (real_store_ptr->getVTrait() == ValueTrait::GLOBAL_VARIABLE) {
                    std::deque worklist{real_store_ptr};
                    while (!worklist.empty()) {
                        auto curr = worklist.front();
                        worklist.pop_front();
                        for (const auto &user : curr->inst_users()) {
                            if (user->getOpcode() != OP::STORE && user->getOpcode() != OP::GEP) {
                                killed = true;
                                break;
                            }
                            if (user->getOpcode() == OP::GEP)
                                worklist.emplace_back(user);
                        }
                        if (killed)
                            break;
                    }
                    if (!killed) {
                        unused_store.emplace(store);
                        continue;
                    }
                } else if (real_store_ptr->getVTrait() == ValueTrait::FORMAL_PARAMETER) {
                    // TODO: check caller's actual argument.
                    continue;
                }
            }
            // local memory, check through CFG.
            else {
                std::set<pBlock> visited;
                std::deque<pBlock> worklist{store_block->succ_begin(), store_block->succ_end()};
                // STOREInst that may contribute to the elimination
                std::vector<pStore> candidates;
                std::vector<pInst> killers;
                while (!worklist.empty()) {
                    auto store_succ = worklist.front();
                    visited.emplace(store_succ);
                    worklist.pop_front();

                    // If a block properly post-dominates the store block, we can eliminate the store
                    // if there is a store in it. If not, we still need to look at it
                    // to figure out if there is something could kill the opportunity.
                    if (store_succ != store_block && postdomtree.ADomB(store_succ, store_block)) {
                        for (const auto &inst : *store_succ) {
                            // We only collect the first possible store in a block,
                            // So once we find one, break.
                            if (auto store2 = inst->as<STOREInst>()) {
                                auto store2_ptr = store2->getPtr();
                                auto aa = aa_res.getAliasInfo(store2_ptr, store_ptr);
                                if (aa == AliasInfo::MustAlias) {
                                    candidates.emplace_back(store);
                                    break;
                                }
                            } else {
                                auto modref = aa_res.getInstModRefInfo(inst, store_ptr, fam);
                                if (modref == ModRefInfo::Ref || modref == ModRefInfo::ModRef) {
                                    killers.emplace_back(inst);
                                    break;
                                }
                            }
                        }
                    } else {
                        for (const auto &inst : *store_succ) {
                            auto modref = aa_res.getInstModRefInfo(inst, store_ptr, fam);
                            if (modref == ModRefInfo::Ref || modref == ModRefInfo::ModRef) {
                                killers.emplace_back(inst);
                                break;
                            }
                        }
                    }

                    for (const auto &p : store_succ->succs()) {
                        if (visited.find(p) == visited.end())
                            worklist.emplace_back(p);
                    }
                }

                if (killers.empty()) // A store with no reference, erase it.
                    unused_store.emplace(store);
                else {
                    // Note that we have collected possible store in a pre-order.
                    // In other words, candidates[0] is the earliest one in control flow.
                    // Then we do forward traversal of the candidates. If one candidate
                    // dominates all other candidates and killers,
                    // it is the most recent modification on the store's memory.
                    // That is to say, it is that store who gives us opportunities to eliminate a store.
                    bool found_one = false;
                    for (const auto &candidate : candidates) {
                        bool able_to_delete = true;
                        for (const auto &another : candidates) {
                            if (another == candidate)
                                continue;
                            // We only collect one candidate in a block.
                            Err::gassert(candidate->getParent() != another->getParent());
                            if (!domtree.ADomB(candidate->getParent(), another->getParent())) {
                                able_to_delete = false;
                                break;
                            }
                        }
                        for (const auto &killer : killers) {
                            if (killer->getParent() == candidate->getParent()) {
                                if (killer->getIndex() < candidate->getIndex()) {
                                    able_to_delete = false;
                                    break;
                                }
                            } else if (!postdomtree.ADomB(candidate->getParent(), killer->getParent())) {
                                able_to_delete = false;
                                break;
                            }
                        }
                        if (able_to_delete) {
                            found_one = true;
                            break;
                        }
                    }
                    if (found_one)
                        unused_store.emplace(store);
                }
            }
        }

        // Delete unused stores immediately to avoid influence on preceding analysis
        dse_inst_modified |= store_block->delInstIf(
            [&unused_store](const auto &inst) { return unused_store.find(inst) != unused_store.end(); },
            BasicBlock::DEL_MODE::NON_PHI);
        unused_store.clear();
    }

    // Eliminate useless memset intrinsic
    // Currently memset intrinsic only occurs at the entry block
    auto entry_block = function.getBlocks().front();
    std::unordered_set<pInst> unused_mem;
    for (const auto &inst : *entry_block) {
        if (auto call = inst->as<CALLInst>()) {
            if (call->getFunc()->hasAttr(FuncAttr::isMemsetIntrinsic)) {
                auto ptr = call->getArgs()[0];
                Err::gassert(ptr->getType()->is<PtrType>());
                if (ptr->getUseCount() != 1)
                    continue;

                if (auto bitcast = ptr->as<BITCASTInst>()) {
                    if (!bitcast->getOVal()->is<ALLOCAInst>() || bitcast->getOVal()->getUseCount() != 1)
                        continue;
                    unused_mem.emplace(call);
                    unused_mem.emplace(bitcast);
                    unused_mem.emplace(bitcast->getOVal()->as<Instruction>());
                } else if (auto alloc = ptr->as<ALLOCAInst>()) {
                    unused_mem.emplace(call);
                    unused_mem.emplace(alloc);
                }
            }
        }
    }
    dse_inst_modified |=
        entry_block->delInstIf([&unused_mem](const auto &inst) { return unused_mem.find(inst) != unused_mem.end(); },
                               BasicBlock::DEL_MODE::NON_PHI);

    return dse_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR