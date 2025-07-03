// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Simplification based on RangeAnalysis
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_RANGE_AWARE_SIMPLIFY_HPP
#define GNALC_IR_PASSES_TRANSFORMS_RANGE_AWARE_SIMPLIFY_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class RangeAwareSimplifyPass : public PM::PassInfo<RangeAwareSimplifyPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
