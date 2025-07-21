// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Loop Elimination
//
// This pass first propagates loop exit values by SCEV, and eliminate
// non-side-effect, no-use-outside loops. It also breaks the backegde
// if SCEV can figure out that edge will never be taken.
//
// Note that it will always propagate constant exit values,
// but won't propagate non-constant exit values if the loop cannot be eliminated.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOOP_ELIMINATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOOP_ELIMINATION_HPP

#include "../pass_manager.hpp"

namespace IR {
class LoopEliminationPass : public PM::PassInfo<LoopEliminationPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
