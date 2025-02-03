#include "../../../../include/ir/passes/transforms/dce.hpp"
#include "../../../../include/ir/instructions/control.hpp"

#include <algorithm>

namespace IR {
PM::PreservedAnalyses DeadCodeEliminationPass::run(Function &function, FAM &manager) {
    // Maybe write a new pass for side effect?
    // Or just make it a member function.
    // auto side_effect_checker = manager.getResult<SideEffectAnalysis>(function);

    //flag:
    bool modified = true;
    while (modified) {
        modified = false;
        worklist.clear();
        for (const auto& block : function) {
            for (auto insts = block->getInsts().rbegin(); insts != block->getInsts().rend();) {
                auto inst = *insts;
                --insts;
                if (std::find(worklist.begin(), worklist.end(), inst) == worklist.end()) {
                    modified |= visitInst(inst);
                }
            }
            while (!worklist.empty()) {
                auto inst_ = worklist.back();
                worklist.pop_back();
                modified |= visitInst(inst_);
            }
//TODO function side effect and constant return analysis
        }
    }

    return PM::PreservedAnalyses::none();
}

bool DeadCodeEliminationPass::visitInst(const std::shared_ptr<Instruction>& inst) {
    if (!isCritical(inst)) {
        for (auto &use : inst->getOperands()) {
            auto op = use->getValue();
            if (auto inst_ =std::dynamic_pointer_cast<Instruction>(op)) {
                if (!isCritical(inst_))
                    worklist.emplace_back(inst_);
            }
        }
        return true;
    }
    return false;
}
bool DeadCodeEliminationPass::isCritical(const std::shared_ptr<Instruction>& inst) {
    if (inst->getOperands().empty())
        return false;

    if (auto phi= std::dynamic_pointer_cast<PHIInst>(inst)) {
        if (visitPhi(phi)) {
            return false;
        }
        return true;
    }
    if (inst->getOpcode() == OP::BR)
        return true;
    if (inst->getOpcode() == OP::CALL)
        return true;
    if (inst->getOpcode() == OP::RET)
        return true;
//TODO have side effect->true
    return true;
}
bool DeadCodeEliminationPass::visitPhi(const std::shared_ptr<PHIInst>& phi) {
    if (phi->getOperands().size()==0)
        return true;
    if (phi->getOperands().size()==1) {
        auto user =phi->getOperands().front()->getUser();
        //TODO
    }
}
bool DeadCodeEliminationPass::checkDeadPhiCycle(const std::shared_ptr<PHIInst>& phi, std::set<std::shared_ptr<PHIInst>>& potentiallyDeadPhis) {
    //TODO
}


} // namespace IR