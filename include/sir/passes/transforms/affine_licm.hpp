// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Affine LICM
// This pass tries to hoist loop-invariant region out of Affine-Fors.
//
// Reference:
//   - MLIR Affine Loop Invariant Code Motion:
//       https://github.com/llvm/llvm-project/blob/main/mlir/lib/Dialect/Affine/Transforms/AffineLoopInvariantCodeMotion.cpp
#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_AFFINE_LICM_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_AFFINE_LICM_HPP

#include "sir/passes/pass_manager.hpp"

namespace SIR {
class AffineLICMPass : public PM::PassInfo<AffineLICMPass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &lfam);
};
} // namespace SIR
#endif
