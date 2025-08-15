// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Early Parallel
#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_EARLY_PARALLEL_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_EARLY_PARALLEL_HPP

#include "sir/passes/pass_manager.hpp"

namespace SIR {
class EarlyParallelPass : public PM::PassInfo<EarlyParallelPass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &lfam);
};
} // namespace SIR
#endif
