#include "../../../../include/ir/passes/transforms/jump_threading.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses JumpThreadingPass::run(Function &function, FAM &fam) {
    bool jump_threading_cfg_modified = false;

    // ...

    return jump_threading_cfg_modified ? PreserveNone() : PreserveCFGAnalyses();
}

} // namespace IR