// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// TreeShakingPass
// This is a Module Pass that removes useless global variables, functions and function declarations.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_TREE_SHAKING_HPP
#define GNALC_IR_PASSES_TRANSFORMS_TREE_SHAKING_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class TreeShakingPass : public PM::PassInfo<TreeShakingPass> {
public:
    PM::PreservedAnalyses run(Module &module, MAM &manager);
};

} // namespace IR
#endif
