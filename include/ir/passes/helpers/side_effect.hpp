#pragma once
#ifndef GNALC_IR_PASSES_HELPER_SIDE_EFFECT_HPP
#define GNALC_IR_PASSES_HELPER_SIDE_EFFECT_HPP

#include "../../../config/config.hpp"
#include "../../base.hpp"
#include "../../instructions/control.hpp"
#include "../analysis/alias_analysis.hpp"

namespace IR {
inline bool hasSideEffect(FAM &fam, const CALLInst *call) {
    const auto call_fn = call->getFunc().get();
    if (call_fn->isSylib()) {
        if (call_fn->getName() != "@_sysy_starttime" &&
            call_fn->getName() != "@_sysy_stoptime") {
            return true;
        }
    } else if (call_fn->isBuiltin()) {
        // IRGen only use memset to initialize array
        if (call_fn->getName() != "@" + std::string{Config::IR::BUILTIN_MEMSET})
            return true;
    } else {
        auto fn_defined = dynamic_cast<Function *>(call_fn);
        Err::gassert(fn_defined != nullptr, "AliasAnalysis: Unknown function");
        auto call_res = fam.getResult<AliasAnalysisPass>(*fn_defined);
        return call_res.getFunctionModRefInfo() ==
                   AliasAnalysisResult::ModRefInfo::Mod ||
               call_res.getFunctionModRefInfo() ==
                   AliasAnalysisResult::ModRefInfo::ModRef;
    }
    return true;
}
} // namespace IR

#endif
