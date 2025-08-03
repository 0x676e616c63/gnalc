// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/sir/passes/transforms/loop_annotator.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/sir/utils.hpp"

namespace SIR {
PM::PreservedAnalyses LoopAnnotatorPass::run(LinearFunction &function, LFAM &lfam) {
    // TODO
    return PreserveAll();
}
} // namespace SIR