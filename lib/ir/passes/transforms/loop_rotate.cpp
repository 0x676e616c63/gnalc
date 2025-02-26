#include "../../../../include/ir/passes/transforms/loop_rotate.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include <deque>

namespace IR {
PM::PreservedAnalyses LoopRotatePass::run(Function &function, FAM &fam) {
    bool loop_rotate_cfg_modified = false;

    if (loop_rotate_cfg_modified)
        return PM::PreservedAnalyses::none();

    PM::PreservedAnalyses pa;
    pa.preserve<DomTreeAnalysis>();
    pa.preserve<PostDomTreeAnalysis>();
    return pa;
}

} // namespace IR