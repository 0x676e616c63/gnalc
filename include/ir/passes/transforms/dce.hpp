#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_DEAD_CODE_ELIMINATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_DEAD_CODE_ELIMINATION_HPP

#include "../pass_manager.hpp"

namespace IR {
class DeadCodeEliminationPass : public PM::PassInfo<DeadCodeEliminationPass> {
public:
    PM::PreservedAnalyses run();
    DeadCodeEliminationPass(Function* func_,FAM &AM_):func(func_),AM(AM_){}
private:
    bool dceInst(std::shared_ptr<Instruction> inst, std::vector<std::shared_ptr<Instruction>> &worklist);
    bool isDeadInst(std::shared_ptr<Instruction> inst);
    Function* func;
    FAM& AM;
    bool HandPhi(std::shared_ptr<PHIInst> phi);
    bool DeadPhiCycle(std::shared_ptr<PHIInst> phi,std::set<std::shared_ptr<PHIInst>>potentiallyDeadPhis);
};


} // namespace IR
#endif
