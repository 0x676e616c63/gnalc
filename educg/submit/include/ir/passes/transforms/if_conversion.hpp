// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// If-conversion in IR
// Performs if-conversion by eliminating conditional branches by replacing them with `select`.
//
// Note that this only do simple if-conversion presented below,
// and does not handle more complex cases.
// For example,
// IR:
// bb0:                                           bb0:
//   cond = cmp xxx, xxx                            br bb1
//   br cond, bb1, bb2                            bb1:                       
// bb1:                                             ; something              
//   ; something                                    cond = cmp xxx, xxx      
//   br bb3                           --->          vs = select cond, v1, v0 
// bb3:                                             br bb3                   
//   val = phi [v0, bb0], [v1, bb1]               bb3:                       
//                                                    val = phi [vs, bb1]    
//
// CFG:
//  bb0 ---> bb1 ---> bb3               bb0 ---> bb1 ---> bb3               bb0 ---> bb3
//   |                 ^                       (select)                  (select)
//   |                 |       --->                             --->     After CFGSimplify,
//   |-----------------                                                 bb0 and bb1 are merged
//
// It reduces the number of conditional branches and the number of basic blocks.
// However, the duplication of instructions in bb1 (;something) can be expensive or not safe,
// thus a threshold is set to avoid too much duplication.
//
// Note that after CFGBuilder in IRGen, `if` are typically represented by four blocks,
//
// %if.cond ---> %if.then ---> %if.end
//    |                            ^
//    |                            |
//    |--------> %if.else ---------|
//
// This, however, cannot be converted by this pass directly. But after CFGSimplify, %if.then or %if.else
// can be merged, thus this pass can be applied.
// This requires the CFGSimplify run before and after this pass, (or fixed-point).
// The former enables this pass, and the latter merges the converted CFG.
//
// Reference:
//   - "Partial Control-Flow Linearization"
//       https://compilers.cs.uni-saarland.de/papers/moll_parlin_pldi18.pdf
//   (TODO, we have not implemented it currently, but it is quite amazing)
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_IF_CONVERSION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_IF_CONVERSION_HPP

#include "../pass_manager.hpp"

namespace IR {
class IfConversionPass : public PM::PassInfo<IfConversionPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    size_t name_cnt = 0;
};

} // namespace IR
#endif
