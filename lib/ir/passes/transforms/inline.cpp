#include "../../../../include/ir/passes/transforms/inline.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses InlinePass::run(Function &function, FAM &fam) {
    bool inline_cfg_modified = false;

    /// ...

    if (inline_cfg_modified)
        return PM::PreservedAnalyses::none();

    return PM::PreservedAnalyses::all();
}

} // namespace IR