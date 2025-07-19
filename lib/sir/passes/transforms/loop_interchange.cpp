// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/loop_interchange.hpp"

#include "ir/block_utils.hpp"
#include "sir/base.hpp"
#include "sir/passes/analysis/alias_analysis.hpp"
#include "sir/visitor.hpp"

namespace SIR {
bool isLexLegal(int outer, int inner) {
    bool orig = (outer > 0) || (outer == 0 && inner >= 0);
    bool perm = (inner > 0) || (inner == 0 && outer >= 0);
    return orig && perm;
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
bool isSafeAndProfitableToInterchange(LAAResult *laa_res, FORInst *outer_for, FORInst *inner_for) {
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
    if (!laa_res->isScalarIndependent(outer_for, inner_for))
        return false;

    const auto &rw = laa_res->queryInstRW(outer_for);
    if (!rw)
        return false;

    // Now check memory dependencies
    for (const auto &s1 : rw->write) {
        const auto &a1 = laa_res->queryPointer(s1);
        if (!a1)
            return false;
        if (!a1->isArray())
            continue;

        for (const auto &s2 : rw->read) {
            const auto &a2 = laa_res->queryPointer(s2);
            if (!a2)
                return false;
            if (!a2->isArray())
                continue;
            if (!isArrayAccessOkToInterchange(a1->array(), a2->array(), outer_iv.get(), inner_iv.get()))
                return false;
        }

        for (const auto &s3 : rw->write) {
            const auto &a3 = laa_res->queryPointer(s3);
            if (!a3)
                return false;
            if (!a3->isArray())
                continue;
            if (!isArrayAccessOkToInterchange(a1->array(), a3->array(), outer_iv.get(), inner_iv.get()))
                return false;
        }
    }

    return true;
}

struct InterchangeVisitor : ContextVisitor {
    using ICCandidates = std::vector<std::pair<FORInst *, FORInst *>>;

    ICCandidates *candidates;
    LAAResult *laa_res;

    void visit(Context ctx, FORInst &for_inst) override {
        // Only interchange perfectly nested loops
        if (for_inst.getBodyInsts().size() == 1) {
            if (auto inner_for = for_inst.getBodyInsts().back()->as_raw<FORInst>()) {
                if (isSafeAndProfitableToInterchange(laa_res, &for_inst, inner_for)) {
                    candidates->emplace_back(&for_inst, inner_for);
                    // If we've interchanged these loops, return to avoid visiting the inner for.
                    return;
                }
            }
        }
        ContextVisitor::visit(ctx, for_inst);
    }

    InterchangeVisitor(LAAResult *laa_res_, ICCandidates *candidates_) : laa_res(laa_res_), candidates(candidates_) {}
};

PM::PreservedAnalyses LoopInterchangePass::run(LinearFunction &function, LFAM &lfam) {
    auto &laa_res = lfam.getResult<LAliasAnalysis>(function);
    InterchangeVisitor::ICCandidates candidates;
    InterchangeVisitor visitor(&laa_res, &candidates);
    function.accept(visitor);

    if (candidates.empty())
        return PreserveAll();

    for (const auto &[outer, inner] : candidates) {
        std::swap(outer->indvar, inner->indvar);
        Logger::logDebug("[LoopInterchange]: interchanged '", outer->indvar->getName(), "' and '",
                         inner->indvar->getName(), "'.");
    }

    return PreserveNone();
}
} // namespace SIR