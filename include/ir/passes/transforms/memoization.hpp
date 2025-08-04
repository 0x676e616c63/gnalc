// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Automatic function memoization
// Reference:
//   - Clava: https://github.com/specs-feup/clava
//   - "A framework for automatic and parameterizable memoization"
//       https://www.sciencedirect.com/science/article/pii/S2352711018301559
//   - "A methodology and framework for software memoization of functions."
//       https://doi.org/10.1145/3457388.3458668
//   - Wikipedia: https://en.wikipedia.org/wiki/Memoization
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_MEMOIZATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_MEMOIZATION_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
enum class MemoAttr {
    LUT = 1 << 0,
};
GNALC_ENUM_OPERATOR(MemoAttr)
using MemoAttrs = Attr::BitFlagsAttr<MemoAttr>;
class MemoizePass : public PM::PassInfo<MemoizePass> {
public:
    explicit MemoizePass(bool emit_debug_inst_ = false) : emit_debug_inst(emit_debug_inst_) {}

    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    bool emit_debug_inst;
};

bool isSafeToMemoize(Function &func, FAM& fam);
} // namespace IR
#endif
