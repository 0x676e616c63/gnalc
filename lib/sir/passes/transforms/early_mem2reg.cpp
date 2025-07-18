// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/early_mem2reg.hpp"

#include "ir/instructions/memory.hpp"
#include "sir/base.hpp"
#include "sir/visitor.hpp"

namespace SIR {
PM::PreservedAnalyses EarlyPromotePass::run(LinearFunction &function, LFAM &lfam) {
    bool early_mem2reg_modified = false;

    std::vector<pVal> scalar_mem;
    for (const auto &inst : function.getInsts()) {
        auto alloc = inst->as<ALLOCAInst>();

        // alloca is always in the front of the function
        if (!alloc)
            break;

        // Only promote scalar types
        if (!alloc->getBaseType()->is<BType>())
            continue;

        scalar_mem.emplace_back(alloc);
    }

    for (const auto &gv : function.getParent()->getGlobalVars()) {
        if (!gv->getVarType()->is<BType>())
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
                for (const auto &load : loads)
                    load->replaceSelf(gv->getIniter().getConstVal());
                for (auto &func : function.getParent()->getLinearFunctions()) {
                    IListDelIfRecursive(func->getInsts(), [&](const auto &curr) {
                        return curr == mem || curr == mem_store || loads.count(curr);
                    });
                }
                Logger::logDebug("[EarlyMem2Reg]: Promoted '", mem->getName(), "'.");
            }
            else Logger::logWarning("[EarlyMem2Reg]: No store found for local memory");
        }
        if (store_cnt == 1) {
            for (const auto &load : loads)
                load->replaceSelf(mem_store->getValue());

            if (mem->is<GlobalVariable>()) {
                for (auto &func : function.getParent()->getLinearFunctions()) {
                    IListDelIfRecursive(func->getInsts(), [&](const auto &curr) {
                        return curr == mem || curr == mem_store || loads.count(curr);
                    });
                }
            } else {
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