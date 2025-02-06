#include "../../../../include/ir/passes/transforms/dse.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses DSEPass::run(Function &function, FAM &fam) {
    bool dse_inst_modified = false;

    if (dse_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}

} // namespace IR