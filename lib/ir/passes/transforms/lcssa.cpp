#include "../../../../include/ir/passes/transforms/lcssa.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses LCSSAPass::run(Function &function, FAM &fam) {
    bool lcssa_cfg_modified = false;

    if (lcssa_cfg_modified)
        return PM::PreservedAnalyses::none();

    PM::PreservedAnalyses pa;
    pa.preserve<DomTreeAnalysis>();
    pa.preserve<PostDomTreeAnalysis>();
    return pa;
}

} // namespace IR