#include "ir/passes/transforms/jump_threading.hpp"
#include "ir/instructions/control.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"

namespace IR {
PM::PreservedAnalyses JumpThreadingPass::run(Function &function, FAM &fam) {
    bool jump_threading_cfg_modified = false;

    // ...

    return jump_threading_cfg_modified ? PreserveNone() : PreserveCFGAnalyses();
}

} // namespace IR