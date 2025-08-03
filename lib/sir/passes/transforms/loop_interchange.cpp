// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/loop_interchange.hpp"

#include "config/config.hpp"
#include "ir/block_utils.hpp"
#include "sir/base.hpp"
#include "sir/passes/analysis/affine_alias_analysis.hpp"
#include "sir/visitor.hpp"

namespace SIR {
bool isLexLegal(int outer, int inner) {
    bool orig = (outer > 0) || (outer == 0 && inner >= 0);
    bool perm = (inner > 0) || (inner == 0 && outer >= 0);
    return orig && perm;
}

// a[inner][outer] to a[outer][inner] is beneficial
// Negative for profitable.
int getInterchangeCost(const ArrayAccess& arr, IndVar *outer_iv, IndVar *inner_iv) {
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

// FIXME: This check is too strict.
bool isArrayAccessOkToInterchange(const ArrayAccess &arr1, const ArrayAccess &arr2, IndVar *outer_iv,
                                  IndVar *inner_iv) {
    if (arr1.base != arr2.base)
        return true;

    if (arr1.indices.size() != arr2.indices.size())
        return false;

    for (size_t d = 0; d < arr1.indices.size(); ++d) {
        auto diff = arr1.indices[d] - arr2.indices[d];
        if (!isLexLegal(diff.coe(outer_iv), diff.coe(inner_iv)))
            return false;
    }
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

            if (!isArrayAccessOkToInterchange(a1->array(), a2->array(), outer_iv.get(), inner_iv.get()))
                return false;
        }

        for (const auto &s3 : rw->write) {
            const auto &a3 = affine_aa->queryPointer(s3);
            if (!a3)
                return false;
            if (!a3->isArray())
                continue;
            if (!isArrayAccessOkToInterchange(a1->array(), a3->array(), outer_iv.get(), inner_iv.get()))
                return false;
        }
    }

    if (cost < -Config::SIR::LOOP_INTERCHANGE_BENEFIT_THRESHOLD)
        return true;

    Logger::logDebug("[Interchange]: Interchange cancelled due to high cost (", cost, ").");
    return false;
}

struct InterchangeVisitor : ContextVisitor {
    using ICCandidates = std::vector<std::pair<FORInst *, FORInst *>>;

    ICCandidates *candidates;
    AffineAAResult *affine_aa;

    void visit(Context ctx, FORInst &for_inst) override {
        // Only interchange perfectly nested loops
        if (for_inst.getBodyInsts().size() == 1) {
            if (auto inner_for = for_inst.getBodyInsts().back()->as_raw<FORInst>()) {
                if (isSafeAndProfitableToInterchange(affine_aa, &for_inst, inner_for)) {
                    candidates->emplace_back(&for_inst, inner_for);
                    // If we've interchanged these loops, return to avoid visiting the inner for.
                    return;
                }
                else
                    Logger::logDebug("[Interchange]: Interchange cancelled.");
            }
        }
        ContextVisitor::visit(ctx, for_inst);
    }

    InterchangeVisitor(AffineAAResult *affine_aa_, ICCandidates *candidates_) : affine_aa(affine_aa_), candidates(candidates_) {}
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
        Logger::logDebug("[Interchange]: interchanged '", outer->indvar->getName(), "' and '",
                         inner->indvar->getName(), "'.");
    }

    return PreserveNone();
}
} // namespace SIR