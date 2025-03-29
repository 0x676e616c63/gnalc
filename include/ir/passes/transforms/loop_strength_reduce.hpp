#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOOP_STRENGTH_REDUCE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOOP_STRENGTH_REDUCE_HPP

#include "../pass_manager.hpp"

namespace IR {
class LoopStrengthReducePass : public PM::PassInfo<LoopStrengthReducePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
