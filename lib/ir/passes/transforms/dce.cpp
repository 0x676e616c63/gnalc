#include "../../../../include/ir/passes/transforms/dce.hpp"
#include "../../../../include/ir/instructions/control.hpp"

#include <algorithm>

namespace IR {
PM::PreservedAnalyses DeadCodeEliminationPass::run(
    Function &function, FAM &manager) {
    // Maybe write a new pass for side effect?
    // Or just make it a member function.
    // auto side_effect_checker = manager.getResult<SideEffectAnalysis>(function);

    bool modified = true;
    while (modified) {
        modified = false;
        auto retvalue = returnValueAnalysis(function);
        if (function.getParams().empty() && function.getBlocks().size() > 1) {
            for (auto block : function) { function.delBlock(block); }
            auto basicblock = std::make_shared<BasicBlock>();
            auto retinst = std::make_shared<RETInst>(retvalue);
            basicblock->addInst(retinst);
            function.addBlock(basicblock);
            modified = true;

        }
        if (modified)
            continue;

        worklist.clear();
        dead.clear();

        for (const auto &block : function) {
            for (auto insts = block->getInsts().rbegin();
                 insts != block->getInsts().rend();) {
                auto inst = *insts;
                --insts;
                if (std::find(worklist.begin(), worklist.end(), inst) ==
                    worklist.end()) {
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
    for (const auto &block : function) {

        block->delInstIf([this](std::shared_ptr<Instruction> inst) {
            return this->dead.find(inst) != this->dead.cend();
        });
    }

    return PM::PreservedAnalyses::none();
}

bool DeadCodeEliminationPass::visitInst(
    const std::shared_ptr<Instruction> &inst) {
    if (!isCritical(inst)) {
        for (auto &use : inst->getOperands()) {
            auto op = use->getValue();
            if (auto inst_ = std::dynamic_pointer_cast<Instruction>(op)) {
                if (!isCritical(inst_))
                    worklist.emplace_back(inst_);
            }
        }
        dead.insert(inst);
        return true;
    }
    return false;
}

bool DeadCodeEliminationPass::isCritical(
    const std::shared_ptr<Instruction> &inst) {
    if (inst->getOperands().empty())
        return false;

    if (auto phi = std::dynamic_pointer_cast<PHIInst>(inst)) {
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

bool DeadCodeEliminationPass::visitPhi(const std::shared_ptr<PHIInst> &phi) {

    return false;
    //TODO operand =0 or =1?
}

bool DeadCodeEliminationPass::checkDeadPhiCycle(
    const std::shared_ptr<PHIInst> &phi,
    std::set<std::shared_ptr<PHIInst> > &potentiallyDeadPhis) {
    //TODO
}

std::shared_ptr<Value> DeadCodeEliminationPass::returnValueAnalysis(
    Function &function) {
    std::shared_ptr<Value> retValue = nullptr;
    for (auto block : function) {
        for (auto inst : block->getInsts()) {
            if (auto phi = std::dynamic_pointer_cast<PHIInst>(inst)) {
                std::shared_ptr<Value> sameValue = nullptr;
                for (auto phi_operand : phi->getPhiOpers()) {
                    auto value = phi_operand->getValue();
                    if (sameValue && value != sameValue)
                        return nullptr;
                    sameValue = value;
                }
                if (sameValue)
                    inst->replaceSelf(sameValue);
            }
            if (auto retinst = std::dynamic_pointer_cast<RETInst>(inst)) {

                if (retinst->isVoid())
                    retValue = nullptr;
                else {
                    auto value = retinst->getRetVal();
                    if (retValue && retValue != value)
                        return nullptr;
                    retValue = value;
                }

            }
        }
    }
    if (retValue && std::dynamic_pointer_cast<ConstantProxy>(retValue))
        return retValue;
    return nullptr;
}


} // namespace IR