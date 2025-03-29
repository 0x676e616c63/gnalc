#include "../../../include/pass_manager/pass_manager.hpp"
#include "../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../include/ir/passes/pass_manager.hpp"

namespace PM {
template class AnalysisManager<IR::Module>;
template class AnalysisManager<IR::Function>;

template class PassManager<IR::Module>;
template class PassManager<IR::Function>;

template class InnerAnalysisManagerProxy<AnalysisManager<IR::Function>, IR::Module>;
} // namespace PM

namespace IR {
PM::PreservedAnalyses PreserveAll() { return PM::PreservedAnalyses::all(); }

PM::PreservedAnalyses PreserveNone() { return PM::PreservedAnalyses::none(); }

PM::PreservedAnalyses PreserveCFGAnalyses() {
    PM::PreservedAnalyses pa;
    pa.preserve<DomTreeAnalysis>();
    pa.preserve<PostDomTreeAnalysis>();
    pa.preserve<LoopAnalysis>();
    return pa;
}

PM::PreservedAnalyses PreserveLoopAnalyses() {
    PM::PreservedAnalyses pa;
    pa.preserve<LoopAnalysis>();
    return pa;
}
} // namespace IR