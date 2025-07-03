// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Loop Unswitch
#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_LOOP_UNSWITCH_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_LOOP_UNSWITCH_HPP

#include "sir/passes/pass_manager.hpp"

namespace SIR {
class LoopUnswitchPass : public PM::PassInfo<LoopUnswitchPass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &manager);
    size_t name_cnt = 0;
};

} // namespace IR
#endif
