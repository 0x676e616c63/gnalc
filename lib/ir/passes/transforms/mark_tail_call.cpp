//
// Created by edragain on 2/9/25.
//
#include "../../../../include/ir/passes/transforms/mark_tail_call.hpp"
#include "../../../../include/ir/instructions/control.hpp"

namespace IR {
PM::PreservedAnalyses MarkTailCallPass::run(Function &function, FAM &manager) {
    auto dfVisitor = function.getDFVisitor();
    for (const auto &block : dfVisitor) {
        for (auto iter = block->begin(); iter != block->end(); ++iter) {
            auto call = std::dynamic_pointer_cast<CALLInst>(*iter);
            auto ret = std::dynamic_pointer_cast<RETInst>(*std::next(iter));
            if (call != nullptr && ret != nullptr) {
                if ((call->isVoid() && ret->isVoid()) || ret->getRetVal() == call)
                    call->setTailCall();
            }
        }
    }
    return PM::PreservedAnalyses::all();
}

}