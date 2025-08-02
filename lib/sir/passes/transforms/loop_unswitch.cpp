// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/loop_unswitch.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/match.hpp"
#include "sir/base.hpp"
#include "sir/clone.hpp"
#include "sir/utils.hpp"
#include "sir/visitor.hpp"

namespace SIR {

struct PartitionInfo {
    int base1;
    int bound1;
    int base2;
    int bound2;
    bool is_greater_cond;
};

struct MoveCondInfo {
    pInst inst;
    LInstIter iter;
};

struct UnswitchCandidate {
    pForInst for_inst;
    pIfInst if_inst;
    LInstIter for_iter;
    LInstIter if_iter;
    IList *outer_ilist{};
    std::optional<MoveCondInfo> cond;
    std::optional<PartitionInfo> partition;
};

struct UnswitchVisitor : ContextVisitor {
    using Candidates = std::vector<UnswitchCandidate>;
    Candidates *candidates;
    bool enable_partition = false;

    static bool isCondLoopInvariant(FORInst &for_inst, const pVal &cond) {
        if (!cond->is<ICMPInst, FCMPInst>())
            return false;

        return isLoopInvariant(cond.get(), &for_inst);
    }

    void visit(Context ctx, FORInst &for_inst) override {
        std::vector<std::pair<LInstIter, size_t>> if_insts;
        for (auto it = for_inst.body_begin(); it != for_inst.body_end(); ++it) {
            if (auto if_inst = (*it)->as<IFInst>())
                if_insts.emplace_back(it, if_inst->getBodyInsts().size());
        }

        // If there are multiple unswitchable ifs, unswitch the smallest one first
        std::sort(if_insts.begin(), if_insts.end(), [](const auto &a, const auto &b) { return a.second < b.second; });

        for (const auto &[if_iter, if_size] : if_insts) {
            auto if_inst = (*if_iter)->as<IFInst>();

            // trivial case: invariant condition
            if (isCondLoopInvariant(for_inst, if_inst->getCond())) {
                auto cond_inst = if_inst->getCond()->as<Instruction>();
                auto it = IListFind(for_inst.getBodyInsts(), cond_inst);
                std::optional<MoveCondInfo> cond;
                if (it != for_inst.getBodyInsts().end()) {
                    cond = MoveCondInfo{
                        .inst = cond_inst,
                        .iter = it,
                    };
                }
                candidates->emplace_back(UnswitchCandidate{
                    .for_inst = for_inst.as<FORInst>(),
                    .if_inst = if_inst,
                    .for_iter = ctx.iter,
                    .if_iter = if_iter,
                    .outer_ilist = ctx.iList(),
                    .cond = cond,
                    .partition = std::nullopt,
                });
                break;
            }

            if (!enable_partition)
                continue;

            // For condition involving induction variable, partition the iteration space
            auto iv = for_inst.getIndVar();
            if (!iv->isConstantDomain())
                continue;
            if (int split;
                match(if_inst->getCond(), M::Icmp(M::Is(iv), M::Bind(split)), M::Icmp(M::Bind(split), M::Is(iv)))) {
                auto icmp = if_inst->getCond()->as<ICMPInst>();
                auto cond = icmp->getCond();
                if (icmp->getRHS() == iv)
                    cond = reverseCond(cond);

                if (cond == ICMPOP::eq || cond == ICMPOP::ne) {
                    // Unswitch them will emit three fors, which will increase the code size dramatically
                    Logger::logDebug("[Unswitch]: Skipped unswitch iv eq/ne.");
                    continue;
                }

                int base = iv->getBase()->as<ConstantInt>()->getVal();
                int bound = iv->getBound()->as<ConstantInt>()->getVal();

                int base1, base2, bound1, bound2;
                // slt/sge: [base, split)  [split, bound)
                if (cond == ICMPOP::slt || cond == ICMPOP::sge)
                    std::tie(base1, bound1, base2, bound2) = std::tuple{base, split, split, bound};
                // sle/sgt: [base, split + 1) [split + 1, bound)
                else if (cond == ICMPOP::sle || cond == ICMPOP::sgt)
                    std::tie(base1, bound1, base2, bound2) = std::tuple{base, split + 1, split + 1, bound};
                else
                    Err::unreachable();

                // Don't bother with unreachable partitions
                if (base1 >= bound1 || base2 >= bound2)
                    continue;

                candidates->emplace_back(
                    UnswitchCandidate{.for_inst = for_inst.as<FORInst>(),
                                      .if_inst = if_inst,
                                      .for_iter = ctx.iter,
                                      .if_iter = if_iter,
                                      .outer_ilist = ctx.iList(),
                                      .cond = std::nullopt,
                                      .partition = PartitionInfo{
                                          .base1 = base1,
                                          .bound1 = bound1,
                                          .base2 = base2,
                                          .bound2 = bound2,
                                          .is_greater_cond = cond == ICMPOP::sge || cond == ICMPOP::sgt,
                                      }});
                break;
            }
        }

        ContextVisitor::visit(ctx, for_inst);
    }

