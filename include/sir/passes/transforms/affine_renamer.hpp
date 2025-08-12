// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Affine Renamer
//   Rename variables in affine fors for better debugging
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_AFFINE_RENAMER_HPP
#define GNALC_IR_PASSES_TRANSFORMS_AFFINE_RENAMER_HPP

#include "sir/passes/pass_manager.hpp"

namespace SIR {

class AffineRenamePass : public PM::PassInfo<AffineRenamePass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &manager);
};

} // namespace IR

#endif