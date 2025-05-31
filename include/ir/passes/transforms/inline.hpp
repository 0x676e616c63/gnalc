// Function Inliner
// This pass does not delete functions that are inlined.
//
// Note that the `ModulePassWrapper` processes functions in their definition order,
// which implicitly forms a post order in SysY due to the absence of function
// declarations (all functions must be defined before use).
// This natural post order is also utilized in AliasAnalysis and GVN-PRE.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_INLINE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_INLINE_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class InlinePass : public PM::PassInfo<InlinePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    size_t name_cnt = 0;
};
} // namespace IR
#endif
