// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/utilities/trace.hpp"

namespace IR {
PM::PreservedAnalyses TracePass::run(Function &function, FAM &fam) {
    if (std::holds_alternative<CallBackT>(callback)) {
        std::get<CallBackT>(callback)();
        return PreserveAll();
    }

    if (std::holds_alternative<FuncCallBackT>(callback))
        return std::get<FuncCallBackT>(callback)(function, fam);

    Err::gassert(!std::holds_alternative<ModuleCallBackT>(callback),
        "Module callback runs on function.");

    Err::unreachable("Unknown callback");
    return PreserveAll();
}

PM::PreservedAnalyses TracePass::run(Module &module, MAM &fam) {
    if (std::holds_alternative<CallBackT>(callback)) {
        std::get<CallBackT>(callback)();
        return PreserveAll();
    }

    if (std::holds_alternative<ModuleCallBackT>(callback))
        return std::get<ModuleCallBackT>(callback)(module, fam);

    Err::gassert(!std::holds_alternative<FuncCallBackT>(callback),
        "Function callback runs on module.");

    Err::unreachable("Unknown callback");
    return PreserveAll();
}
} // namespace IR
