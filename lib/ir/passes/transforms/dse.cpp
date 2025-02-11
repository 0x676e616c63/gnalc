#include "../../../../include/ir/passes/transforms/dse.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <algorithm>

namespace IR {
PM::PreservedAnalyses DSEPass::run(Function &function, FAM &fam) {
    auto aliasResult = fam.getResult<AliasAnalysis>(function);

    std::set<std::shared_ptr<Instruction>> eraseSet;
    for (const auto & block: function) {
        for (auto it = block->begin(); it != block->end(); ++it) {
            auto store = std::dynamic_pointer_cast<STOREInst>(*it);
            if (store == nullptr) continue;

            // Eliminate a store if there is no reference to that memory.
            // Note that duplicate store to the same location will also be eliminated.
            auto store_ptr = store->getPtr().get();
            bool should_eliminate = true; // Agressive
            for (auto it2 = std::next(it); it2 != block->end(); ++it2) {
                auto modref = aliasResult.getInstModRefInfo(it2->get(), store_ptr, fam);
                // 存在 Reference 就不能消除
                if (modref == AliasAnalysisResult::ModRefInfo::Ref || modref == AliasAnalysisResult::ModRefInfo::ModRef) {
                    should_eliminate = false;
                    break;
                }
                // 存在 Mod 就不用往后看了
                if (modref == AliasAnalysisResult::ModRefInfo::Mod)
                    break;
            }

            if (should_eliminate)
                eraseSet.emplace(store);
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