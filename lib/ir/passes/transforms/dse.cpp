#include "../../../../include/ir/passes/transforms/dse.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <algorithm>

namespace IR {
PM::PreservedAnalyses DSEPass::run(Function &function, FAM &fam) {
    auto aa_res = fam.getResult<AliasAnalysis>(function);
    std::set<std::shared_ptr<Instruction>> eraseSet;
    for (const auto & store_block: function) {
        for (auto it = store_block->begin(); it != store_block->end(); ++it) {
            auto store = std::dynamic_pointer_cast<STOREInst>(*it);
            if (store == nullptr) continue;
            auto store_ptr = store->getPtr().get();

            bool overwritten = false;
            bool referenced = false;

            // Eliminate a store if overwritten
            for (auto inst_it = std::next(it); inst_it != store_block->end(); ++inst_it) {
                auto modref = aa_res.getInstModRefInfo(inst_it->get(), store_ptr, fam);
                if (modref == ModRefInfo::Ref || modref == ModRefInfo::ModRef) {
                    referenced = true;
                    break;
                }
                if (auto store2 = std::dynamic_pointer_cast<STOREInst>(*inst_it)) {
                    auto store2_ptr = store2->getPtr().get();
                    auto aa = aa_res.getAliasInfo(store_ptr, store2_ptr);
                    if (aa == AliasInfo::MustAlias)
                        overwritten = true;
                }
            }

            // Already referenced within the block, alive, go for the next store
            if (referenced)
                continue;

            // No referenced but overwritten within the block, dead, delete it
            if (overwritten) {
                eraseSet.insert(store);
                Logger::logDebug("[DSE] on '", function.getName(),
                    "': Store to '", store->getPtr()->getName(),
                    "' got overwritten within a block, deleted.");
            }
            // No referenced and no written and is points to a local memory
            // check other blocks to see if there is reference
            else if (aa_res.isLocal(store_ptr)) {
                Function::CFGDFVisitor dfv{store_block};
                for (const auto& candidate : dfv) {
                    for (const auto& inst : *candidate) {
                        auto modref = aa_res.getInstModRefInfo(inst.get(), store_ptr, fam);
                        if (modref == ModRefInfo::Ref || modref == ModRefInfo::ModRef) {
                            referenced = true;
                            break;
                        }
                    }
                    if (referenced) break;
                }
                if (!referenced) {
                    eraseSet.emplace(store);
                    Logger::logDebug("[DSE] on '", function.getName(),
                        "': Store to a local variable '", store->getPtr()->getName(),
                        "' has no reference in function, deleted.");
                }
            }
        }
    }

    bool dse_inst_modified = false;

    // erase dead inst
    for (auto &block : function) {
        dse_inst_modified |= block->delInstIf([&eraseSet](const auto &inst) {
            return eraseSet.find(inst) != eraseSet.end();
        });
    }

    if (dse_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}

} // namespace IR