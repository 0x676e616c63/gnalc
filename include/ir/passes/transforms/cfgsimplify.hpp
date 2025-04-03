// Simplify CFG
//
// This implementation is adapted from
// Engineering A Compiler 2nd, 10.2.1 and 10.2.2 (`Clean`)
// However, the original `Clean` as described in the text doesn't fit into SSA directly. :(
// For counter-examples, see comments in `lib/ir/passes/transforms/cfgsimplify.cpp`
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_CFGSIMPLIFY_HPP
#define GNALC_IR_PASSES_TRANSFORMS_CFGSIMPLIFY_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class CFGSimplifyPass : public PM::PassInfo<CFGSimplifyPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