    explicit UnswitchVisitor(Candidates *candidates_, bool enable_partition_)
        : candidates(candidates_), enable_partition(enable_partition_) {}
};

PM::PreservedAnalyses LoopUnswitchPass::run(LinearFunction &function, LFAM &lfam) {
    bool unswitched = false;

    while (true) {
        UnswitchVisitor::Candidates candidates;
        UnswitchVisitor visitor(&candidates, enable_partition);
        function.accept(visitor);

        if (candidates.empty())
            break;

        unswitched = true;

        for (const auto &candidate : candidates) {
            const auto &[for_inst, if_inst, for_iter, if_iter, outer_ilist, move_cond, partition] = candidate;

            if (move_cond) {
                outer_ilist->erase(move_cond->iter);
                outer_ilist->insert(for_iter, move_cond->inst);
            }

            CloneVisitor clone_visitor;
            for_inst->accept(clone_visitor);
            auto for_inst2 = clone_visitor.curr_val->as<FORInst>();
            auto if_iter2 = std::next(for_inst2->body_begin(), std::distance(for_inst->body_begin(), if_iter));
            auto if_inst2 = (*if_iter2)->as<IFInst>();
            Err::gassert(if_inst2 != nullptr, "Bad clone");

            auto &body1 = for_inst->getBodyInsts();
            auto &body2 = for_inst2->getBodyInsts();

            body1.splice(if_iter, if_inst->getBodyInsts());
            body2.splice(if_iter2, if_inst2->getElseInsts());

            body1.erase(if_iter);
            body2.erase(if_iter2);

            if (partition) {
                if (!partition->is_greater_cond) {
                    for_inst->setBase(function.getConst(partition->base1));
                    for_inst->setBound(function.getConst(partition->bound1));
                    for_inst2->setBase(function.getConst(partition->base2));
                    for_inst2->setBound(function.getConst(partition->bound2));
                    outer_ilist->insert(std::next(for_iter), for_inst2);
                } else {
                    // For sgt/sge, reverse the bounds
                    for_inst->setBase(function.getConst(partition->base2));
                    for_inst->setBound(function.getConst(partition->bound2));
                    for_inst2->setBase(function.getConst(partition->base1));
                    for_inst2->setBound(function.getConst(partition->bound1));
                    outer_ilist->insert(for_iter, for_inst2);
                }
                auto add_partition_attr = [](const pInst &inst) {
                    auto attrs = inst->attr().getOrAdd<UnswitchAttrs>(UnswitchAttrs{});
                    attrs->set(UnswitchAttr::Partitioned);
                };
                add_partition_attr(for_inst);
                add_partition_attr(for_inst2);
                Logger::logDebug("[Unswitch]: Partitioned for loop '", for_inst->getIndVar()->getName(), "'.");
            } else {
                auto outer_if =
                    std::make_shared<IFInst>(if_inst->getCond(), IList{for_inst->as<FORInst>()}, IList{for_inst2});
                outer_ilist->insert(for_iter, outer_if);
                outer_ilist->erase(for_iter);
                Logger::logDebug("[Unswitch]: Unswitched for loop '", for_inst->getIndVar()->getName(), "'.");
            }
        }
    }

    return unswitched ? PreserveNone() : PreserveAll();
}
} // namespace SIR