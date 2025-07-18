// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Early Mem2Reg Pass
#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_EARLY_MEM2REG_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_EARLY_MEM2REG_HPP

#include "sir/passes/pass_manager.hpp"

namespace SIR {
class EarlyPromotePass : public PM::PassInfo<EarlyPromotePass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &lfam);
    size_t name_cnt = 0;
};

} // namespace IR
#endif
