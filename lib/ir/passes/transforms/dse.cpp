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
            bool has_read = std::any_of(std::next(it), block->end(),
                [this, &fam, &aliasResult, &store_ptr](const auto & inst) {
                    auto modref = aliasResult.
                    getInstModRefInfo(inst.get(), store_ptr, fam);
                    return modref == AliasAnalysisResult::ModRefInfo::Ref
                    || modref == AliasAnalysisResult::ModRefInfo::ModRef;});

            if (!has_read)
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