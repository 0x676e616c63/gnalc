// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/analysis/target_analysis.hpp"
#include <optional>

namespace IR {
PM::UniqueKey TargetAnalysis::Key;

pTarget TargetAnalysis::run(Function &f, FAM &fpm) {
    return target;
}
} // namespace IR
