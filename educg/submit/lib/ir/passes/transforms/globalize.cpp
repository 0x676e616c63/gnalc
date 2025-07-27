// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/transforms/globalize.hpp"
#include "../../../../include/config/config.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/target_analysis.hpp"
#include "../../../../include/ir/passes/transforms/internalize.hpp"

#include <algorithm>

namespace IR {

PM::PreservedAnalyses GlobalizePass::run(Function &function, FAM &fam) {
    auto &target = fam.getResult<TargetAnalysis>(function);
    const auto threshold = target->getGlobalizeSizeThreshold();

    auto entry = function.getBlocks().front();
    std::vector<pAlloca> candidates;
    for (const auto &inst : *entry) {
        if (auto alloc = inst->as<ALLOCAInst>()) {
            if (alloc->isArray() && alloc->getBaseType()->getBytes() > threshold)
                candidates.push_back(alloc);
        } else
            break;
    }

    if (candidates.empty())
        return PreserveAll();

    auto module = function.getParent();
    std::unordered_set<pInst> dead;
    for (const auto &alloc : candidates) {
        if (auto inattrs = alloc->attr().get<InternalizeAttrs>();
            inattrs && inattrs->has(InternalizeAttr::InternalizedGlobalArray)) {
            Logger::logDebug("[Globalize]: Trying to globalize an internalized global array '",
                alloc->getName(), "'?");
        }

        GVIniter initer(alloc->getBaseType());

        // Now fill the initer, and emit a memcpy to reset the global each time.
        // for (const auto& inst : *entry) {
        //     if (auto call = inst->as<CALLInst>()) {
        //         if (call->getFunc()->hasFnAttr(FuncAttr::isMemsetIntrinsic))
        //             dead.emplace(call);
        //     } else if (auto store = inst->as<STOREInst>()) {
        //         if (auto gep = store->getPtr()->as<GEPInst>()) {
        //             if (store->getValue()->getVTrait() == ValueTrait::CONSTANT_LITERAL
        //                 && gep->isConstantOffset()) {
        //                 // TODO
        //             }
        //         }
        //
        //     }
        // }

        dead.emplace(alloc);

        auto gv_name = Config::IR::GLOBALIZE_NAME_PREFIX + std::string{"."} + function.getName().substr(1) + "." +
               alloc->getName().substr(1);
        auto gv = std::make_shared<GlobalVariable>(STOCLASS::GLOBAL, alloc->getBaseType(), gv_name,
                                                   initer, alloc->getAlign());
        gv->attr().add(GlobalizeAttrs{GlobalizeAttr::GlobalizedLocalArray});
        module->addGlobalVar(gv);
        alloc->replaceSelf(gv);

        Logger::logDebug("[Globalize]: Globalized '", alloc->getName(), "' to '", gv_name, "'.");
    }

    entry->delInstIf([&](const pInst &inst) { return dead.count(inst); });

    return PreserveCFGAnalyses();
}

} // namespace IR