// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/loop_annotator.hpp"
#include "ir/instructions/compare.hpp"
#include "sir/utils.hpp"

namespace SIR {
struct AnnotateVisitor : ContextVisitor {
    void visit(Context ctx, FORInst &for_inst) override {
        ContextVisitor::visit(ctx, for_inst);
    }
};
PM::PreservedAnalyses LoopAnnotatorPass::run(LinearFunction &function, LFAM &lfam) {
    AnnotateVisitor visitor;
    function.accept(visitor);
    return PreserveAll();
}
} // namespace SIR