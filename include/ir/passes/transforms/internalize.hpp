// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Internalize Pass
// Internalize global variable into function if possible.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_INTERNALIZE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_INTERNALIZE_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class InternalizePass : public PM::PassInfo<InternalizePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
