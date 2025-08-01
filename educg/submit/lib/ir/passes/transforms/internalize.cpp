// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/transforms/internalize.hpp"
#include "../../../../include/config/config.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/target_analysis.hpp"

#include <algorithm>

namespace IR {

bool isReachableFromAToB(Function *a, Function *b) {
    if (a == b)
        return true;
    for (const auto &user : b->inst_users()) {
        auto user_func = user->getParent()->getParent().get();
        if (user_func == b)
            continue;
        if (isReachableFromAToB(a, user_func))
            return true;
    }
    return false;
}

PM::PreservedAnalyses InternalizePass::run(Function &function, FAM &fam) {
    // Internalize is safe if the functions execute exactly once.
    // Typically, this is a main function.
    if (!function.hasFnAttr(FuncAttr::ExecuteExactlyOnce))
        return PreserveAll();

    auto& target = fam.getResult<TargetAnalysis>(function);
    const auto size_threshold = target->getInternalizeSizeThreshold();

    bool internalize_inst_modified = false;
    const auto &module = function.getParent();
    const auto &global_vars = module->getGlobalVars();

    for (const auto &global_var : global_vars) {
        if (global_var->getUseCount() == 0)
            continue;

        auto type = getElm(global_var->getType());
        if (type->getBytes() > size_threshold)
            continue;

        bool safe_to_internalize = true;
        bool have_use_in_curr_func = false;
        for (const auto &inst_user : global_var->inst_users()) {
            auto user_func = inst_user->getParent()->getParent().get();
            if (user_func != &function && isReachableFromAToB(&function, user_func)) {
                safe_to_internalize = false;
                break;
            }

            if (user_func == &function)
                have_use_in_curr_func = true;

            // Already internalized
            if (auto call = inst_user->as<CALLInst>()) {
                if (call->getFunc()->getIntrinsicID() == IntrinsicID::Memcpy ||
                    call->getFunc()->getIntrinsicID() == IntrinsicID::Memset) {
                    safe_to_internalize = false;
                    break;
                }
            }
        }

        if (!have_use_in_curr_func || !safe_to_internalize)
            continue;

        auto name = "%" + global_var->getName().substr(1) + ".in";
        auto alloca_inst = std::make_shared<ALLOCAInst>(name, type, global_var->getAlign());
        alloca_inst->attr().add(InternalizeAttrs{InternalizeAttr::InternalizedGlobalArray});

        auto use_list = global_var->getUseList();
        for (const auto &use : use_list) {
            auto user_func = use->getUser()->as<Instruction>()->getParent()->getParent().get();
            if (user_func == &function)
                use->setValue(alloca_inst);
        }

        auto entry = *function.begin();
        entry->addInstAfterPhi(alloca_inst);

        auto insert_before = entry->begin();
        while (insert_before != entry->end() && (*insert_before)->is<ALLOCAInst>())
            ++insert_before;

        // Init
        if (global_var->isArray()) {
            auto initer = global_var->getIniter();
            if (initer.isZero()) {
                auto builtin_memset = module->lookupFunction(Config::IR::MEMSET_INTRINSIC_NAME);
                auto call_memset = std::make_shared<CALLInst>(
                    builtin_memset,
                    std::vector<pVal>{alloca_inst,                                           // ptr
                                      function.getConst(static_cast<char>(0)),               // val
                                      function.getConst(static_cast<int>(type->getBytes())), // length
                                      function.getConst(false)});
                entry->addInst(insert_before, call_memset);
            } else {
                auto builtin_memcpy = module->lookupFunction(Config::IR::MEMCPY_INTRINSIC_NAME);
                auto call_memcpy = std::make_shared<CALLInst>(
                    builtin_memcpy,
                    std::vector<pVal>{alloca_inst,                                           // ptr
                                      global_var,                                            // ptr
                                      function.getConst(static_cast<int>(type->getBytes())), // length
                                      function.getConst(false)});
                entry->addInst(insert_before, call_memcpy);
            }
        } else {
            auto initer = global_var->getIniter();
            pVal init_val;
            if (initer.isZero()) {
                Err::gassert(type->is<BType>());
                if (type->as<BType>()->getInner() == IRBTYPE::FLOAT)
                    init_val = function.getConst(0.0f);
                else
                    init_val = function.getConst(0);
            } else
                init_val = initer.getConstVal();
            Err::gassert(init_val != nullptr, "Invalid Global Variable");
            auto store_inst = std::make_shared<STOREInst>(init_val, alloca_inst);
            entry->addInst(insert_before, store_inst);
        }

        Logger::logDebug("[Internalize]: Internalized global variable '", global_var->getName(), "' to '",
                         function.getName(), "'.");

        internalize_inst_modified = true;
    }

    return internalize_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR