#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_DEAD_CODE_ELIMINATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_DEAD_CODE_ELIMINATION_HPP

#include "../pass_manager.hpp"

namespace IR {
class DeadCodeEliminationPass : public PM::PassInfo<DeadCodeEliminationPass> {
    std::vector<std::shared_ptr<Instruction>> worklist;
    std::set<std::shared_ptr<Instruction>> dead;
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
private:
    bool isCritical(const std::shared_ptr<Instruction>& inst);
    bool visitPhi(const std::shared_ptr<PHIInst>& phi);
    bool visitInst(const std::shared_ptr<Instruction>& inst);
    bool checkDeadPhiCycle(const std::shared_ptr<PHIInst>& phi,
        std::set<std::shared_ptr<PHIInst>>& potentiallyDeadPhis);
    std::shared_ptr<Value> returnValueAnalysis(Function &function);
};


} // namespace IR
#endif
