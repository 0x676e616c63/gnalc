// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/loop_tiling.hpp"
#include "sir/passes/transforms/loop_interchange.hpp"

#include "config/config.hpp"
#include "ir/block_utils.hpp"
#include "sir/base.hpp"
#include "sir/passes/analysis/affine_alias_analysis.hpp"
#include "sir/visitor.hpp"

#include "constraint/base.hpp"
#include "constraint/omega_test.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "sir/passes/transforms/relayout.hpp"
#include "sir/utils.hpp"

using namespace CSTR;

namespace SIR {
// Get the nested affine fors.
struct NestedForVisitor : ContextVisitor {
    struct Nested {
        FORInst *for_inst;
        LInstIter iter;
        IList *ilist;
    };
    using Entry = std::vector<Nested>;
    using Candidates = std::vector<Entry>;

    Candidates *candidates;

    void visit(Context ctx, FORInst &for_inst) override {
        // Top-level for
        if (ctx.type == PrevType::Func) {
            candidates->emplace_back();
            candidates->back().emplace_back(Nested{&for_inst, ctx.iter, ctx.iList()});
        }

        FORInst *single_for = nullptr;
        LInstIter single_for_it;
        for (auto it = for_inst.body_begin(); it != for_inst.body_end(); ++it) {
            if (auto inner_for = (*it)->as_raw<FORInst>()) {
                if (single_for != nullptr)
                    return;

                single_for = inner_for;
                single_for_it = it;
            } else if ((*it)->is<WHILEInst>())
                return;
        }

        if (!single_for)
            return;

        candidates->back().emplace_back(Nested{single_for, single_for_it, ctx.iList()});

        ContextVisitor::visit(ctx, for_inst);
    }

    NestedForVisitor(Candidates *candidates_) : candidates(candidates_) {}

