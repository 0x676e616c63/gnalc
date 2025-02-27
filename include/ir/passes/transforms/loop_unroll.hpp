#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOOP_UNROLL_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOOP_UNROLL_HPP

#include "../pass_manager.hpp"

namespace IR {
class LoopUnrollPass : public PM::PassInfo<LoopUnrollPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
