// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "pass_manager/pass_manager.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "ir/passes/pass_manager.hpp"

namespace PM {
template class AnalysisManager<IR::Module>;
template class AnalysisManager<IR::Function>;

template class PassManager<IR::Module>;
template class PassManager<IR::Function>;

template class InnerAnalysisManagerProxy<AnalysisManager<IR::Function>, IR::Module>;

template class AnalysisStorage<IR::Function>;
template class AnalysisStorage<IR::Module>;
} // namespace PM

namespace IR {
namespace Lower {
FAS gFunctionAnalysisStorage;
}

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