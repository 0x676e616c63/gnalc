#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOOP_ELIMINATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOOP_ELIMINATION_HPP

#include "../pass_manager.hpp"

namespace IR {
class LoopEliminationPass : public PM::PassInfo<LoopEliminationPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
