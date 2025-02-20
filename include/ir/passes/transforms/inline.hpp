// Function Inliner
// This pass does not delete functions that are inlined.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_INLINE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_INLINE_HPP

#include "../pass_manager.hpp"

namespace IR {
class InlinePass : public PM::PassInfo<InlinePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
    std::map<Function, unsigned> inlineCount;
    std::map<Function, unsigned> funcInstCount;
private:
    bool canInline(const Function& vFunc,const Function& uFunc) ;
    void funcInline(Function&vFunc,Function& uFunc,std::shared_ptr<BasicBlock>& bb,std::shared_ptr<Instruction>&inst);


};


} // namespace IR
#endif
