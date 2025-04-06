// Load Elimination
//
// This pass performs a post-order traversal of the CFG to eliminate load instructions through:
// - Replacing subsequent loads with previously loaded values
// - Propagating stored values directly to dependent loads
//
// TODO: Current implementation is time-consuming.
//       Consider adopting MemorySSA-based analysis to enhance optimization efficiency.
// FIXME: Extend this to support loops
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOAD_ELIMINATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOAD_ELIMINATION_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class LoadEliminationPass : public PM::PassInfo<LoadEliminationPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
