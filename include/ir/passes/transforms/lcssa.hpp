// Loop-Closed SSA Form
// This pass ensures the value defined in the loop only used in the loop.
// This is done by inserting a fully redundant phi node in the exits.
// A motivating example:
//
//                      |---------------------
//                      v                    |
//   Preheader --->  Header ---> Body ---> Latch
//                     |          |          |
//                     v          v          v
//                   Exit1      Exit2      Exit3
//                     |          |          |
//                    ...        ...        ...
//
// Imagine %V is a value defined in the Header. %V is used outside the loop below the exits.
// After LCSSAPass, the exits will have the following redundant phis:
//   Exit1:
//     %V1 = phi [ %V, %Header ]
//   Exit2:
//     %V2 = phi [ %V, %Body ]
//   Exit3:
//     %V3 = phi [ %V, %Latch ]
//
// Note that for phi, the use of each incoming value is deemed to occur
// on the edge from the corresponding predecessor block to the current block.
// For practical purposes, we consider it occurs in the corresponding predecessor.
// So the use in exit block through a phi is still considered be in the loop.
//
// The LCSSA Form makes the renaming in other loop transform passes easier, since
// values defined in the loop can only have users either in the loop or in the exit block's phis.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LCSSA_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LCSSA_HPP

#include "../analysis/domtree_analysis.hpp"
#include "../analysis/loop_analysis.hpp"
#include "../pass_manager.hpp"

namespace IR {
class LCSSAPass : public PM::PassInfo<LCSSAPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    size_t name_cnt = 0;
    DomTree *pdomtree{};
    LoopInfo *ploop_info{};

    pVal getValueForBlock(const Loop &loop, const DomTree::Node *node, const pVal &value,
                          std::map<const DomTree::Node *, pVal> &available_values);
    bool formLCSSAOnInsts(std::deque<pInst> &);
};
} // namespace IR
#endif
