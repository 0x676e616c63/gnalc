#include "../../../../include/ir/passes/transforms/dce.hpp"

#include "../../../../include/ir/instructions/control.hpp"

#include <bits/valarray_before.h>

namespace IR {
PM::PreservedAnalyses DeadCodeEliminationPass::run() {
    //flag:
    bool madeChange = true;
    while (madeChange) {
        madeChange = false;
        std::vector<std::shared_ptr<Instruction> > worklist;
        for (auto block : func) {
            for (auto insts = block->getInsts().rbegin();
                 insts != block->getInsts().rend();) {
                auto inst = *insts;
                --insts;
                if (std::find(worklist.begin(), worklist.end(), inst) ==
                    worklist.end()) {
                    madeChange |= dceInst(inst, worklist);
                }
            }
            while (!worklist.empty()) {
                auto inst_ = worklist.back();
                worklist.pop_back();
                madeChange |= dceInst(inst_, worklist);
            }
//TODO function side effect and constant return analysis
        }
    }
}

bool DeadCodeEliminationPass::dceInst(std::shared_ptr<Instruction> inst,
                                      std::vector<std::shared_ptr<Instruction> >
                                      &worklist) {

    if (isDeadInst(inst)) {
        for (auto &use : inst->getOperands()) {
            auto op = use->getValue();
            if (auto inst_ =std::dynamic_pointer_cast<Instruction>(op)) {
                if (isDeadInst(inst_))
                    worklist.push_back(inst_);
            }
        }
        return true;
    }
    return false;
}
bool DeadCodeEliminationPass::isDeadInst(std::shared_ptr<Instruction> inst) {
    if (auto phi=std::dynamic_pointer_cast<PHIInst>(inst)) {
        if (HandPhi(phi)) {
            return true;
        }
        return false;
    }
    if (!inst->getOperands().empty())
        return false;
    if (auto br =std::dynamic_pointer_cast<BRInst>(inst))
        return false;
    if (auto call=std::dynamic_pointer_cast<CALLInst>(inst))
        return false;
    if (auto ret=std::dynamic_pointer_cast<RETInst>(inst))
        return false;
//TODO have side effect->true
    return false;
}
bool DeadCodeEliminationPass::HandPhi(std::shared_ptr<PHIInst> phi) {
    if (phi->getOperands().size()==0)
        return true;
    if (phi->getOperands().size()==1) {
        auto user =phi->getOperands().front()->getUser();
        //TODO
    }
}
bool DeadCodeEliminationPass::DeadPhiCycle(std::shared_ptr<PHIInst> phi, std::set<std::shared_ptr<PHIInst> > potentiallyDeadPhis) {
    //TODO
}


} // namespace IR