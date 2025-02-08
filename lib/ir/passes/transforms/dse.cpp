#include "../../../../include/ir/passes/transforms/dse.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/instructions/memory.hpp"


namespace IR {
PM::PreservedAnalyses DSEPass::run(Function &function, FAM &fam) {
    auto aliasResult = fam.getResult<AliasAnalysis>(function);

    std::set<std::shared_ptr<STOREInst>> eraseSet;
    eraseSet.clear();
    for (const auto &block : function) {
        std::vector<std::shared_ptr<STOREInst> > storeList;
        for (const auto &inst : *block) {
            if (auto store = std::dynamic_pointer_cast<STOREInst>(inst))
                storeList.push_back(store);
        }
        for (const auto &storeinst : storeList) {
            auto ptr = storeinst->getPtr();
            bool flag = false;

            for (const auto &inst : *block) {
                if (auto tempStoreInst = std::dynamic_pointer_cast<STOREInst>(inst)) {
                    if (tempStoreInst == storeinst) {
                        flag = true;
                        continue;
                    }
                }
                if (flag) {
                    if (auto tempStoreInst = std::dynamic_pointer_cast<STOREInst>(inst)) {
                        auto tempPtr = tempStoreInst->getPtr();
                        if (aliasResult.getAliasInfo(ptr.get(), tempPtr.get()) == AliasAnalysisResult::AliasInfo::MustAlias) {
                            tempStoreInst->replaceSelf(storeinst);
                        }
                    } else {
                        auto modref = aliasResult.getInstModRefInfo(inst.get(), ptr.get(), fam);
                        if (modref == AliasAnalysisResult::ModRefInfo::Mod || modref == AliasAnalysisResult::ModRefInfo::ModRef)
                        {
                            flag = false;
                            break;
                        }
                    }
                }
            }

            if (flag)
                eraseSet.insert(storeinst);
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