// Inst Simplify Pass
// Common peephole optimizations on Instructions through algebraic simplification and strength reduction
// This pass recognize common instruction patterns using the PatternMatch utility
// and simplify them while maintaining program semantics.
//
// Note that this pass would destroy the LCSSA form unless `preserve_lcssa` is set.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_INSTSIMPLIFY_HPP
#define GNALC_IR_PASSES_TRANSFORMS_INSTSIMPLIFY_HPP

#include "../pass_manager.hpp"

namespace IR {
class InstSimplifyPass : public PM::PassInfo<InstSimplifyPass> {
public:
    explicit InstSimplifyPass(bool preserve_lcssa_ = false): preserve_lcssa(preserve_lcssa_) {}
    PM::PreservedAnalyses run(Function &function, FAM &manager);
private:
    bool preserve_lcssa;
    size_t name_cnt = 0;
    std::string getTmpName();
};

} // namespace IR
#endif
