// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Tail Recursion Elimination Pass
// This pass eliminate tail recursion and mark tail call.
//
// WARNING: This pass SHOULD run after PromotePass(mem2reg),
//          otherwise phis might not be handled correctly
//
// Reference:
//   https://llvm.org/docs/Passes.html#tailcallelim-tail-call-elimination
//   https://llvm.org/docs/CodeGenerator.html#tail-call-optimization
//   https://discourse.llvm.org/t/how-to-understand-tail-call/51097
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_TAIL_RECURISON_ELIMINATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_TAIL_RECURISON_ELIMINATION_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class TailRecursionEliminationPass : public PM::PassInfo<TailRecursionEliminationPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    size_t name_cnt = 0;
};
} // namespace IR
#endif //GNALC_IR_PASSES_TRANSFORMS_TAIL_RECURISON_ELIMINATION_HPP
