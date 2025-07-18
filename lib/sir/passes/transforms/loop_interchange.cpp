// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/loop_interchange.hpp"
#include "sir/base.hpp"
#include "sir/visitor.hpp"

namespace SIR {
PM::PreservedAnalyses LoopInterchangePass::run(LinearFunction &function, LFAM &lfam) {
    return PM::PreservedAnalyses::all();
}
} // namespace SIR