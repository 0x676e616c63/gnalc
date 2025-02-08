#include "../../../../include/ir/passes/transforms/dse.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/instructions/memory.hpp"


namespace IR {
PM::PreservedAnalyses DSEPass::run(Function &function, FAM &fam) {
    auto aliasResult = fam.getResult<AliasAnalysis>(function);
    eraseSet.clear();
    for (auto &block : function) {
        std::vector<std::shared_ptr<STOREInst> > storeList;
        storeList.clear();
        for (auto &inst : block->getInsts()) {
            if (auto store = std::dynamic_pointer_cast<STOREInst>(inst))
                storeList.push_back(store);
        }
        for (auto &storeinst : storeList) {
            auto ptr = storeinst->getPtr();
            bool flag = false;

            for (auto &inst : block->getInsts()) {
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
                    } else if (aliasResult.getInstModRefInfo(inst.get(), ptr.get(), fam) == AliasAnalysisResult::ModRefInfo::Mod) {
                        flag = false;
                        break;
                    }
                }
            }

            if (flag)
                eraseSet.insert(storeinst);
        }
    }

    //eraser dead inst
    for (auto &block : function) {
        for (auto &inst : block->getInsts()) {
            if (auto storeInst = std::dynamic_pointer_cast<STOREInst>(inst)) {
                if (eraseSet.find(storeInst) != eraseSet.end())
                    block->delInst(inst);
            }
        }
    }

    bool dse_inst_modified = false;
    if (dse_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        return pa;
    }
    return PM::PreservedAnalyses::all();
}

} // namespace IR