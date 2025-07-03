// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Dead Store Elimination
//
// This pass performs a pre-order traversal of the CFG to eliminate store instructions through:
// - Removing stores whose memory is never subsequently referenced
// - Removing stores overwritten by subsequent stores without intervening reference
// - Removing stores whose value is a previous load, and there are no
//   intervening modification between them
//
// TODO: Current implementation is time-consuming.
//       Consider adopting MemorySSA-based analysis to enhance optimization efficiency.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_DSE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_DSE_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class DSEPass : public PM::PassInfo<DSEPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
