// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/constant_fold.hpp"

#include "ir/passes/helpers/constant_fold.hpp"

#include "ir/instructions/compare.hpp"
#include "sir/visitor.hpp"

#include <optional>
#include <vector>
#include <utility>

namespace SIR {
struct RangeFoldVisitor : ContextVisitor {
    std::vector<std::pair<pIcmp, bool>> candidates;

    void visit(Context ctx, FORInst &for_inst) override {
        auto iv = for_inst.getIndVar();
        if (!iv->isConstantDomain()) {
            ContextVisitor::visit(ctx, for_inst);
            return;
        }

        int base = iv->getBase()->as<ConstantInt>()->getVal();
        int bound = iv->getBound()->as<ConstantInt>()->getVal();
        for (const auto &user : iv->inst_users()) {
            auto icmp = user->as<ICMPInst>();
            if (!icmp)
                continue;

            auto lhs = icmp->getLHS();
            auto rhs = icmp->getRHS();
            auto cond = icmp->getCond();
            if (rhs == iv)
                cond = reverseCond(cond);
            if (rhs->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                continue;
            auto rhs_ci = rhs->as<ConstantInt>()->getVal();

            auto icmp_res = [&]() -> std::optional<bool> {
                switch (icmp->getCond()) {
                case ICMPOP::eq:
                    if (rhs_ci < base || rhs_ci >= bound)
                        return false;
                    break;
                case ICMPOP::ne:
                    if (rhs_ci < base && rhs_ci >= bound)
                        return true;
                    break;
                case ICMPOP::slt:
                    if (rhs_ci >= bound)
                        return true;
                    break;
                case ICMPOP::sle:
                    if (rhs_ci >= bound + 1)
                        return true;
                    break;
                case ICMPOP::sgt:
                    if (rhs_ci < base)
                        return true;
                    break;
                case ICMPOP::sge:
                    if (rhs_ci <= base)
                        return true;
                    break;
                default:
                    Err::unreachable();
                }
                return std::nullopt;
            }();
            if (icmp_res)
                candidates.emplace_back(icmp, *icmp_res);
        }
        ContextVisitor::visit(ctx, for_inst);
    }
};

struct FoldCandidate {
    LInstIter if_iter;
    IList *reachable_ilist;
    IList *parent_ilist;
};
struct FoldIfVisitor : ContextVisitor {
    using Candidates = std::vector<FoldCandidate>;
    Candidates *candidates;
    void visit(Context ctx, IFInst &if_inst) override {
        ContextVisitor::visit(ctx, if_inst);

        if (auto ci1 = if_inst.getCond()->as<ConstantI1>()) {
            candidates->emplace_back(
                FoldCandidate{.if_iter = ctx.iter,
                              .reachable_ilist = ci1->getVal() ? &if_inst.getBodyInsts() : &if_inst.getElseInsts(),
                              .parent_ilist = ctx.iList()});
        }
    }
    explicit FoldIfVisitor(Candidates *candidates_) : candidates(candidates_) {}
};

PM::PreservedAnalyses ConstantFoldPass::run(LinearFunction &function, LFAM &lfam) {
    bool fold_inst_modified = false;

    RangeFoldVisitor range_fold_visitor;
    function.accept(range_fold_visitor);
    for (const auto &[icmp, res] : range_fold_visitor.candidates) {
        icmp->replaceSelf(function.getConst(res));
        Logger::logDebug("[ConstantFold]: Folded icmp '", icmp->getName(), "' to '", res,
            "' by induction variable range.");
        fold_inst_modified = true;
    }

    for (const auto &inst : function.nested_insts()) {
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

    for (const auto &[if_iter, reachable_ilist, parent_ilist] : candidates) {
        parent_ilist->insert(if_iter, reachable_ilist->begin(), reachable_ilist->end());
        parent_ilist->erase(if_iter);
        fold_inst_modified = true;
    }

    return fold_inst_modified ? PreserveNone() : PreserveAll();
}
} // namespace SIR