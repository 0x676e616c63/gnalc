#include "../../../../include/ir/passes/transforms/loop_strength_reduce.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/analysis/scev.hpp"

namespace IR {
PM::PreservedAnalyses LoopStrengthReducePass::run(Function &function, FAM &fam) {
    bool lsr_inst_modified = false;

    return lsr_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR