// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/early_parallel.hpp"

#include "ir/instructions/memory.hpp"
#include "sir/passes/analysis/affine_alias_analysis.hpp"
#include "sir/visitor.hpp"

namespace SIR {
struct ParallelCandidate {
    pForInst for_inst;
    LInstIter iter;
};
struct ParallelVisitor : ContextVisitor {
    using Candidates = std::vector<ParallelCandidate>;
    Candidates* candidates;
    AffineAAResult* affine_aa;

    ParallelVisitor(Candidates* candidates_, AffineAAResult* affine_aa_)
        : candidates(candidates_), affine_aa(affine_aa_) { }
};

PM::PreservedAnalyses EarlyParallelPass::run(LinearFunction &function, LFAM &lfam) {
    auto& affine_aa = lfam.getResult<AffineAliasAnalysis>(function);

    ParallelVisitor::Candidates candidates;
    ParallelVisitor visitor(&candidates, &affine_aa);
    function.accept(visitor);
    if (candidates.empty())
        return PreserveAll();

    for (auto& candidate : candidates) {

    }

    return PreserveNone();
}

} // namespace SIR