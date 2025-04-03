// Dead Store Elimination
//
// This pass performs a pre-order traversal of the CFG to eliminate store instructions through:
// - Identifying stores whose values are never subsequently referenced
// - Removing stores overwritten by subsequent stores without intervening reference
//
// TODO: Current implementation is time-consuming.
//       Consider adopting MemorySSA-based analysis to enhance optimization efficiency.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_DSE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_DSE_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class DSEPass : public PM::PassInfo<DSEPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
