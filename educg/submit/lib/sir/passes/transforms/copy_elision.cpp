// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/sir/passes/transforms/copy_elision.hpp"

#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/sir/base.hpp"
#include "../../../../include/sir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/sir/visitor.hpp"

namespace SIR {
PM::PreservedAnalyses CopyElisionPass::run(LinearFunction &function, LFAM &lfam) {
    std::vector<pVal> memorys;
    for (const auto &inst : function) {
        if (auto alloc = inst->as<ALLOCAInst>()) {
            if (!alloc->getBaseType()->is<ArrayType>())
                continue;
            memorys.emplace_back(alloc);
        } else
            break;
    }
    for (const auto& gv : function.getParent()->getGlobalVars()) {
        if (!gv->getVarType()->is<ArrayType>() || gv->getStorageClass() == STOCLASS::CONSTANT)
            continue;
        memorys.emplace_back(gv);
    }

    struct Candidate {
        pVal memory;
        pStore store;
        size_t store_cnt;
    };
    std::vector<Candidate> candidates;
    for (const auto &mem : memorys) {
        pStore store = nullptr;
        size_t store_cnt = 0;
        for (const auto &user : mem->inst_users()) {
            if (auto curr_store = user->as<STOREInst>()) {
                store = curr_store;
                if (++store_cnt > 1)
                    break;
            }
        }
        if (store_cnt == 0)
            candidates.emplace_back(Candidate{mem, nullptr, 0});
        else if (store_cnt == 1)
            candidates.emplace_back(Candidate{mem, store, 1});
    }

    if (candidates.empty())
        return PreserveAll();

    auto &laa_res = lfam.getResult<LAliasAnalysis>(function);
    for (const auto &[mem, store, store_cnt] : candidates) {
        if (store_cnt == 0) {
            // For const global arrays, just set it const and let LoadElim in IR deal with them.
            if (auto gv = mem->as<GlobalVariable>()) {
                gv->setAsConst();
                Logger::logDebug("[CopyElision] Set Global Array '", gv->getName(), "' as const");
            }
            else
                Logger::logWarning("[CopyElision]: Found uninitialized local array.");
        } else if (store_cnt == 1) {
            // TODO here
        }
    }

    return PreserveNone();
}
} // namespace SIR