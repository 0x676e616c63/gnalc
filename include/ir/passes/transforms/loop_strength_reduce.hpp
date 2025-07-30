// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Loop Strength Reduce
// This pass expand AddRec in SCEV to eliminate in loop multiplication.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOOP_STRENGTH_REDUCE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOOP_STRENGTH_REDUCE_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
struct LSRAttrs : Attr::AttrInfo<LSRAttrs> {
    size_t reduced_gep_cnt = 0;
private:
    friend class AttrInfo<LSRAttrs>;
    static Attr::AttrKey Key;
};

class LoopStrengthReducePass : public PM::PassInfo<LoopStrengthReducePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
