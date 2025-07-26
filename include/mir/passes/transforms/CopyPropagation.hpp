// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_PASSES_TRANSFORMS_COPYPROPAGATION
#define GNALC_MIR_PASSES_TRANSFORMS_COPYPROPAGATION

#include "mir/passes/pass_manager.hpp"

namespace MIR {

class CopyPropagation : public PM::PassInfo<CopyPropagation> {

public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

}; // namespace MIR

#endif