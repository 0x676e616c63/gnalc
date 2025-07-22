// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/sir/passes/transforms/constant_fold.hpp"

#include "../../../../include/ir/passes/helpers/constant_fold.hpp"

#include "../../../../include/sir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/sir/visitor.hpp"

namespace SIR {
struct FoldCandidate {
    LInstIter if_iter;
    IList* reachable_ilist;
    IList* parent_ilist;
};
struct FoldIfVisitor : ContextVisitor {
    using Candidates = std::vector<FoldCandidate>;
    Candidates* candidates;
    void visit(Context ctx, IFInst &if_inst) override {
        ContextVisitor::visit(ctx, if_inst);

        if (auto ci1 = if_inst.getCond()->as<ConstantI1>()) {
            candidates->emplace_back(FoldCandidate{
                .if_iter = ctx.iter,
                .reachable_ilist = ci1->getVal() ? &if_inst.getBodyInsts() : &if_inst.getElseInsts(),
                .parent_ilist = ctx.iList()
            });
        }
    }
    explicit FoldIfVisitor(Candidates* candidates_) : candidates(candidates_) {}
};

PM::PreservedAnalyses ConstantFoldPass::run(LinearFunction &function, LFAM &lfam) {
    bool fold_inst_modified = false;

    for (const auto& inst : function.nested_insts()) {
        auto folded = foldConstant(function.getConstantPool(), inst);
        if (folded != inst) {
            inst->replaceSelf(folded);
            fold_inst_modified = true;
        }
    }

    // Fold IFInst
    FoldIfVisitor::Candidates candidates;
    FoldIfVisitor visitor(&candidates);
    function.accept(visitor);

    for (const auto& [if_iter, reachable_ilist, parent_ilist] : candidates) {
        parent_ilist->insert(if_iter, reachable_ilist->begin(), reachable_ilist->end());
        parent_ilist->erase(if_iter);
        fold_inst_modified = true;
    }

    return fold_inst_modified ? PreserveNone() : PreserveAll();
}
} // namespace SIR