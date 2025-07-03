// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Automatic function memoization
// Note that this it's not a typo. The term is indeed "memoization", not "memorization".
// https://en.wikipedia.org/wiki/Memoization
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_MEMOIZATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_MEMOIZATION_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class MemoizePass : public PM::PassInfo<MemoizePass> {
public:
    explicit MemoizePass(bool emit_debug_inst_ = false) : emit_debug_inst(emit_debug_inst_) {}

    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    bool emit_debug_inst;
};

bool isProfitableToMemoize(const Function &func);
} // namespace IR
#endif
