#include "ir/passes/transforms/sroa.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"

namespace IR {
PM::PreservedAnalyses SROAPass::run(Function &function, FAM &fam) {
    bool sroa_inst_modified = false;

    return sroa_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR