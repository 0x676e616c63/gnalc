// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Target Analysis
// Providing target information for IR Passes
#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_TARGET_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_TARGET_ANALYSIS_HPP

#include "ir/base.hpp"
#include "ir/passes/pass_manager.hpp"
#include "ir/target/target.hpp"

namespace IR {
class TargetAnalysis : public PM::AnalysisInfo<TargetAnalysis> {
public:
    explicit TargetAnalysis(pTarget target_)
        : target(std::move(target_)) {}

    pTarget run(Function &f, FAM &fpm);
    pTarget run(Module &f, MAM &fpm);

    using Result = pTarget;
private:
    pTarget target;

    friend AnalysisInfo<TargetAnalysis>;
    static PM::UniqueKey Key;
};

} // namespace IR

#endif