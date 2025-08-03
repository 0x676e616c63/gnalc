// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Relayout
// This pass tries to transform data layout to improve cache performance.
#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_RELAYOUT_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_RELAYOUT_HPP

#include "../pass_manager.hpp"

namespace SIR {
enum class RelayoutAttr {
    Transpose = 1 << 0,
    Tiling = 1 << 1,
};
GNALC_ENUM_OPERATOR(RelayoutAttr)
using RelayoutAttrs = Attr::BitFlagsAttr<RelayoutAttr>;

class RelayoutPass : public PM::PassInfo<RelayoutPass> {
public:
    PM::PreservedAnalyses run(Module &module, MAM &mam);
};
} // namespace SIR
#endif
