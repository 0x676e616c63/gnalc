// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/loop_parallel.hpp"
#include "ir/block_utils.hpp"

#include <vector>

namespace IR {
PM::PreservedAnalyses LoopParallelPass::run(Function &function, FAM &fam) {
    return PreserveAll();
}
} // namespace IR