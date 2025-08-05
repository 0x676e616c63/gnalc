// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/early_inline.hpp"
#include "config/config.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/control.hpp"
#include "sir/clone.hpp"
#include "sir/visitor.hpp"

namespace SIR {
struct CallPoint {
    pCall call_inst;
    ContextVisitor::PrevType ilist_type;
    IList *ilist;
    LInstIter call_iter;
};

struct InlineCandidate {
    pLFunc callee;
    std::vector<CallPoint> calls;
};

struct InlineVisitor : ContextVisitor {
    using Candidates = std::vector<InlineCandidate>;
    Candidates *candidates;
    bool analyze_failed = false;

    explicit InlineVisitor(Candidates *candidates_) : candidates(candidates_) {}

    void visit(Context ctx, Instruction &inst) override {
        if (auto call = inst.as<CALLInst>()) {
            if (auto lfunc = call->getFunc()->as<LinearFunction>()) {
                auto it = std::find_if(candidates->begin(), candidates->end(), [&](const InlineCandidate &candidate) {
                    return candidate.callee == lfunc;
                });
                auto cp = CallPoint{
                    .call_inst = call,
                    .ilist_type = ctx.type,
                    .ilist = ctx.iList(),
                    .call_iter = ctx.iter,
                };
                if (it != candidates->end())
                    it->calls.emplace_back(cp);
                else {
                    candidates->emplace_back(InlineCandidate{
                           .callee = lfunc,
                           .calls = {cp},
                       });
                }
            }
        }

        ContextVisitor::visit(ctx, inst);
    }
};

bool canInline(const InlineCandidate& candidate) {
    const auto& [callee, call_points] = candidate;
    if (callee->getInstCount() * call_points.size() > Config::SIR::EARLY_INLINE_INST_THRESHOLD)
        return false;

    for (const auto& [call, type, _ilist, _iter] : call_points) {
        switch (type) {
            case ContextVisitor::PrevType::CondLhs:
            case ContextVisitor::PrevType::CondRhs:
            case ContextVisitor::PrevType::CondRhsInsts:
            case ContextVisitor::PrevType::IfCond:
            case ContextVisitor::PrevType::WhCondInsts:
                return false;
            default:
                break;
        }
    }

    unsigned return_cnt = 0;
    for (auto inst : callee->nested_insts()) {
        if (inst->is<RETInst>()) {
            return_cnt++;
            if (return_cnt > 1)
                return false;
        } else if (auto call = inst->as_raw<CALLInst>()) {
            if (call->getFunc() == callee)
                return false;
        }
    }

    if (return_cnt != 1 || !callee->getInsts().back()->is<RETInst>())
        return false;

    return true;
}

PM::PreservedAnalyses EarlyInlinePass::run(LinearFunction &function, LFAM &lfam) {
    InlineVisitor::Candidates candidates;
    InlineVisitor inline_visitor(&candidates);
    function.accept(inline_visitor);

    for (auto it = candidates.begin(); it != candidates.end(); ) {
        if (!canInline(*it))
            it = candidates.erase(it);
        else
            ++it;
    }

    if (candidates.empty())
        return PreserveAll();

    auto& top_ilist = function.getInsts();
    auto alloc_insert_point = top_ilist.begin();
    while (alloc_insert_point != top_ilist.end() && (*alloc_insert_point)->is<ALLOCAInst>())
        ++alloc_insert_point;

    for (const auto &[callee, call_points] : candidates) {
        for (const auto &[call, _ty, call_ilist, call_iter] : call_points) {
            // Set up cloned instructions
            CloneVisitor clone_visitor;
            callee->accept(clone_visitor);
            auto cloned = clone_visitor.curr_val->as<LinearFunction>();
            auto& callee_ilist = cloned->getInsts();
            // Move alloca
            auto alloc_end = callee_ilist.begin();
            while (alloc_end != callee_ilist.end() && (*alloc_end)->is<ALLOCAInst>())
                ++alloc_end;
            top_ilist.splice(alloc_insert_point, callee_ilist, callee_ilist.begin(), alloc_end);

            // Remove return
            auto ret_inst = callee_ilist.back()->as<RETInst>();
            Err::gassert(ret_inst != nullptr, "Bad InlineVisitor");
            if (!ret_inst->isVoid())
                call->replaceSelf(ret_inst->getRetVal());
            callee_ilist.pop_back();

            // Set up arguments
            auto actual_args = call->getArgs();
            for (const auto& fp : cloned->getParams())
                fp->replaceSelf(actual_args[fp->getIndex()]);

            // Move instructions
            // std::next(call_iter) rather than call_iter is needed because
            // call_iter may be the same as alloc_insert_point
            call_ilist->splice(std::next(call_iter), callee_ilist);
            if (call_iter == alloc_insert_point)
                alloc_insert_point = std::next(call_iter);
            call_ilist->erase(call_iter);

            Logger::logDebug("[EarlyInline]: Inlined '", callee->getName(), "' into '",
                function.getName(), "' (inst count: ", callee->getInstCount(), ")");
        }
    }

    return PreserveNone();
}
} // namespace SIR