// Aggressive Dead Code Elimination
//
// This implementation is adapted from
// Engineering A Compiler 2nd, 10.2.1 and 10.2.2 (`Mark`, `Sweep` and `Clean`)
// However, the original `Clean` phase as described in the text doesn't fit into SSA directly. :(
// For counter-examples, see comments in `lib/ir/passes/transforms/adce.cpp`
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_ADCE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_ADCE_HPP

#include "../pass_manager.hpp"

namespace IR {
class ADCEPass : public PM::PassInfo<ADCEPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
