// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/loop_fuse.hpp"
#include "ir/instructions/control.hpp"
#include "sir/base.hpp"
#include "sir/passes/analysis/affine_alias_analysis.hpp"
#include "sir/utils.hpp"
#include "sir/visitor.hpp"

#include "constraint/base.hpp"
#include "constraint/omega_test.hpp"

#include <vector>

using namespace CSTR;

namespace SIR {
struct FuseCandidate {
    IList *ilist;
    FORInst *for1;
    FORInst *for2;
};

// FIXME: Refactor this to avoid too much duplication with `AffineAAResult::hasLoopCarriedDependence`.
bool canFuse(AffineAAResult *affine_aa, FORInst *for1, FORInst *for2) {
    auto iv1 = for1->getIndVar().get();
    auto iv2 = for2->getIndVar().get();

    Err::gassert(iv1->getDepth() == iv2->getDepth(), "Fuse what?");
    auto depth = iv1->getDepth();

    // Give up if two FORInst have different iteration domain.
    // TODO: Loop Alignment
    if (!isTriviallyIdentical(iv1->getBase(), iv2->getBase()) ||
        !isTriviallyIdentical(iv1->getStep(), iv2->getStep()) ||
        !isTriviallyIdentical(iv1->getBound(), iv2->getBound()))
        return false;

    // Scalars can't be fused
    if (!affine_aa->isScalarIndependent(for1, for2)) {
        Logger::logDebug("[LoopFuse]: Skipped two loops because unresolved scalar dependency.");
        return false;
    }

    const auto &rw1 = affine_aa->queryInstRW(for1);
    const auto &rw2 = affine_aa->queryInstRW(for2);
    if (!rw1 || !rw2) {
        Logger::logDebug("[LoopFuse]: Skipped two loops because failed to analyze RWInfo.");
        return false;
    }

    OmegaSolver solver;
    // solver.enableDebugDump(std::cerr);

    auto has_bad_dep = [&](const std::set<Value *> &set1, const std::set<Value *> &set2) -> bool {
        for (const auto &v1 : set1) {
            const auto &p1 = affine_aa->queryPointer(v1);
            if (!p1)
                return true;
            if (p1->isScalar())
                continue;

            auto acc1 = p1->array();

            for (const auto &v2 : set2) {
                const auto &p2 = affine_aa->queryPointer(v2);
                if (!p2)
                    return true;
                if (p2->isScalar())
                    continue;

                auto acc2 = p2->array();

                if (acc1.base != acc2.base || acc1.indices.size() != acc2.indices.size())
                    continue;

                // Quick path for same access.
                auto trivially_same = [&]() -> bool {
                    for (size_t i = 0; i < acc1.indices.size(); ++i) {
                        if (!acc1.indices[i].isIsomorphic(acc2.indices[i]))
                            return false;
                    }
                    return true;
                }();
                if (trivially_same)
                    continue;

                solver.reset();

                std::map<IndVar *, VarID> iter1_map; // Iteration 1, IV 1
                std::map<IndVar *, VarID> iter2_map; // Iteration 2, IV 2
                std::map<Value *, VarID> invariant_map;

                std::set<IndVar *> iv_in_expr;
                for (auto &[iv, rng] : acc1.domain)
                    iv_in_expr.insert(iv);
                for (auto &[iv, rng] : acc2.domain)
                    iv_in_expr.insert(iv);

                for (IndVar *iv : iv_in_expr) {
                    auto id = iv->getName().substr(1);
                    iter1_map[iv] = solver.VH.newVar(id + "_1");
                    iter2_map[iv] = solver.VH.newVar(id + "_2");
                }

                for (auto iv : iv_in_expr) {
                    if (iv->getDepth() >= depth)
                        continue;
                    auto iter1_expr = Expr::newVar(iter1_map.at(iv));
                    auto iter2_expr = Expr::newVar(iter2_map.at(iv));
                    solver.addConstraint(Constraint::newEqual(iter1_expr, iter2_expr));
                }

                // Ensure indices are equal
                // We've ensured the dims are equal above.
                size_t dims = acc1.indices.size();
                for (size_t d = 0; d < dims; ++d) {
                    auto e1 = buildConstraintExpr(acc1.indices[d], iter1_map, solver.VH, invariant_map);
                    auto e2 = buildConstraintExpr(acc2.indices[d], iter2_map, solver.VH, invariant_map);
                    solver.addConstraint(Constraint::newEqual(e1, e2));
                }

                // Add iteration domain constraints for each iv
                // TODO: When step != 1, there can be more accurate result.
                for (IndVar *iv : iv_in_expr) {
                    auto it1 = acc1.domain.find(iv);
                    if (it1 != acc1.domain.end()) {
                        auto base = buildConstraintExpr(it1->second.base, iter1_map, solver.VH, invariant_map);
                        auto bound = buildConstraintExpr(it1->second.bound, iter1_map, solver.VH, invariant_map);
                        auto iv_var = Expr::newVar(iter1_map.at(iv));
                        solver.addConstraint(Constraint::newGreaterEqual(iv_var, base));
                        solver.addConstraint(Constraint::newLessThan(iv_var, bound));
                    }

                    auto it2 = acc2.domain.find(iv);
                    if (it2 != acc2.domain.end()) {
                        auto base = buildConstraintExpr(it2->second.base, iter2_map, solver.VH, invariant_map);
                        auto bound = buildConstraintExpr(it2->second.bound, iter2_map, solver.VH, invariant_map);
                        auto iv_var = Expr::newVar(iter2_map.at(iv));
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

                // Ensure iv1 > iv2
                if (iv_in_expr.count(iv1) && iv_in_expr.count(iv2)) {
                    auto iv1_expr = Expr::newVar(iter1_map.at(iv1));
                    auto iv2_expr = Expr::newVar(iter2_map.at(iv2));

                    OmegaSolver s = solver;
                    s.addConstraint(Constraint::newGreaterThan(iv1_expr, iv2_expr));
                    if (s.mayHasIntSolutions())
                        return true;
                } else {
                    if (solver.mayHasIntSolutions())
                        return true;
                }
            }
        }
        return false;
    };

    if (has_bad_dep(rw1->write, rw2->read) || has_bad_dep(rw2->write, rw1->read) ||
        has_bad_dep(rw1->write, rw2->write)) {
        Logger::logDebug("[LoopFuse]: Skipped two adjacent loops ('", for1->getIndVar()->getName(), "' and '",
                         for2->getIndVar()->getName(), "') because unresolved array dependency.");
        return false;
    }

    return true;
}

struct FuseVisitor : ContextVisitor {
    using FuseCandidates = std::vector<FuseCandidate>;
    FuseCandidates *candidates{};
    AffineAAResult *affine_aa;
    size_t fuse_depth;
    bool depth_hit = false;

    explicit FuseVisitor(FuseCandidates *cadidates_, AffineAAResult *affine_aa_, size_t fuse_depth_)
        : candidates(cadidates_), affine_aa(affine_aa_), fuse_depth(fuse_depth_) {}

    void visit(Context ctx, FORInst &for_inst) override {
        if (ctx.depth == fuse_depth) {
            depth_hit = true;

            IList *ilist = ctx.iList();
            auto it = ctx.iter;
            Err::gassert(it != LInstIter{}, "bad iter");
            ++it; // eat current one
            for (; it != ilist->end(); ++it) {
                if (auto for_inst2 = (*it)->as_raw<FORInst>()) {
                    // Now we've found two consecutive FORInst, see if we can fuse them
                    if (canFuse(affine_aa, &for_inst, for_inst2)) {
                        candidates->emplace_back(FuseCandidate{
                            .ilist = ilist,
                            .for1 = &for_inst,
                            .for2 = for_inst2,
                        });
                    }
                    break;
                }
                if (!affine_aa->isIndependent(&for_inst, it->get()))
                    break;
            }
        }

        ContextVisitor::visit(ctx, for_inst);
    }
};

PM::PreservedAnalyses LoopFusePass::run(LinearFunction &function, LFAM &lfam) {
    bool loop_fuse_modified = false;

    auto &affine_aa = lfam.getResult<AffineAliasAnalysis>(function);

    size_t searching_depth = 0;
    while (true) {
        FuseVisitor::FuseCandidates fuse_candidates;
        FuseVisitor visitor{&fuse_candidates, &affine_aa, ++searching_depth};
        function.accept(visitor);

        if (!visitor.depth_hit)
            break;

        for (const auto &[ilist, for1, for2] : fuse_candidates) {
            // Fuse `for1` into `for2`
            // This is safe because we've checked instructions between for1 and for2 are independent to for1.
            // Besides, by doing this, the fused loop can be fused again into another loop.
            // For example,
            //   for1 -> for2 -> for3
            // Through FuseVisitor, we got { (for1, for2), (for2, for3) }
            // Fuse the first one into the second can avoid the pointer being invalidated
            for1->getIndVar()->replaceSelf(for2->getIndVar());
            for2->getBodyInsts().insert(for2->getBodyInsts().begin(), for1->getBodyInsts().begin(),
                                        for1->getBodyInsts().end());

            // Append debug data before we delete it.
            for2->appendDbgData(for1->getDbgData());
            for2->appendDbgData("fused=" + for1->getIndVar()->getName());

            Logger::logDebug("[LoopFuse]: Fused affine for '", for1->getIndVar()->getName(), "' into '",
                             for2->getIndVar()->getName(), "'");
            IListDel(*ilist, for1);

            affine_aa = lfam.getFreshResult<AffineAliasAnalysis>(function);
            loop_fuse_modified = true;

            // Revisit this depth
            --searching_depth;
        }
    }

    return loop_fuse_modified ? PreserveNone() : PreserveAll();
}
} // namespace SIR