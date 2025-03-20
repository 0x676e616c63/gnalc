// Loop Rotate
//
// Rotate the loop body to the header.
// This pass first try merge the latch to the header, then rotate the loop if possible.
// Loops that:
//   - Simplified Form.
//   - Exactly one exit, and the exit is from the header.
//   - The only exit has the header as its only predecessor. (i.e. only header is exiting)
//   - The loop body (the header's non-exit successor) has the header as its only predecessor.
// can be rotated as the graph below.
//
//                    ---------------------      
//                   |                    |      
//                   v     (New Header)   |                          (New Header)
//  PreHeader ---> Header ---> Body ---> Latch    <to>    PreHeader ---> Body ---> Latch
//                  |                                         |           ^         |
//                  v                                         v           |         |
//                Exit                                       Exit  <-----------------
//
// Note that this implementation don't need the loop be in the LCSSA Form. And it does not
// preserve the LCSSA Form. But preserves the LoopSimplify Form.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOOP_ROTATE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOOP_ROTATE_HPP

#include "../pass_manager.hpp"

namespace IR {
class LoopRotatePass : public PM::PassInfo<LoopRotatePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
private:
    size_t name_cnt = 0;
};

} // namespace IR
#endif
