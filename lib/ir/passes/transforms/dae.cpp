// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/dae.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/passes/analysis/loop_alias_analysis.hpp"

#include <optional>
#include <string>
#include <vector>

namespace IR {
PM::PreservedAnalyses DAEPass::run(Function &func, FAM &fam) {
    bool dae_inst_modified = false;
    std::unordered_map<pFormalParam, pVal> param_map;
    std::unordered_map<pVal, size_t> offset_map;
    // Replace Constant Function Argument
    for (const auto &inst_user : func.inst_users()) {
        auto call = inst_user->as<CALLInst>();
        Err::gassert(call != nullptr);
        if (call->getFunc().get() != &func)
            continue;
        auto caller_func = call->getParent()->getParent();
        auto actual_args = call->getArgs();
        auto aa_res = fam.getResult<LoopAliasAnalysis>(*call->getParent()->getParent());
        for (const auto &fp : func.getParams()) {
            const auto &arg = actual_args[fp->getIndex()];
            if (arg->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
                auto prev = param_map.find(fp);
                if (prev != param_map.end()) {
                    if (!prev->second || prev->second != arg)
                        param_map[fp] = nullptr;
                } else
                    param_map[fp] = arg;
            } else if (arg->getType()->getTrait() == IRCTYPE::PTR) {
                auto opt = aa_res.getBaseAndOffset(arg);
                if (!opt) {
                    param_map[fp] = nullptr;
                    continue;
                }
                auto [base, offset] = *opt;
                if (base->getVTrait() != ValueTrait::GLOBAL_VARIABLE) {
                    param_map[fp] = nullptr;
                    continue;
                }

                auto prev = param_map.find(fp);
                if (prev != param_map.end()) {
                    if (!prev->second)
                        param_map[fp] = nullptr;
                    else {
                        if (prev->second.get() != base || offset_map.at(prev->second) != offset)
                            param_map[fp] = nullptr;
                    }
                } else {
                    param_map[fp] = base->as<Value>();
                    offset_map[base->as<Value>()] = offset;
                }
            } else
                param_map[fp] = nullptr;
        }
    }

    for (const auto &[fp, val] : param_map) {
        if (!val)
            continue;

        if (val->getVTrait() == ValueTrait::CONSTANT_LITERAL)
            fp->replaceSelf(val);
        else {
            Err::gassert(val->getVTrait() == ValueTrait::GLOBAL_VARIABLE);
            auto offset = offset_map.at(val);
            auto to_replace = val;
            auto entry = func.getBlocks().front();
            BBInstIter insert_point;
            for (auto it = entry->begin(); it != entry->end(); it++) {
                if (!(*it)->is<ALLOCAInst>()) {
                    insert_point = it;
                    break;
                }
            }
            if (offset != 0) {
                auto gep = std::make_shared<GEPInst>("%dae." + std::to_string(name_cnt++), val,
                                                     func.getConst(static_cast<int>(offset)));
                if (gep->getType() != fp->getType()) {
                    auto bitcast =
                        std::make_shared<BITCASTInst>("%dae." + std::to_string(name_cnt++), gep, fp->getType());
                    to_replace = bitcast;
                    entry->addInst(insert_point, bitcast);
                    entry->addInst(insert_point, gep);
                } else {
                    to_replace = gep;
                    entry->addInst(insert_point, gep);
                }
            } else {
                auto bitcast = std::make_shared<BITCASTInst>("%dae." + std::to_string(name_cnt++), val, fp->getType());
                to_replace = bitcast;
                entry->addInst(insert_point, bitcast);
            }
            fp->replaceSelf(to_replace);
        }
        dae_inst_modified = true;

        {
            std::string type_str;
            if (val->getVTrait() == ValueTrait::CONSTANT_LITERAL)
                type_str = "Constant";
            else if (val->getVTrait() == ValueTrait::GLOBAL_VARIABLE)
                type_str = "GlobalVariable(with offset)";
            else
                Err::unreachable();

            Logger::logDebug("[DAE] on '", func.getName(), "': Replacing param '", fp->getName(), "' with ", type_str,
                             " '", val->getName(), "'.");
        }
    }

    // Deleting no-use params does not invalidate any analysis.
    // But modifying caller function's CALLInst can sometimes invalidate analysis.
    // However, analysis so far does not get invalidated, since we only replace
    // int/float/GlobalVariable and only deleting no-use params.
    // FIXME: Future analysis can be invalidated. Fix the PassManager.
    auto params = func.getParams();
    for (const auto &fp : params) {
        if (fp->getUseCount() == 0) {
            func.removeParam(fp->getIndex());
            for (const auto &inst_user : func.inst_users()) {
                auto call = inst_user->as<CALLInst>();
                Err::gassert(call != nullptr);
                if (call->getFunc().get() != &func)
                    continue;
                call->removeArg(fp->getIndex());
            }
            Logger::logDebug("[DAE] on '", func.getName(), "': Deleting param '", fp->getName(), "'.");
        }
    }

    if (func.isRecursive() && dae_inst_modified)
        Logger::logDebug("[DAE]: on '", func.getName(), "': Eliminated dead arguments on a recursive function.");

    name_cnt = 0;

    return dae_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR