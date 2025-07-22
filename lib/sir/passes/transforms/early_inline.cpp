// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/early_inline.hpp"

#include "sir/passes/analysis/alias_analysis.hpp"
#include "sir/passes/utilities/sirprinter.hpp"
#include "sir/visitor.hpp"

namespace SIR {
PM::PreservedAnalyses EarlyInlinePass::run(LinearFunction &function, LFAM &lfam) {
    auto test = makeClone(function.as<LinearFunction>());
    PrintLinearFunctionPass printer(std::cerr);
    test->accept(printer);
    return PreserveNone();
}
} // namespace SIR