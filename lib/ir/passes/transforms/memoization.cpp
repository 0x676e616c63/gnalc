#include "ir/passes/transforms/memoization.hpp"

#include "config/config.hpp"
#include "ir/instructions/control.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/basic_alias_analysis.hpp"

#include <string>
#include <vector>

namespace IR {
PM::PreservedAnalyses MemoizePass::run(Function &function, FAM &fam) {
    bool memo_modified = false;

    // Memoize pure recursive functions
    if (!isPure(fam, &function) || !function.isRecursive())
        return PreserveAll();

    // auto memo_lookup = function.getParent()->lookupFunction(Config::IR::MEMOIZATION_LOOKUP_INTRINSIC_NAME);


    return memo_modified ? PreserveNone() : PreserveAll();
}
} // namespace IR