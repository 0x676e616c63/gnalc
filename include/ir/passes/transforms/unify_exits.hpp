// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Unify function exit nodes
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_UNIFY_EXITS_HPP
#define GNALC_IR_PASSES_TRANSFORMS_UNIFY_EXITS_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class UnifyExitsPass : public PM::PassInfo<UnifyExitsPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
