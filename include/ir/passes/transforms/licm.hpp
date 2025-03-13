#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LICM_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LICM_HPP

#include "../pass_manager.hpp"
#include "../analysis/loop_analysis.hpp"
#include "../analysis/alias_analysis.hpp"
#include "../analysis/domtree_analysis.hpp"
namespace IR {
class LICMPass : public PM::PassInfo<LICMPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
private:
    bool runOnLoop(std::shared_ptr<Loop>& loop,AliasAnalysisResult& alias,DomTree& dom);
    bool sinkInst(std::shared_ptr<Loop>& loop,AliasAnalysisResult& alias,DomTree& dom);
    bool hoistInst(std::shared_ptr<Loop>& loop,AliasAnalysisResult& alias,DomTree& dom);
    bool canHoistOrSink(std::shared_ptr<Loop>& loop,std::shared_ptr<Instruction>& inst,AliasAnalysisResult & alias);
    bool isUserOutsideLoop(std::shared_ptr<Loop>& loop,std::shared_ptr<Instruction>& inst);
    bool isInvariant(std::shared_ptr<Loop>& loop,std::shared_ptr<Value>& value);
    bool isAllOperandsInvariant(std::shared_ptr<Loop>& loop,std::shared_ptr<Instruction>& inst);
    bool isDomExits(std::shared_ptr<Loop>& loop,std::shared_ptr<Instruction>& inst,DomTree& dom);
    size_t name_cnt = 0;
    FAM *fam;
    Function *func;
};

} // namespace IR
#endif
