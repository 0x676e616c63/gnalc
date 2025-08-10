// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Trace Pass
#pragma once
#ifndef GNALC_IR_PASSES_UTILITIES_TRACE_HPP
#define GNALC_IR_PASSES_UTILITIES_TRACE_HPP

#include "ir/passes/pass_manager.hpp"
#include <functional>
#include <utility>

namespace IR {
class TracePass : public PM::PassInfo<TracePass> {
private:
    using FuncCallBackT = std::function<PM::PreservedAnalyses(Function&, FAM&)>;
    using ModuleCallBackT = std::function<PM::PreservedAnalyses(Module&, MAM&)>;
    using CallBackT = std::function<void()>;

    using VariantT = std::variant<CallBackT, FuncCallBackT, ModuleCallBackT>;
    VariantT callback;

public:
    explicit TracePass(VariantT callback_)
        : callback(std::move(callback_)) {}
    PM::PreservedAnalyses run(Function &function, FAM &manager);
    PM::PreservedAnalyses run(Module &module, MAM &manager);
};

} // namespace IR
#endif
