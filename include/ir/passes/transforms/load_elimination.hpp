#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOAD_ELIMINATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOAD_ELIMINATION_HPP

#include "../pass_manager.hpp"

namespace IR {
class LoadEliminationPass : public PM::PassInfo<LoadEliminationPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