    static std::string dumpEntry(const Entry &entry) {
        if (entry.empty())
            return "";
        auto ret = entry.begin()->for_inst->getIndVar()->getName();
        for (auto it = entry.begin() + 1; it != entry.end(); ++it)
            ret += ", " + it->for_inst->getIndVar()->getName();
        return ret;
    }
};

struct TileCandidate {
    FORInst *for_inner;
    FORInst *for_outer;
    int tile_step;
    IList *outer_ilist;
    IList *inner_ilist;
    LInstIter outer_iter;
    LInstIter inner_iter;
};

// Optimizing Compilers for Modern Architectures, 9.3.3 Profitability of Blocking:
// In general, tiling is profitable if there is reuse between iterations of a loop that is not
// the innermost loop. Reuse in an outer loop occurs under two circumstances:
//   1. There is a small-threshold dependence of any type, including input, carried by the loop.
//   2. The loop index appears, with small stride, in the contiguous dimension of a multidimensional
//      array and in no other dimension.
//      A classical example of this is GEMM:  (row-major below)
//        for (i = 0; i < N; ++i)
//          for (k = 0; k < K; ++k)
//            for (j = 0; j < M; ++j)
//              C[i][j] += A[i][k] * B[k][j];
//      After tiling,
//        for (ii = 0; ii < N; ii += Ti)
//          for (kk = 0; kk < K; kk += Tk)
//            for (jj = 0; jj < M; jj += Tj)
//              for (i = ii; i < min(ii+Ti, N); ++i)
//                for (k = kk; k < min(kk+Tk, K); ++k)
//                  for (j = jj; j < min(jj+Tj, M); ++j)
//                    C[i][j] += A[i][k] * B[k][j];
bool hasDataReuse(AffineAAResult *affine_aa, FORInst* for_inst) {
    const auto &rw = affine_aa->queryInstRW(for_inst);
    if (!rw)
        return false;

    IndVar *candidate_iv = for_inst->getIndVar().get();

    // Part 1: Small-threshold dependence
    constexpr int threshold = 4;
    auto check_dep = [&](const std::set<Value *> &set1, const std::set<Value *> &set2) -> bool {
        for (const auto &v1 : set1) {
            const auto &p1 = affine_aa->queryPointer(v1);
            if (!p1 || p1->isScalar())
                continue;
            auto acc1 = p1->array();

            for (const auto &v2 : set2) {
                const auto &p2 = affine_aa->queryPointer(v2);
                if (!p2 || p2->isScalar())
                    continue;
                auto acc2 = p2->array();

                if (acc1.base != acc2.base || acc1.indices.size() != acc2.indices.size())
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
                    // We're interested if there is any dependency carried by this loop,
                    // so all other induction variables should be the same.
                    if (iv != candidate_iv)
                        continue;
                    auto e1 = Expr::newVar(iv1_map.at(iv));
                    auto e2 = Expr::newVar(iv2_map.at(iv));
                    solver.addConstraint(Constraint::newEqual(e1, e2));
                }

                size_t dims = acc1.indices.size();
                for (size_t d = 0; d < dims; ++d) {
                    auto e1 = buildConstraintExpr(acc1.indices[d], iv1_map, solver.VH, invariant_map);
                    auto e2 = buildConstraintExpr(acc2.indices[d], iv2_map, solver.VH, invariant_map);
                    solver.addConstraint(Constraint::newEqual(e1, e2));
                }

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

                if (!iv_in_expr.count(candidate_iv))
                    continue;

                auto cand1 = Expr::newVar(iv1_map.at(candidate_iv));
                auto cand2 = Expr::newVar(iv2_map.at(candidate_iv));

                // iv2 < iv1 < iv2 + threshold
                {
                    auto s = solver;
                    s.addConstraint(Constraint::newGreaterThan(cand1, cand2));
                    s.addConstraint(Constraint::newLessThan(cand1, cand2 + Expr::newConst(threshold)));

                    if (s.mayHasIntSolutions())
                        return true;
                }

                // or, iv2 - threshold < iv1 < iv2
                {
                    auto s = solver;
                    s.addConstraint(Constraint::newGreaterThan(cand1, cand2 - Expr::newConst(threshold)));
                    s.addConstraint(Constraint::newLessThan(cand1, cand2));

                    if (s.mayHasIntSolutions())
                        return true;
                }
            }
        }
        return false;
    };

    if (check_dep(rw->read, rw->read) || check_dep(rw->read, rw->write) || check_dep(rw->write, rw->write)) {
        Logger::logDebug("[Tiling]: Data reuse found in small threshold carried dependency. (",
            candidate_iv->getName(), ")");
        return true;
    }

    // Part 2: Loop index in contiguous dimension with small stride
    auto check_contig = [&](const std::set<Value *> &accesses) -> bool {
        for (auto v : accesses) {
            auto p = affine_aa->queryPointer(v);
            if (!p || p->isScalar())
                continue;
            auto acc = p->array();
            if (acc.indices.empty())
                continue;

            // Since we're row-major, the contiguous dimension is the last one.
            size_t last_dim = acc.indices.size() - 1;
            auto it = acc.indices[last_dim].coeffs.find(candidate_iv);
            if (it != acc.indices[last_dim].coeffs.end()) {
                // small stride
                if (it->second == 1 || it->second == -1)
                    return true;
            }
            return false;
        }
        return false;
    };

    if (check_contig(rw->read) || check_contig(rw->write)) {
        Logger::logDebug("[Tiling]: Data reuse found in contiguous dimension with small stride. (",
            candidate_iv->getName(), ")");
        return true;
    }

    return false;
}

