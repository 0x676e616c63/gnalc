//
// Created by edragain on 2/9/25.
//
#include "../../../../include/ir/passes/transforms/tail_call_elimination.hpp"
#include "../../../../include/ir/instructions/control.hpp"

namespace IR {
PM::PreservedAnalyses TailCallEliminationPass::run(Function &function, FAM &manager) {
    auto dfsVisitor = function.getDFVisitor();
    for (const auto &block : dfsVisitor) {
        for (auto iter = block->begin(); iter != block->end(); ++iter) {
            auto call = std::dynamic_pointer_cast<CALLInst>(*iter);
            auto ret = std::dynamic_pointer_cast<RETInst>(*std::next(iter));
            if (call != nullptr && ret != nullptr && !call->isTailCall() && call->getFuncName() == function.getName()) {
                if ((call->isVoid() && ret->isVoid()) || call->getType() == ret->getRetType())
                    call->setTailCall();
            }
        }
    }
    return PM::PreservedAnalyses::all();
}

}