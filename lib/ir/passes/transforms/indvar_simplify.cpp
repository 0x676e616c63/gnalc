#include "../../../../include/ir/passes/transforms/indvar_simplify.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/analysis/scev.hpp"

namespace IR {
PM::PreservedAnalyses IndVarSimplifyPass::run(Function &function, FAM &fam) {
    bool iv_simplify_inst_modified = false;
    return iv_simplify_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR