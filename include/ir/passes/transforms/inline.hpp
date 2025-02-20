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
};

} // namespace IR
#endif
