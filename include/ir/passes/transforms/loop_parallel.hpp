// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOOP_PARALLEL_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOOP_PARALLEL_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class LoopParallelPass : public PM::PassInfo<LoopParallelPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    size_t name_cnt = 0;
};

} // namespace IR
#endif
