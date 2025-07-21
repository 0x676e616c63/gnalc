// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Simple Implementation of DCE, only deleting useless instructions.
// This is a wrapper for `eliminateDeadInsts` in block_utils.hpp.
// Note that it is much faster than ADCE, though not as effective.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_DCE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_DCE_HPP

#include "../pass_manager.hpp"

namespace IR {
class DCEPass : public PM::PassInfo<DCEPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
