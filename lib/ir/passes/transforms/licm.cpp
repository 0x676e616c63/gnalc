#include "../../../../include/ir/passes/transforms/licm.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses LICMPass::run(Function &function, FAM &fam) {
    bool licm_inst_modified = false;

    return licm_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR