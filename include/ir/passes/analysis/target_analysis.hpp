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
    TargetAnalysis(pTarget target_)
        : target(std::move(target_)) {}

    pTarget run(Function &f, FAM &fpm);

    using Result = pTarget;
private:
    pTarget target;

    friend AnalysisInfo<TargetAnalysis>;
    static PM::UniqueKey Key;
};

} // namespace IR

#endif