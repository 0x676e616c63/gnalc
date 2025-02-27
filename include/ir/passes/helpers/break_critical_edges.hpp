// Break critical edges in CFG, which is required by GVN-PRE
//
// critical edges: edges from blocks with more than one successor
//                 to blocks with more than one predecessor
// Method: Inserting an empty block between the two blocks connected by the critical edge.
//
// More Information: https://nickdesaulniers.github.io/blog/2023/01/27/critical-edge-splitting/
#pragma once
#ifndef GNALC_IR_PASSES_HELPER_BREAK_CRITICAL_EDGES_HPP
#define GNALC_IR_PASSES_HELPER_BREAK_CRITICAL_EDGES_HPP

#include "../../base.hpp"
#include "../../basic_block.hpp"
#include "../../function.hpp"

namespace IR {
bool break_critical_edges(Function& function);
} // namespace IR
#endif
