#include "../../../../include/ir/passes/transforms/load_elimination.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <algorithm>

namespace IR {
PM::PreservedAnalyses LoadEliminationPass::run(Function &function, FAM &fam) {
    bool load_elimination_inst_modified = false;

    if (load_elimination_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        return pa;
    }
    return PM::PreservedAnalyses::all();
}

} // namespace IR