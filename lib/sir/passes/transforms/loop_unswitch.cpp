// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/loop_unswitch.hpp"
#include "sir/base.hpp"
#include "sir/utils.hpp"
#include "sir/visitor.hpp"
#include "ir/instructions/compare.hpp"

namespace SIR {

struct UnswitchCandidate {
    FORInst *for_inst{};
    IFInst *if_inst{};
    IList* outer_ilist{};
    LInstIter if_iter;
    LInstIter for_iter;
};

struct UnswitchVisitor : ContextVisitor {
    using Candidates = std::vector<UnswitchCandidate>;
    Candidates* candidates;

    static bool isCondLoopInvariant(FORInst& for_inst, const pVal &cond) {
        // FIXME: Support complex cond
        if (!cond->is<ICMPInst, FCMPInst>())
            return false;

        return isLoopInvariant(cond.get(), &for_inst);
    }

    void visit(Context ctx, FORInst &for_inst) override {
        std::vector<std::pair<LInstIter, size_t>> if_insts;
        for (auto it = for_inst.body_begin(); it != for_inst.body_end(); ++it) {
            if (auto if_inst = (*it)->as<IFInst>()) {
                if (isCondLoopInvariant(for_inst, if_inst->getCond()))
                    if_insts.emplace_back(it, if_inst->getBodyInsts().size());
            }
        }

        // If there are multiple unswitchable ifs, unswitch the biggest one first
        auto it = std::max_element(if_insts.begin(), if_insts.end(), [](const auto &a, const auto &b) {
                return a.second < b.second;
        });

        if (it != if_insts.end()) {
            candidates->emplace_back(UnswitchCandidate{
                .for_inst = &for_inst,
                .if_inst = (*it->first)->as_raw<IFInst>(),
                .outer_ilist = ctx.iList(),
                .if_iter = it->first,
                .for_iter = ctx.iter,
            });
        }

        ContextVisitor::visit(ctx, for_inst);
    }

    explicit UnswitchVisitor(Candidates* candidates_) : candidates(candidates_) {}
};

PM::PreservedAnalyses LoopUnswitchPass::run(LinearFunction &function, LFAM &lfam) {
    UnswitchVisitor::Candidates candidates;
    UnswitchVisitor visitor(&candidates);
    function.accept(visitor);

    if (candidates.empty())
        return PreserveAll();

    for (const auto& [for_inst, if_inst, outer_ilist, if_iter, for_iter] : candidates) {
        // TODO
    }

    return PreserveNone();
}
} // namespace SIR