int computeTileStep(AffineAAResult *affine_aa, FORInst *for_outer, FORInst *for_inner) {
    // 1) If inner bound is constant, pick a power-of-two <= min(64, max(1, bound/4)).
    // 2) Otherwise return a modest default (8).
    if (auto bound_ci = for_inner->getIndVar()->getBound()->as<ConstantInt>()) {
        int N = std::max(1, bound_ci->getVal());
        int caps[] = {64, 32, 16, 8, 4, 2, 1};
        int target = std::max(1, N / 4);
        for (int c : caps) {
            if (c <= target)
                return c;
        }
        // if none fits target (very small loops), pick smallest >=1 but <=N
        for (int c : caps) {
            if (c <= N)
                return c;
        }
        return 1;
    }

    // If we don't know the bound, pick a conservative default.
    return 4;
}

PM::PreservedAnalyses LoopTilingPass::run(LinearFunction &function, LFAM &lfam) {
    auto &affine_aa = lfam.getResult<AffineAliasAnalysis>(function);

    NestedForVisitor::Candidates nested;
    NestedForVisitor visitor(&nested);
    function.accept(visitor);

    std::vector<TileCandidate> candidates;
    for (auto &entry : nested) {
        if (entry.size() < 2)
            continue;

        Logger::logDebug("[Tiling]: Processing '", NestedForVisitor::dumpEntry(entry), "'.");

        // iterate from innermost (end) to outermost (begin)
        for (int i = static_cast<int>(entry.size()) - 1; i >= 1; --i) {
            auto [for_inner, inner_iter, inner_ilist] = entry[i];

            if (!hasDataReuse(&affine_aa, for_inner))
                continue;

            // consider any outer loop j < i as potential tiling candidate
            for (int j = 0; j < i; ++j) {
                auto [for_outer, outer_iter, outer_ilist] = entry[j];
                if (canInterchange(&affine_aa, for_outer, for_inner)) {
                    auto tile_step = computeTileStep(&affine_aa, for_outer, for_inner);
                    candidates.emplace_back(TileCandidate{for_inner, for_outer, tile_step, outer_ilist, inner_ilist, outer_iter, inner_iter});
                    break;
                }
            }
        }
    }

    if (nested.empty())
        return PreserveAll();

    // strip mine and interchange
    for (const auto &[for_inner, for_outer, tile_step, outer_ilist, inner_ilist, outer_iter, inner_iter] : candidates) {
        auto iv_inner = for_inner->getIndVar();
        auto tile_iv = std::make_shared<IndVar>(iv_inner->getName() + ".tile", nullptr, iv_inner->getBase(),
                                                iv_inner->getBound(), function.getConst(tile_step), 0);
        auto tile_for = std::make_shared<FORInst>(tile_iv, IList{});
        auto *tile_body = &tile_for->getBodyInsts();

        // new base = tile_iv
        iv_inner->setBase(tile_iv);

        // new bound = min(tile_iv + tile_step, bound)
        auto add =
            std::make_shared<BinaryInst>(tile_iv->getName() + ".add", OP::ADD, tile_iv, function.getConst(tile_step));
        auto icmp = std::make_shared<ICMPInst>(tile_iv->getName() + ".min.cmp", ICMPOP::sgt, add, tile_iv->getBound());
        auto sel = std::make_shared<SELECTInst>(tile_iv->getName() + ".min.sel", icmp, tile_iv, add);
        tile_body->insert(tile_body->end(), add);
        tile_body->insert(tile_body->end(), icmp);
        tile_body->insert(tile_body->end(), sel);
        iv_inner->setBound(sel);

        outer_ilist->insert(outer_iter, tile_for);
        tile_for->getBodyInsts().splice(tile_for->body_end(), *outer_ilist, outer_iter);

        tile_for->appendDbgData("tile-for");
        for_inner->appendDbgData("tiled-inner");
        for_outer->appendDbgData("tiled-outer");

        Logger::logDebug("[Tiling]: Strip mine and interchanged. (outer: ", for_outer->getIndVar()->getName(),
                         ", inner: ", iv_inner->getName(), ")");
    }

    updateForIVDepth(function);

    return PreserveNone();
}
} // namespace SIR