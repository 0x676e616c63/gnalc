#include "../../../../include/ir/passes/transforms/loop_simplify.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses LoopSimplifyPass::run(Function &function, FAM &fam) {
    bool loop_simplify_cfg_modified = false;

    auto loop_info = fam.getResult<LoopAnalysis>(function);

    if (loop_simplify_cfg_modified)
        return PM::PreservedAnalyses::none();

    PM::PreservedAnalyses pa;
    pa.preserve<DomTreeAnalysis>();
    pa.preserve<PostDomTreeAnalysis>();
    pa.preserve<LoopAnalysis>();
    return pa;
}

} // namespace IR