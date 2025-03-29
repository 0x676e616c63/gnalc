#include "../../../../include/ir/passes/transforms/sroa.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"

#include <vector>

namespace IR {
PM::PreservedAnalyses SROAPass::run(Function &function, FAM &fam) {
    bool sroa_inst_modified = false;

    return sroa_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR