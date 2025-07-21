// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Loop Fusion
#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_LOOP_FUSE_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_LOOP_FUSE_HPP

#include "../pass_manager.hpp"

namespace SIR {
class LoopFusePass : public PM::PassInfo<LoopFusePass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &lfam);
};

} // namespace SIR
#endif
