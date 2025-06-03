#include "sir/passes/transforms/loop_unswitch.hpp"
#include "sir/base.hpp"
#include "sir/visitor.hpp"

namespace SIR {

struct UnswitchVisitor : Visitor {
    void visit(FORInst &for_inst) override {
        Visitor::visit(for_inst);

    }
};

PM::PreservedAnalyses LoopUnswitchPass::run(LinearFunction &function, LFAM &manager) {
    bool loop_unswitch_modified = false;

    UnswitchVisitor visitor;
    function.accept(visitor);

    return loop_unswitch_modified ? PreserveNone() : PreserveAll();
}
} // namespace IR