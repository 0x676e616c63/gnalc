#include "../../../../include/ir/passes/transforms/dse.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/instructions/memory.hpp"


namespace IR {
PM::PreservedAnalyses DSEPass::run(Function &function, FAM &fam) {
    auto aliasResult = fam.getResult<AliasAnalysis>(function);

    std::set<std::shared_ptr<STOREInst>> eraseSet;
    eraseSet.clear();

    for (const auto & block:function) {
        auto iter1=block->begin();
        while (iter1!=block->end()) {
            auto iter2=iter1;
            if (auto storeInst=std::dynamic_pointer_cast<STOREInst>(*iter1)) {
                bool flag=true;
                iter2++;
                while (iter2!=block->end()) {
                    if (flag) {
                        if (auto tempStoreInst = std::dynamic_pointer_cast<STOREInst>(*iter2)) {
                            auto tempPtr = tempStoreInst->getPtr();
                            if (aliasResult.getAliasInfo(storeInst->getPtr().get(), tempPtr.get()) == AliasAnalysisResult::AliasInfo::MustAlias) {
                                tempStoreInst->replaceSelf(storeInst);
                            }
                        } else {
                            auto modref = aliasResult.getInstModRefInfo((*iter2).get(), storeInst->getPtr().get(), fam);
                            if (modref == AliasAnalysisResult::ModRefInfo::Mod || modref == AliasAnalysisResult::ModRefInfo::ModRef)
                            {
                                flag = false;
                                break;
                            }
                        }
                    }
                }
                if (flag)
                    eraseSet.insert(storeInst);
            }
            else ++iter1;
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