// If-conversion in IR
// Performs if-conversion by eliminating conditional branches and merging
// control flow into data-driven logic.
//
// For example,
// IR:
// bb0:                                           bb0:
//   cond = cmp xxx, xxx                            br bb1
//   br cond, bb1, bb2
// bb1:                                           bb1:
//   ; something                                    ; something
//   br bb3                           --->          cond = cmp xxx, xxx
// bb3:                                             vs = select cond, v1, v0
//   val = phi [v0, bb0], [v1, bb1]                 br bb3
//                                                bb3:                  
//                                                    val = phi [vs, bb1]
// CFG:
//  bb0 ---> bb1 ---> bb3               bb0 ---> bb1 ---> bb3
//   |                 ^                        (select)
//   |                 |       --->
//   |-----------------
//
// Note that this only do simple if-conversion, and does not handle more complex cases.
// More complex cases are handled in MIR.
//
// Reference:
//   - "Partial Control-Flow Linearization" (TODO, currently not implemented)
//       https://compilers.cs.uni-saarland.de/papers/moll_parlin_pldi18.pdf
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_IF_CONVERSION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_IF_CONVERSION_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class IfConversionPass : public PM::PassInfo<IfConversionPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    size_t name_cnt = 0;
};

} // namespace IR
#endif
