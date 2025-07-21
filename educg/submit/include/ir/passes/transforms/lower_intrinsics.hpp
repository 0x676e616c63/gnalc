// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Lower Intrinsics Pass
//   - Generate implementation of intrinsic if the target doesn't support it
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOWER_INTRINSICS_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOWER_INTRINSICS_HPP

#include "../pass_manager.hpp"

namespace IR {
class LowerIntrinsicsPass : public PM::PassInfo<LowerIntrinsicsPass> {
public:
    PM::PreservedAnalyses run(Module &function, MAM &manager);
};

} // namespace IR
#endif
