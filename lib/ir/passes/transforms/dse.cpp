#include "../../../../include/ir/passes/transforms/dse.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"

#include <algorithm>

namespace IR {
PM::PreservedAnalyses DSEPass::run(Function &function, FAM &fam) {
    bool dse_inst_modified = false;

    auto aa_res = fam.getResult<AliasAnalysis>(function);
    auto domtree = fam.getResult<DomTreeAnalysis>(function);
    auto postdomtree = fam.getResult<PostDomTreeAnalysis>(function);
    std::set<std::shared_ptr<Instruction>> unused_store;

    // For each store, collect all possible store on its post dominator block as candidates.
    // Then we consider all other blocks that the block can reach,
    // instructions in them serves as a killer if it may reference the store's memory.
    // If one candidate dominates the rest of candidates and all killers,
    // it is the most recent modify on the store's memory. And we can delete the earlier store.
    auto dfv = function.getDFVisitor();
    for (const auto &store_block : dfv) {
        for (auto it = store_block->begin(); it != store_block->end(); ++it) {
            auto store = std::dynamic_pointer_cast<STOREInst>(*it);
            if (store == nullptr)
                continue;
            auto store_ptr = store->getPtr().get();

            bool erased = false;
            bool killed = false;

            // Eliminate a store if overwritten
            for (auto inst_it = std::next(it); inst_it != store_block->end(); ++inst_it) {
                auto modref = aa_res.getInstModRefInfo(inst_it->get(), store_ptr, fam);
                if (auto store2 = std::dynamic_pointer_cast<STOREInst>(*inst_it)) {
                    auto store2_ptr = store2->getPtr().get();
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
            if (killed)
                continue;

            // Already erased, skip it.
            if (erased)
                continue;

            // Not local memory. Reference may happen outside the function, skip it.
            if (!aa_res.isLocal(store_ptr))
                continue;

            auto successors = store_block->getNextBB();
            std::set<std::shared_ptr<BasicBlock>> visited;
            std::deque<std::shared_ptr<BasicBlock>> worklist{successors.begin(), successors.end()};
            // STOREInst that may contribute to the elimination
            std::vector<std::shared_ptr<STOREInst>> candidates;
            std::vector<std::shared_ptr<Instruction>> killers;
            while (!worklist.empty()) {
                auto store_succ = worklist.front();
                visited.emplace(store_succ);
                worklist.pop_front();

                // If we meet the store block again, there is a back edge, and thus we should
                // consider the instructions that before the store we want to eliminate. If there is
                // a Reference on that memory, it is not safe to eliminate the store.
                // For other blocks, if it post dominates the store block, we can eliminate the store
                // if there is a store in the post dominator block. If not, we still need to look at it
                // to figure out if there is something could kill the opportunity.
                if (store_succ != store_block && postdomtree.ADomB(store_succ.get(), store_block.get())) {
                    for (const auto &inst : *store_succ) {
                        // We only collect the first possible store in a block,
                        // So once we find one, break.
                        if (auto store2 = std::dynamic_pointer_cast<STOREInst>(inst)) {
                            auto store2_ptr = store2->getPtr().get();
                            auto aa = aa_res.getAliasInfo(store2_ptr, store_ptr);
                            if (aa == AliasInfo::MustAlias) {
                                candidates.emplace_back(store);
                                break;
                            }
                        }
                        else {
                            auto modref = aa_res.getInstModRefInfo(inst.get(), store_ptr, fam);
                            if (modref == ModRefInfo::Ref || modref == ModRefInfo::ModRef) {
                                killers.emplace_back(inst);
                                break;
                            }
                        }
                    }
                } else {
                    for (const auto &inst : *store_succ) {
                        auto modref = aa_res.getInstModRefInfo(inst.get(), store_ptr, fam);
                        if (modref == ModRefInfo::Ref || modref == ModRefInfo::ModRef) {
                            killers.emplace_back(inst);
                            break;
                        }
                    }
                }

                auto succs = store_succ->getNextBB();
                for (const auto &p : succs) {
                    if (visited.find(p) == visited.end())
                        worklist.emplace_back(p);
                }
            }

            if (killers.empty()) // A store with no reference, erase it.
                unused_store.emplace(store);
            else {
                // Note that we have collect possible store in a pre-order.
                // In other word, candidates[0] is the earliest one in control flow.
                // Then we do forward traversal of the candidates. If one candidate
                // dominates all other candidate and killers,
                // it is the most recent modify on the store's memory.
                // That is to say, it is that store who gives us opportunity to eliminate a store.
                bool found_one = false;
                for (const auto &candidate : candidates) {
                    bool able_to_delete = true;
                    for (const auto &another : candidates) {
                        if (another == candidate)
                            continue;
                        // We only collect one candidate in a block.
                        Err::gassert(candidate->getParent() != another->getParent());
                        if (!domtree.ADomB(candidate->getParent().get(), another->getParent().get())) {
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
                        } else if (!postdomtree.ADomB(candidate->getParent().get(), killer->getParent().get())) {
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

        // Delete unused stores immediately to avoid influence on preceding analysis
        dse_inst_modified |= store_block->delInstIf(
            [&unused_store](const auto &inst) { return unused_store.find(inst) != unused_store.end(); },
            BasicBlock::DEL_MODE::NON_PHI);
        unused_store.clear();
    }

    if (dse_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        pa.preserve<LoopAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}

} // namespace IR