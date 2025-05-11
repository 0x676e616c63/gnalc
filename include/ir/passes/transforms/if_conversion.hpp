// If-conversion in IR
// Performs if-conversion by eliminating conditional branches and merging
// control flow into data-driven logic.
//
// For example,
// bb0:                                           bb0:
//   cond = cmp xxx, xxx                            br bb3
//   br cond, bb1, bb2
// bb1:
//   br bb3                           --->
// bb2:
//   br bb3
// bb3:                                           bb3:
//   val = phi [v1, bb1], [v2, bb2]                 cond = cmp xxx, xxx
//                                                  val = select cond, v2, v1
//
// Or a more general case:
// TODO
//
// Note that this only do simple if-conversion, and does not handle more complex cases.
// More complex cases are handled in MIR.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_IF_CONVERSION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_IF_CONVERSION_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class IfConversionPass : public PM::PassInfo<IfConversionPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
