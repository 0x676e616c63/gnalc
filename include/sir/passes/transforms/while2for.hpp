// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Convert WHILEInst to FORInst
#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_WHILE2FOR_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_WHILE2FOR_HPP

#include "sir/passes/pass_manager.hpp"

namespace SIR {
class While2ForPass : public PM::PassInfo<While2ForPass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &lfam);
};

} // namespace SIR
#endif
