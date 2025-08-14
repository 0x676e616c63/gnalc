// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/constraint_elimination.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"

#include "constraint/base.hpp"
#include "constraint/omega_test.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/match.hpp"
#include "ir/passes/analysis/range_analysis.hpp"
#include "utils/fast_set.hpp"

using namespace CSTR;

namespace IR {
std::optional<CoeT> toCoeType(const pVal &val) {
    if (val->getVTrait() != ValueTrait::CONSTANT_LITERAL)
        return std::nullopt;
    if (auto ci32 = val->as<ConstantInt>())
        return ci32->getVal();
    if (auto ci64 = val->as<ConstantInt>())
        return ci64->getVal();
    Err::unreachable("Unhandled integer type.");
    return 0;
}

Expr ConstraintEliminationPass::asExpr(const pVal &val) {
    // Fallback
    auto asVarExpr = [this](const pVal &val) -> Expr {
        auto it = value_to_var.find(val);
        if (it != value_to_var.end())
            return Expr::newVar(it->second);
        auto newVar = solver.VH.newVar(val->getName());
        value_to_var[val] = newVar;
        return Expr::newVar(newVar);
    };

    Err::gassert(val->getType()->isInteger());

    if (auto coe = toCoeType(val))
        return Expr::newConst(*coe);

    auto binary = val->as<BinaryInst>();
    if (!binary)
        return asVarExpr(val);

    auto lhs = binary->getLHS();
    auto rhs = binary->getRHS();
    switch (binary->getOpcode()) {
    case OP::ADD:
        return asExpr(lhs) + asExpr(rhs);
    case OP::SUB:
        return asExpr(lhs) - asExpr(rhs);
    case OP::MUL: {
        auto lhs_coe = toCoeType(lhs);
        auto rhs_coe = toCoeType(rhs);
        if (lhs_coe)
            return asExpr(rhs) * *lhs_coe;
        if (rhs_coe)
            return asExpr(lhs) * *rhs_coe;

        return asVarExpr(val);
    }

    // TODO: Support div and rem.
    // "The Omega Test: a fast and practical integer programming algorithm for dependence analysis":
    // Chapter 3 Nonlinear subscripts:
    //   Assume an expression e appears in a program that can be expressed as e = α div m,
    //   where m is a positive integer. To handle this, we define a new variable σ, add the
    //   inequality constraints 0 ≤ α − mσ ≤ m − 1 and use σ as the value of e.
    //   Similarly, if e = α mod m we would add the same inequality constraint
    //   but use α − mσ as the value of e.
    case OP::SDIV:
    case OP::UDIV: {
        if (auto rhs_coe = toCoeType(binary->getRHS())) {
            // TODO: Scale it if not 1.
            if (*rhs_coe == 1)
                return asExpr(binary->getRHS());
        }
        return asVarExpr(val);
    }
    default:
        break;
    }

    return asVarExpr(val);
}

// Returns std::nullopt if the comparison is not representable
std::optional<Constraint> ConstraintEliminationPass::convertIcmp(const pIcmp &icmp, bool negate) {
    auto lhs = icmp->getLHS();
    auto rhs = icmp->getRHS();
    auto vlhs = asExpr(lhs);
    auto vrhs = asExpr(rhs);
    auto cond = icmp->getCond();

    if (negate)
        cond = flipCond(cond);

    switch (cond) {
    case ICMPOP::eq:
        return Constraint::newEqual(vlhs, vrhs);
    case ICMPOP::sge:
        return Constraint::newGreaterEqual(vlhs, vrhs);
    case ICMPOP::sgt:
        return Constraint::newGreaterThan(vlhs, vrhs);
    case ICMPOP::sle:
        return Constraint::newLessEqual(vlhs, vrhs);
    case ICMPOP::slt:
        return Constraint::newLessThan(vlhs, vrhs);
    default:
        return std::nullopt;
    }
    return std::nullopt;
}

PM::PreservedAnalyses ConstraintEliminationPass::run(Function &function, FAM &fam) {
    domtree = &fam.getResult<DomTreeAnalysis>(function);

    using CSTRSet = Util::FastSet<Constraint, ConstraintHash>;
    std::unordered_map<pBlock, CSTRSet> block_constraints;

    // Compute Block Predicates
    bool changed = true;
    while (changed) {
        changed = false;

        for (auto &bb : function) {
            const auto &old_P = block_constraints[bb];

            std::vector<CSTRSet> incomings;
            for (auto &pred_candidate : function) {
                for (auto succ : pred_candidate->succs()) {
                    if (succ != bb)
                        continue;

                    auto edge_constraints = block_constraints[pred_candidate];

                    if (auto pred_br = pred_candidate->getBRInst()) {
                        if (pred_br->isConditional()) {
                            if (auto icmp = pred_br->getCond()->as<ICMPInst>()) {
                                if (auto C = convertIcmp(icmp, /* negate if */ pred_br->getFalseDest() == bb))
                                    edge_constraints.insert(*C);
                            }
                        }
                    }

                    incomings.emplace_back(std::move(edge_constraints));
                }
            }

            CSTRSet new_P;
            if (!incomings.empty()) {
                const auto &first = incomings.front();
                for (const auto &c : first) {
                    bool in_all = true;
                    for (size_t i = 1; i < incomings.size(); ++i) {
                        if (!incomings[i].count(c)) {
                            in_all = false;
                            break;
                        }
                    }
                    if (in_all)
                        new_P.insert(c);
                }
            }

            if (new_P != old_P) {
                block_constraints[bb] = std::move(new_P);
                changed = true;
            }
        }
    }

    // Add Range Constraint
    if (with_range_analysis) {
        auto &ranges = fam.getResult<RangeAnalysis>(function);
        for (const auto &[v, ctx_rng] : ranges.getIntRangeMap()) {
            for (const auto &[bb, rng] : ctx_rng.getContextualMap()) {
                auto &cstr = block_constraints[bb->as<BasicBlock>()];
                auto expr = asExpr(v->as<Value>());
                if (rng.min != IRng::MIN)
                    cstr.insert(Constraint::newGreaterEqual(expr, Expr::newConst(rng.min)));
                if (rng.max != IRng::MAX)
                    cstr.insert(Constraint::newLessEqual(expr, Expr::newConst(rng.max)));
            }
        }
    }

    // Collect candidates
    std::vector<std::tuple<pBlock, pIcmp, pBr>> candidates;
    for (auto &bb : function) {
        if (auto br = bb->getBRInst()) {
            if (br->isConditional()) {
                if (auto icmp = br->getCond()->as<ICMPInst>()) {
                    if (!block_constraints[bb].empty())
                        candidates.emplace_back(bb, icmp, br);
                }
            }
        }
    }

    // solver.enableDebugDump(std::cerr);

    // Do elimination
    std::vector<pIcmp> eliminated_icmp;
    std::vector<pBr> eliminated_br;
    for (const auto &[bb, icmp, br] : candidates) {
        auto P = block_constraints[bb];
        Err::gassert(!P.empty(), "Bad candidate.");

        auto C = convertIcmp(icmp, /* negate */ false);
        auto not_C = convertIcmp(icmp, /* negate */ true);
        if (!C && !not_C)
            continue;

        // If (P && !C) is unsatisfiable, then P => C, this icmp is always true.
        if (not_C) {
            OmegaSolver true_solver = solver;
            true_solver.addConstraints(P);
            true_solver.addConstraint(*not_C);
            if (!true_solver.mayHasIntSolutions()) {
                icmp->replaceSelf(function.getConst(true));
                eliminated_icmp.push_back(icmp);
                eliminated_br.emplace_back(br);
                Logger::logDebug("[CSTRElim]: ICMPInst '", icmp->getName(), "' proved to be true.");
                continue;
            }
        }

        // If (P && C) is unsatisfiable, then P => !C, this icmp is always false.
        if (C) {
            OmegaSolver false_solver = solver;
            false_solver.addConstraints(P);
            false_solver.addConstraint(*C);
            if (!false_solver.mayHasIntSolutions()) {
                icmp->replaceSelf(function.getConst(false));
                eliminated_icmp.push_back(icmp);
                eliminated_br.emplace_back(br);
                Logger::logDebug("[CSTRElim]: ICMPInst '", icmp->getName(), "' proved to be false.");
                continue;
            }
        }
    }

    solver.reset();
    value_to_var.clear();
    domtree = nullptr;

    if (eliminated_icmp.empty())
        return PreserveAll();

    // Same as RangeAwareSimplify
    std::set<pPhi> dead_phis;
    for (const auto &br : eliminated_br) {
        if (match(br->getCond(), M::Is(true)))
            safeUnlinkBB(br->getParent(), br->getFalseDest(), dead_phis);
        else if (match(br->getCond(), M::Is(false)))
            safeUnlinkBB(br->getParent(), br->getTrueDest(), dead_phis);
    }

    for (const auto &i : eliminated_icmp)
        i->getParent()->delFirstOfInst(i);

    auto dfv = function.getDFVisitor();
    std::unordered_set live(dfv.begin(), dfv.end());
    for (const auto &block : function) {
        if (live.find(block) == live.end()) {
            auto succs = block->getNextBB();
            for (const auto &succ : succs)
                safeUnlinkBB(block, succ, dead_phis);
        }
    }

    function.delBlockIf([&live](const auto &bb) { return live.find(bb) == live.end(); });

    for (auto &block : function) {
        block->delInstIf(
            [&dead_phis](const auto &p) { return dead_phis.find(p->template as<PHIInst>()) != dead_phis.end(); },
            BasicBlock::DEL_MODE::PHI);
    }

    return PreserveNone();
}
} // namespace IR