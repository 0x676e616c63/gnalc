// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/sir/passes/transforms/early_mem2reg.hpp"

#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/sir/base.hpp"
#include "../../../../include/sir/passes/analysis/instdom_analysis.hpp"
#include "../../../../include/sir/visitor.hpp"

namespace SIR {
// FIXME: Time-consuming
bool isInstExecuteExactlyOnce(Module* module, const pInst &inst) {
    auto once = module->lookupFunction(FuncAttr::ExecuteExactlyOnce);
    for (const auto &f : once) {
        auto lf = f->as<LinearFunction>();
        if (lf && IListContainsRecursive(lf->getInsts(), inst))
            return true;
    }
    return false;
}

PM::PreservedAnalyses EarlyPromotePass::run(LinearFunction &function, LFAM &lfam) {
    bool early_mem2reg_modified = false;

    auto& instdom = lfam.getResult<InstDomAnalysis>(function);

    std::vector<pVal> scalar_mem;
    for (const auto &inst : function.getInsts()) {
        auto alloc = inst->as<ALLOCAInst>();

        // alloca is always in the front of the function
        if (!alloc)
            break;

        // Only promote scalar and pointer types
        if (!alloc->getBaseType()->is<BType, PtrType>())
            continue;

        scalar_mem.emplace_back(alloc);
    }

    for (const auto &gv : function.getParent()->getGlobalVars()) {
        if (!gv->getVarType()->is<BType, PtrType>())
            continue;
        scalar_mem.emplace_back(gv);
    }

    for (const auto &mem : scalar_mem) {
        size_t store_cnt = 0;
        pStore mem_store = nullptr;
        std::unordered_set<pInst> loads;
        for (auto inst_user : mem->inst_users()) {
            if (auto store = inst_user->as<STOREInst>()) {
                if (++store_cnt > 1)
                    break;
                mem_store = store;
            } else if (auto load = inst_user->as<LOADInst>())
                loads.emplace(load);
            else
                Err::unreachable("Bad scalar user");
        }

        if (store_cnt == 0) {
            if (auto gv = mem->as<GlobalVariable>()) {
                pVal init_value;
                if (gv->getIniter().isZero())
                    init_value = function.getZero(gv->getVarType());
                else
                    init_value = gv->getIniter().getConstVal();

                for (const auto &load : loads)
                    load->replaceSelf(init_value);
                for (auto &func : function.getParent()->getLinearFunctions()) {
                    IListDelIfRecursive(func->getInsts(), [&](const auto &curr) {
                        return curr == mem || curr == mem_store || loads.count(curr);
                    });
                }
                Logger::logDebug("[EarlyMem2Reg]: Promoted '", mem->getName(), "'.");
            }
        }
        if (store_cnt == 1) {
            if (mem->is<GlobalVariable>()) {
                if (mem_store->getValue()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                    continue;
                // If the store can execute multiple times, give up
                if (!isInstExecuteExactlyOnce(function.getParent(), mem_store))
                    continue;

                for (const auto &load : loads)
                    load->replaceSelf(mem_store->getValue());

                for (auto &func : function.getParent()->getLinearFunctions()) {
                    IListDelIfRecursive(func->getInsts(), [&](const auto &curr) {
                        return curr == mem || curr == mem_store || loads.count(curr);
                    });
                }
            } else {
                // Instructions can become unreachable after CFGBuilder.
                // For example, function with multiple returns can let some instructions unreachable.
                if (!instdom.isReachableFromEntry(mem_store))
                    continue;

                auto dominates_all_loads = [&]() -> bool {
                    for (const auto& load : loads) {
                        if (!instdom.isReachableFromEntry(load))
                            continue;
                        if (!instdom.ADomB(mem_store, load))
                            return false;
                    }
                    return true;
                }();

                if (!dominates_all_loads)
                    continue;

                for (const auto &load : loads)
                    load->replaceSelf(mem_store->getValue());

                IListDelIfRecursive(function.getInsts(), [&](const auto &curr) {
                    return curr == mem || curr == mem_store || loads.count(curr);
                });
            }

            Logger::logDebug("[EarlyMem2Reg]: Promoted '", mem->getName(), "'.");
        }
    }

    return early_mem2reg_modified ? PreserveNone() : PreserveAll();
}
} // namespace SIR