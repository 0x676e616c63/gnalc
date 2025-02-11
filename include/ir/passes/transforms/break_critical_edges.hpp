// Break critical edges in CFG, which is required by GVN-PRE
//
// critical edges: edges from blocks with more than one successor
//                 to blocks with more than one predecessor
// Method: Inserting an empty block between the two blocks connected by the critical edge.
//
// More Information: https://nickdesaulniers.github.io/blog/2023/01/27/critical-edge-splitting/
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_BREAK_CRITICAL_EDGES_HPP
#define GNALC_IR_PASSES_TRANSFORMS_BREAK_CRITICAL_EDGES_HPP

#include "../pass_manager.hpp"

namespace IR {
class BreakCriticalEdgesPass : public PM::PassInfo<BreakCriticalEdgesPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
