// Automatic function memoization
// Note that this it's not a typo. The term is indeed "memoization", not "memorization".
// https://en.wikipedia.org/wiki/Memoization
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_MEMOIZATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_MEMOIZATION_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class MemoizePass : public PM::PassInfo<MemoizePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
