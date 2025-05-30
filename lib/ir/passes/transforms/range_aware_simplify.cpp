#include "ir/passes/transforms/range_aware_simplify.hpp"
#include "ir/passes/analysis/range_analysis.hpp"

#include <vector>

namespace IR {
PM::PreservedAnalyses RangeAwareSimplifyPass::run(Function &function, FAM &fam) {
    return PreserveAll();
    bool modified = false;
    auto ranges = fam.getResult<RangeAnalysis>(function);

    for (auto &block : function) {
        for (auto &inst : *block) {

        }
    }

    return modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR