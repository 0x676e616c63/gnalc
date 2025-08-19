// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/loop_interchange.hpp"

#include "config/config.hpp"
#include "ir/block_utils.hpp"
#include "sir/base.hpp"
#include "sir/passes/analysis/affine_alias_analysis.hpp"
#include "sir/visitor.hpp"

#include "constraint/base.hpp"
#include "constraint/omega_test.hpp"
#include "sir/passes/transforms/relayout.hpp"

using namespace CSTR;

namespace SIR {
// a[inner][outer] to a[outer][inner] is beneficial
// Negative for profitable.
int getInterchangeCost(const ArrayAccess &arr, IndVar *outer_iv, IndVar *inner_iv) {
    int outer_idx = -1;
    int inner_idx = -1;
    for (int d = 0; d < arr.indices.size(); ++d) {
        if (arr.indices[d].coeffs.count(outer_iv))
            outer_idx = d;
        if (arr.indices[d].coeffs.count(inner_iv))
            inner_idx = d;
    }
    if (outer_idx == -1 || inner_idx == -1)
        return 0;
    return (inner_idx < outer_idx) ? -1 : 1;
}

// Note that this is also used by loop tiling.
bool canInterchange(AffineAAResult *affine_aa, FORInst *for_outer, FORInst *for_inner) {
    IndVar *iv_outer = for_outer->getIndVar().get();
    IndVar *iv_inner = for_inner->getIndVar().get();
    if (!iv_outer || !iv_inner)
        return false;

    Err::gassert(iv_inner->getDepth() > iv_outer->getDepth(), "Interchange what?");

    const auto rw = affine_aa->queryInstRW(for_outer);
    if (!rw)
        return false;

    auto has_bad_dep = [&](const std::set<Value *> &set1, const std::set<Value *> &set2) -> bool {
        for (const auto &v1 : set1) {
            const auto &p1 = affine_aa->queryPointer(v1);
            if (!p1)
                return true;
            if (p1->isScalar())
                continue;

            auto acc1 = p1->array();

            for (const auto &v2 : set2) {
                if (v1 == v2)
                    continue;

                const auto &p2 = affine_aa->queryPointer(v2);
                if (!p2)
                    return true;
                if (p2->isScalar())
                    continue;

                auto acc2 = p2->array();

                if (acc1 == acc2 || acc1.base != acc2.base || acc1.indices.size() != acc2.indices.size())
                    continue;

                OmegaSolver solver;
                // solver.enableDebugDump(std::cerr);

                std::map<IndVar *, VarID> iv1_map;
                std::map<IndVar *, VarID> iv2_map;
                std::map<Value *, VarID> invariant_map;

                std::set<IndVar *> iv_in_expr;
                for (auto &[iv, rng] : acc1.domain)
                    iv_in_expr.insert(iv);
                for (auto &[iv, rng] : acc2.domain)
                    iv_in_expr.insert(iv);

                for (IndVar *iv : iv_in_expr) {
                    auto id = iv->getName().substr(1);
                    iv1_map[iv] = solver.VH.newVar(id + "_1");
                    iv2_map[iv] = solver.VH.newVar(id + "_2");
                }

                for (auto iv : iv_in_expr) {
                    if (iv->getDepth() >= iv_outer->getDepth())
                        continue;
                    auto e1 = Expr::newVar(iv1_map.at(iv));
                    auto e2 = Expr::newVar(iv2_map.at(iv));
                    solver.addConstraint(Constraint::newEqual(e1, e2));
                }

                // Ensure the memory addresses (all indices) are equal -> dependence exists
                size_t dims = acc1.indices.size();
                for (size_t d = 0; d < dims; ++d) {
                    auto e1 = buildConstraintExpr(acc1.indices[d], iv1_map, solver.VH, invariant_map);
                    auto e2 = buildConstraintExpr(acc2.indices[d], iv2_map, solver.VH, invariant_map);
                    solver.addConstraint(Constraint::newEqual(e1, e2));
                }

                // Add iteration domain constraints for each iv
                // TODO: When step != 1, there can be more accurate result.
                for (IndVar *iv : iv_in_expr) {
                    auto it1 = acc1.domain.find(iv);
                    if (it1 != acc1.domain.end()) {
                        auto base = buildConstraintExpr(it1->second.base, iv1_map, solver.VH, invariant_map);
                        auto bound = buildConstraintExpr(it1->second.bound, iv1_map, solver.VH, invariant_map);
                        auto iv_var = Expr::newVar(iv1_map.at(iv));
                        solver.addConstraint(Constraint::newGreaterEqual(iv_var, base));
                        solver.addConstraint(Constraint::newLessThan(iv_var, bound));
                    }

                    auto it2 = acc2.domain.find(iv);
                    if (it2 != acc2.domain.end()) {
                        auto base = buildConstraintExpr(it2->second.base, iv2_map, solver.VH, invariant_map);
                        auto bound = buildConstraintExpr(it2->second.bound, iv2_map, solver.VH, invariant_map);
                        auto iv_var = Expr::newVar(iv2_map.at(iv));
                        solver.addConstraint(Constraint::newGreaterEqual(iv_var, base));
                        solver.addConstraint(Constraint::newLessThan(iv_var, bound));
                    }
                }

                // Add invariant iv range
                // Don't introduce more parameters here, they are not related to current problem.
                for (const auto &[invariant, var] : invariant_map) {
                    auto iv = invariant->as<IndVar>();
                    if (!iv)
                        continue;

                    auto expr = Expr::newVar(var);
                    if (auto base_ci = iv->getBase()->as<ConstantInt>())
                        solver.addConstraint(Constraint::newGreaterEqual(expr, Expr::newConst(base_ci->getVal())));
                    else if (auto it = invariant_map.find(iv->getBase().get()); it != invariant_map.end())
                        solver.addConstraint(Constraint::newGreaterEqual(expr, Expr::newVar(it->second)));

                    if (auto bound_ci = iv->getBound()->as<ConstantInt>())
                        solver.addConstraint(Constraint::newLessThan(expr, Expr::newConst(bound_ci->getVal())));
                    else if (auto it = invariant_map.find(iv->getBound().get()); it != invariant_map.end())
                        solver.addConstraint(Constraint::newLessThan(expr, Expr::newVar(it->second)));
                }

                // std::cerr << "Candidate: " << v1->getName() << " and " << v2->getName() << std::endl;

                // Now add the *bad* ordering constraint:
                // d_outer = iv1_outer - iv2_outer  (we want d_outer > 0  -> iv1_outer > iv2_outer)
                // d_inner = iv1_inner - iv2_inner  (we want d_inner < 0 -> iv1_inner < iv2_inner)
                // If there exists integer solution satisfying all constraints + these, then interchange is illegal.
                if (iv_in_expr.count(iv_outer) && iv_in_expr.count(iv_inner)) {
                    auto outerA = Expr::newVar(iv1_map.at(iv_outer));
                    auto outerB = Expr::newVar(iv2_map.at(iv_outer));
                    auto innerA = Expr::newVar(iv1_map.at(iv_inner));
                    auto innerB = Expr::newVar(iv2_map.at(iv_inner));

                    // create a solver copy where we assert outerA > outerB and innerA < innerB
                    {
                        OmegaSolver s = solver;
                        s.addConstraint(Constraint::newGreaterThan(outerA, outerB)); // d_outer > 0
                        s.addConstraint(Constraint::newLessThan(innerA, innerB));    // d_inner < 0
                        // found a "bad" dependence -> cannot interchange
                        if (s.mayHasIntSolutions())
                            return true;
                    }
                }
                // If either of the two induction variables does not appear in the access,
                // one or both d_inner/d_outer are 0. In that case, there can't be `d_outer > 0 && d_inner < 0`.
                // So just continue to check next access.
            }
        }
        return false;
    };

    if (has_bad_dep(rw->read, rw->write) || has_bad_dep(rw->write, rw->write))
        return false;

    return true;
}

// Checks if two loops are safe to interchange
bool isSafeAndProfitableToInterchange(AffineAAResult *affine_aa, FORInst *outer_for, FORInst *inner_for) {
    auto outer_iv = outer_for->getIndVar();
    auto inner_iv = inner_for->getIndVar();

    // Independent Bounds
    if (auto base2_inst = inner_iv->getBase()->as<Instruction>()) {
        if (AhasUseToB(base2_inst, outer_iv))
            return false;
    }
    if (auto bound2_inst = inner_iv->getBound()->as<Instruction>()) {
        if (AhasUseToB(bound2_inst, outer_iv))
            return false;
    }

    // Scalar dependent loops can't be interchanged
    if (!affine_aa->isScalarIndependent(outer_for, inner_for))
        return false;

    if (!canInterchange(affine_aa, outer_for, inner_for))
        return false;

    Logger::logDebug("[Interchange]: Found two interchangeable affine fors '",
        outer_for->getIndVar()->getName(), "' and '", inner_for->getIndVar()->getName(), "'.");

    const auto &rw = affine_aa->queryInstRW(outer_for);
    if (!rw)
        return false;

    int cost = 0;
    // Now check memory dependencies
    for (const auto &s1 : rw->write) {
        const auto &a1 = affine_aa->queryPointer(s1);
        if (!a1)
            return false;
        if (!a1->isArray())
            continue;

        cost += getInterchangeCost(a1->array(), outer_iv.get(), inner_iv.get());

        for (const auto &s2 : rw->read) {
            const auto &a2 = affine_aa->queryPointer(s2);
            if (!a2)
                return false;
            if (!a2->isArray())
                continue;

            cost += getInterchangeCost(a2->array(), outer_iv.get(), inner_iv.get());
        }
    }

    if (cost < -Config::SIR::LOOP_INTERCHANGE_BENEFIT_THRESHOLD) {
        Logger::logDebug("[Interchange]: Interchanging with cost: ", cost);
        return true;
    }

    Logger::logDebug("[Interchange]: Interchange cancelled due to high cost (", cost, ").");
    return false;
}

struct InterchangeVisitor : ContextVisitor {
    using ICCandidates = std::vector<std::pair<FORInst *, FORInst *>>;

    ICCandidates *candidates;
    AffineAAResult *affine_aa;

    void visit(Context ctx, FORInst &for_inst) override {
        // Start from the innermost loop, this can let us interchange all loops in one go.
        ContextVisitor::visit(ctx, for_inst);

        // Only interchange perfectly nested loops
        if (for_inst.getBodyInsts().size() == 1) {
            if (auto inner_for = for_inst.getBodyInsts().back()->as_raw<FORInst>()) {
                if (isSafeAndProfitableToInterchange(affine_aa, &for_inst, inner_for))
                    candidates->emplace_back(&for_inst, inner_for);
            }
        }
    }

    InterchangeVisitor(AffineAAResult *affine_aa_, ICCandidates *candidates_)
        : affine_aa(affine_aa_), candidates(candidates_) {}
};

PM::PreservedAnalyses LoopInterchangePass::run(LinearFunction &function, LFAM &lfam) {
    auto &affine_aa = lfam.getResult<AffineAliasAnalysis>(function);
    InterchangeVisitor::ICCandidates candidates;
    InterchangeVisitor visitor(&affine_aa, &candidates);
    function.accept(visitor);

    if (candidates.empty())
        return PreserveAll();

    for (const auto &[outer, inner] : candidates) {
        std::swap(outer->indvar, inner->indvar);
        outer->indvar->swapDepth(*inner->indvar);
        Logger::logDebug("[Interchange]: Interchanged '", outer->indvar->getName(), "' and '", inner->indvar->getName(),
                         "'.");
    }

    return PreserveNone();
}
} // namespace SIR