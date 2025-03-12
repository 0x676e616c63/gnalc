#include "../../../../include/ir/passes/transforms/loop_unroll.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses LoopUnrollPass::run(Function &function, FAM &fam) {
    bool loop_unroll_cfg_modified = false;

    return loop_unroll_cfg_modified ? PreserveLoopAnalyses() : PreserveCFGAnalyses();
}

} // namespace IR