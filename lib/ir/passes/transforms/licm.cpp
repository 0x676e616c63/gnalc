#include "../../../../include/ir/passes/transforms/licm.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses LICMPass::run(Function &function, FAM &fam) {
    bool lcssa_inst_modified = false;

    if (lcssa_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        pa.preserve<LoopAnalysis>();
        return pa;
    }
    return PM::PreservedAnalyses::all();
}

} // namespace IR