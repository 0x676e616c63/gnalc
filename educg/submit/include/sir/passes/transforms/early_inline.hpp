// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Early Inline

#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_EARLY_INLINE_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_EARLY_INLINE_HPP

#include "../pass_manager.hpp"

namespace SIR {
class EarlyInlinePass : public PM::PassInfo<EarlyInlinePass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &lfam);
};

} // namespace SIR
#endif
