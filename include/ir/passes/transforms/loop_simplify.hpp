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
