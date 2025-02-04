#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/transforms/dce.hpp"
#include "../../../../include/ir/instructions/control.hpp"

#include <algorithm>
#include <functional>

namespace IR {
PM::PreservedAnalyses DeadCodeEliminationPass::run(
    Function &function, FAM &manager) {
    this->fam = &manager;
    this->func = &function;

    bool modified = true;
    while (modified) {
        modified = false;

        // Maybe useless, because we are doing alias analysis
        // auto retvalue = returnValueAnalysis(function);
        // if (function.getParams().empty() && function.getBlocks().size() > 1) {
        //     for (const auto& block : function)
        //         function.delBlock(block);
        //     auto basicblock = std::make_shared<BasicBlock>();
        //     auto retinst = std::make_shared<RETInst>(retvalue);
        //     basicblock->addInst(retinst);
        //     function.addBlock(basicblock);
        //     modified = true;
        // }
        // if (modified)
        //     continue;

        worklist.clear();
        dead.clear();

        for (const auto &block : function) {
            for (auto inst_it = block->getInsts().rbegin();
                 inst_it != block->getInsts().rend();) {
                const auto& inst = *inst_it;
                --inst_it;
                if (std::find(worklist.begin(), worklist.end(), inst) == worklist.end())
                    modified |= visitInst(inst);
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
        block->delInstIf([this](const auto& inst) {
            return this->dead.find(inst) != this->dead.cend();
        });
    }

    return PM::PreservedAnalyses::none();
}

bool DeadCodeEliminationPass::visitInst(
    const std::shared_ptr<Instruction> &inst) {
    if (!isCritical(inst)) {
        for (const auto &use : inst->getOperands()) {
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
    if (auto call = std::dynamic_pointer_cast<CALLInst>(inst)) {
        if (call->getFunc().get() == func)
            return true;
        return hasSideEffect(*fam, call.get());
    }

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
    for (const auto& block : function) {
        for (const auto& inst : *block) {
            if (auto phi = std::dynamic_pointer_cast<PHIInst>(inst)) {
                std::shared_ptr<Value> sameValue = nullptr;
                for (const auto& phi_operand : phi->getPhiOpers()) {
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