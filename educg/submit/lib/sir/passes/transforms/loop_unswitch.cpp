// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/sir/passes/transforms/loop_unswitch.hpp"
#include "../../../../include/sir/base.hpp"
#include "../../../../include/sir/visitor.hpp"

namespace SIR {

struct UnswitchVisitor : Visitor {
    void visit(FORInst &for_inst) override {
        Visitor::visit(for_inst);

    }
};

PM::PreservedAnalyses LoopUnswitchPass::run(LinearFunction &function, LFAM &lfam) {
    bool loop_unswitch_modified = false;

    UnswitchVisitor visitor;
    function.accept(visitor);

    return loop_unswitch_modified ? PreserveNone() : PreserveAll();
}
} // namespace SIR