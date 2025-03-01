// Loop Simplify Pass
// After this pass, every loop in function has:
//   - A preheader
//   - A single backedge (which implies that there is a single latch)
//   - Dedicated exits. (That is, no exit block for the loop has a predecessor
//                       that is outside the loop. This implies that all exit blocks
//                       are dominated by the loop header.)
//
// Note that this implementation might introduce redundant phi nodes and control-flow structures.
// But they'll be eliminated after InstSimplify and ADCE.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOOP_SIMPLIFY_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOOP_SIMPLIFY_HPP

#include "../pass_manager.hpp"

namespace IR {
class LoopSimplifyPass : public PM::PassInfo<LoopSimplifyPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
