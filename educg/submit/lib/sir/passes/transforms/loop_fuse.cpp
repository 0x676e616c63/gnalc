// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/sir/passes/transforms/loop_fuse.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/sir/base.hpp"
#include "../../../../include/sir/passes/analysis/affine_alias_analysis.hpp"
#include "../../../../include/sir/utils.hpp"
#include "../../../../include/sir/visitor.hpp"

#include <vector>

namespace SIR {
struct FuseCandidate {
    IList *ilist;
    FORInst *for1;
    FORInst *for2;
};

bool canFuse(AffineAAResult* affine_aa, FORInst* for1, FORInst* for2) {
    auto indvar1 = for1->getIndVar();
    auto indvar2 = for2->getIndVar();

    // Give up if two FORInst have different iteration domain.
    // TODO: Loop Alignment
    if (!isTriviallyIdentical(indvar1->getBase(), indvar2->getBase()) ||
        !isTriviallyIdentical(indvar1->getStep(),  indvar2->getStep()) ||
        !isTriviallyIdentical(indvar1->getBound(), indvar2->getBound()))
        return false;

    // Scalars can't be fused
    if (!affine_aa->isScalarIndependent(for1, for2)) {
        Logger::logDebug("[LoopFuse]: Skipped two loops because unresolved scalar dependency.");
        return false;
    }

    const auto& rw1 = affine_aa->queryInstRW(for1);
    const auto& rw2 = affine_aa->queryInstRW(for2);
    if (!rw1 || !rw2) {
        Logger::logDebug("[LoopFuse]: Skipped two loops because failed to analyze RWInfo.");
        return false;
    }

    auto has_dep = [&](const std::set<Value*>& set1, const std::set<Value*>& set2) {
        for (const auto& s1 : set1) {
            const auto& a1 = affine_aa->queryPointer(s1);
            if (!a1)
                return true;

            if (!a1->isArray())
                continue;
            for (const auto& s2 : set2) {
                const auto& a2 = affine_aa->queryPointer(s2);
                if (!a2)
                    return true;

                if (!a2->isArray())
                    continue;
                if (a1->array().base != a2->array().base)
                    continue;

                // FIXME: More Accurate
                // TODO: dependency distance
                auto idx1 = a1->array().indices;
                auto idx2 = a2->array().indices;
                if (idx1.size() != idx2.size())
                    return true;

                for (size_t i = 0; i < idx1.size(); ++i) {
                    if (!idx1[i].isIsomorphic(idx2[i]))
                        return true;
                }

                return false;
            }
        }
        return false;
    };

    if (has_dep(rw1->write, rw2->read) || has_dep(rw2->write, rw1->read) || has_dep(rw1->write, rw2->write)) {
        Logger::logDebug("[LoopFuse]: Skipped two adjacent loops ('",
            for1->getIndVar()->getName(), "' and '", for2->getIndVar()->getName(),
            "') because unresolved array dependency.");
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

            IListDel(*ilist, for1);
            Logger::logDebug("[LoopFuse]: Fused two loops");

            affine_aa = lfam.getFreshResult<AffineAliasAnalysis>(function);
            loop_fuse_modified = true;

            // Revisit this depth
            --searching_depth;
        }
    }

    return loop_fuse_modified ? PreserveNone() : PreserveAll();
}
} // namespace SIR