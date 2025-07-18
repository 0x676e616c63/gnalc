// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Loop Interchange
#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_LOOP_INTERCHANGE_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_LOOP_INTERCHANGE_HPP

#include "sir/passes/pass_manager.hpp"

namespace SIR {
class LoopInterchangePass : public PM::PassInfo<LoopInterchangePass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &lfam);
    size_t name_cnt = 0;
};

} // namespace SIR
#endif
