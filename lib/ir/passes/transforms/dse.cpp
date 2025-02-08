#include "../../../../include/ir/passes/transforms/dse.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/instructions/memory.hpp"


namespace IR {
PM::PreservedAnalyses DSEPass::run(Function &function, FAM &fam) {
    auto aliasResult = fam.getResult<AliasAnalysis>(function);

    std::set<std::shared_ptr<Instruction>> eraseSet;
    for (const auto & block: function) {
        for (auto iter1 = block->begin(); iter1 != block->end(); ++iter1) {
            auto store1 = std::dynamic_pointer_cast<STOREInst>(*iter1);
            if (store1 == nullptr)
                continue;

            auto store1_ptr = store1->getPtr().get();
            for (auto iter2 = std::next(iter1); iter2 != block->end(); ++iter2) {
                if (auto store2 = std::dynamic_pointer_cast<STOREInst>(*iter2)) {
                    auto store2_ptr = store2->getPtr().get();
                    if (aliasResult.getAliasInfo(store1_ptr, store2_ptr)
                            == AliasAnalysisResult::AliasInfo::MustAlias) {
                        store2->replaceSelf(store1);
                        eraseSet.emplace(store2);
                    }
                } else {
                    auto modref = aliasResult.getInstModRefInfo(iter2->get(), store1_ptr, fam);
                    if (modref == AliasAnalysisResult::ModRefInfo::Mod || modref == AliasAnalysisResult::ModRefInfo::ModRef)
                        break;
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