// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/transforms/codegen_prepare.hpp"
#include "../../../../include/ir/block_utils.hpp"

namespace IR {
PM::PreservedAnalyses CodeGenPreparePass::run(Function &function, FAM &fam) {
    breakAllCriticalEdges(function);
    // Since this is the last IR Pass, preserving analysis is unnecessary.
    return PreserveNone();
}

} // namespace IR