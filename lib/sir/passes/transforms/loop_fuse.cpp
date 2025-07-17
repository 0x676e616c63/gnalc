// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/loop_fuse.hpp"
#include "ir/instructions/control.hpp"
#include "sir/base.hpp"
#include "sir/passes/analysis/alias_analysis.hpp"
#include "sir/visitor.hpp"

namespace SIR {
struct FuseCandidate {
    IList *ilist;
    FORInst *for1;
    FORInst *for2;
};
struct FuseVisitor : ContextVisitor {
    using FuseCandidates = std::vector<FuseCandidate>;
    FuseCandidates *candidates{};
    LAAResult *laa_res;
    size_t fuse_depth;
    bool depth_hit = false;

    explicit FuseVisitor(FuseCandidates *cadidates_, LAAResult *laa_res_, size_t fuse_depth_)
        : candidates(cadidates_), laa_res(laa_res_), fuse_depth(fuse_depth_) {}

    void visit(Context ctx, FORInst &for_inst) override {
        if (ctx.depth == fuse_depth) {
            depth_hit = true;

            IList *ilist = ctx.iList();
            auto it = ctx.iter;
            Err::gassert(it != LInstIter{}, "bad iter");
            ++it; // eat current one
            for (; it != ilist->end(); ++it) {
                if (auto for_inst2 = (*it)->as_raw<FORInst>()) {
                    // Now we've found two consecutive FORInst
                    candidates->emplace_back(FuseCandidate{
                        .ilist = ilist,
                        .for1 = &for_inst,
                        .for2 = for_inst2,
                    });
                    break;
                }
                if (!laa_res->isIndependent(&for_inst, it->get()))
                    break;
            }
        }

        // Pre-order to fuse outer loops first
        ContextVisitor::visit(ctx, for_inst);
    }
};

PM::PreservedAnalyses LoopFusePass::run(LinearFunction &function, LFAM &lfam) {
    bool loop_fuse_modified = false;

    auto &laa_res = lfam.getResult<LAliasAnalysis>(function);

    size_t searching_depth = 0;
    while (true) {
        FuseVisitor::FuseCandidates fuse_candidates;
        FuseVisitor visitor{&fuse_candidates, &laa_res, ++searching_depth};
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
            for1->getIndvar()->replaceSelf(for2->getIndvar());
            for2->getBodyInsts().insert(for2->getBodyInsts().begin(), for1->getBodyInsts().begin(),
                                        for1->getBodyInsts().end());

            // Append debug data before we delete it.
            for2->appendDbgData(for1->getDbgData());
            for2->appendDbgData("fused=" + for1->getIndvar()->getName());

            IListDel(*ilist, for1);
            Logger::logDebug("[LoopFuse]: Fused two loops");
            loop_fuse_modified = true;
        }
    }

    return loop_fuse_modified ? PreserveNone() : PreserveAll();
}
} // namespace SIR