// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Early DCE
#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_EARLY_DCE_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_EARLY_DCE_HPP

#include "../pass_manager.hpp"

namespace SIR {
class EarlyDCEPass : public PM::PassInfo<EarlyDCEPass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &lfam);
};

} // namespace SIR
#endif
