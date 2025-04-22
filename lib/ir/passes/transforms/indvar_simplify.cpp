#include "ir/passes/transforms/indvar_simplify.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"

namespace IR {
PM::PreservedAnalyses IndVarSimplifyPass::run(Function &function, FAM &fam) {
    bool iv_simplify_inst_modified = false;
    return iv_simplify_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR