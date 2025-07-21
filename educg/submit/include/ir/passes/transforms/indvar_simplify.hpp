// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// TODO
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_INDVAR_SIMPLIFY_HPP
#define GNALC_IR_PASSES_TRANSFORMS_INDVAR_SIMPLIFY_HPP

#include "../pass_manager.hpp"

namespace IR {
class IndVarSimplifyPass : public PM::PassInfo<IndVarSimplifyPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
