// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Globalize Pass
// Globalize local array variable into global array
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_GLOBALIZE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_GLOBALIZE_HPP

#include "../pass_manager.hpp"

namespace IR {
enum class GlobalizeAttr {
    GlobalizedLocalArray = 1 << 0,
};
GNALC_ENUM_OPERATOR(GlobalizeAttr)
using GlobalizeAttrs = Attr::BitFlagsAttr<GlobalizeAttr>;

class GlobalizePass : public PM::PassInfo<GlobalizePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
