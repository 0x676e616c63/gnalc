// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_SIR_VISITOR_HPP
#define GNALC_SIR_VISITOR_HPP

#include "base.hpp"

namespace SIR {
struct Visitor {
    virtual ~Visitor() = default;
    virtual void visit(LinearFunction &lfunc) {
        for (const auto &inst : lfunc)
            visit(*inst);
    }
    virtual void visit(IFInst &if_inst) {
        visit(*if_inst.getCond());
        for (const auto &inst : if_inst.getBodyInsts())
            visit(*inst);
        for (const auto &inst : if_inst.getElseInsts())
            visit(*inst);
    }
    virtual void visit(FORInst &for_inst) {
        for (const auto &inst : for_inst.getBodyInsts())
            visit(*inst);
    }
    virtual void visit(WHILEInst &while_inst) {
        for (const auto &inst : while_inst.getCondInsts())
            visit(*inst);

        visit(*while_inst.getCond());

        for (const auto &inst : while_inst.getBodyInsts())
            visit(*inst);
    }
    virtual void visit(CONDValue &cond) {
        visit(*cond.getLHS());
        for (const auto &inst : cond.getRHSInsts())
            visit(*inst);
        visit(*cond.getRHS());
    }

    virtual void visit(Instruction &inst) {
        if (auto if_inst = inst.as_raw<IFInst>())
            visit(*if_inst);
        else if (auto while_inst = inst.as_raw<WHILEInst>())
            visit(*while_inst);
        else if (auto for_inst = inst.as_raw<FORInst>())
            visit(*for_inst);
    }
    virtual void visit(Value &value) {
        if (auto cond_value = value.as_raw<CONDValue>())
            visit(*cond_value);
    }

    template <typename T, typename... Args> static std::unique_ptr<Visitor> make(Args &&...args) {
        return std::make_unique<T>(std::forward<Args>(args)...);
    }
};

struct ContextVisitor {
    virtual ~ContextVisitor() = default;
    enum class PrevType {
        Initial,
        CondLhs,
        CondRhs,
        CondRhsInsts,
        IfCond,
        IfBody,
        IfElse,
        WhCondInsts,
        WhBody,
        ForBody,
        Func,
    };
    struct Context {
        Value *val;
        PrevType type;
        size_t depth;
        LInstIter iter;

        IList *ifBody() const {
            if (type == PrevType::IfBody)
                return &val->as_raw<IFInst>()->body_insts;
            return nullptr;
        }

        IList *ifElse() const {
            if (type == PrevType::IfElse)
                return &val->as_raw<IFInst>()->else_insts;
            return nullptr;
        }

        IList *forBody() const {
            if (type == PrevType::ForBody)
                return &val->as_raw<FORInst>()->body_insts;
            return nullptr;
        }

        IList *whCondInsts() const {
            if (type == PrevType::WhCondInsts)
                return &val->as_raw<WHILEInst>()->cond_insts;
            return nullptr;
        }

        IList *whBody() const {
            if (type == PrevType::WhBody)
                return &val->as_raw<WHILEInst>()->body_insts;
            return nullptr;
        }

        IList *condRhsInsts() const {
            if (type == PrevType::CondRhsInsts)
                return &val->as_raw<CONDValue>()->rhs_insts;
            return nullptr;
        }

        IList *func() const {
            if (type == PrevType::Func)
                return &val->as_raw<LinearFunction>()->insts;
            return nullptr;
        }

        IList *iList() const {
            if (auto if_body = ifBody())
                return if_body;
            if (auto if_else = ifElse())
                return if_else;
            if (auto while_cond_insts = whCondInsts())
                return while_cond_insts;
            if (auto while_body = whBody())
                return while_body;
            if (auto cond_rhs_insts = condRhsInsts())
                return cond_rhs_insts;
            if (auto for_body = forBody())
                return for_body;
            if (auto fn = func())
                return fn;
            return nullptr;
        }

        static Context makeInitial() { return Context{nullptr, PrevType::Initial, 0}; }
        static Context makeCondLhs(CONDValue *cond_inst, size_t depth) {
            return Context{cond_inst, PrevType::CondLhs, depth};
        }
        static Context makeCondRhs(CONDValue *cond_inst, size_t depth) {
            return Context{cond_inst, PrevType::CondRhs, depth};
        }
        static Context makeCondRhsInsts(CONDValue *cond_inst, LInstIter iter_, size_t depth) {
            return Context{cond_inst, PrevType::CondRhsInsts, depth, iter_};
        }
        static Context makeIfCond(IFInst *if_inst, size_t depth) { return Context{if_inst, PrevType::IfCond, depth}; }
        static Context makeIfBody(IFInst *if_inst, LInstIter iter_, size_t depth) {
            return Context{if_inst, PrevType::IfBody, depth, iter_};
        }
        static Context makeIfElse(IFInst *if_inst, LInstIter iter_, size_t depth) {
            return Context{if_inst, PrevType::IfElse, depth, iter_};
        }
        static Context makeWhCond(WHILEInst *while_inst, size_t depth) {
            return Context{while_inst, PrevType::WhCondInsts, depth};
        }
        static Context makeWhCondInsts(WHILEInst *while_inst, LInstIter iter_, size_t depth) {
            return Context{while_inst, PrevType::WhCondInsts, depth, iter_};
        }
        static Context makeWhBody(WHILEInst *while_inst, LInstIter iter_, size_t depth) {
            return Context{while_inst, PrevType::WhBody, depth, iter_};
        }
        static Context makeForBody(FORInst *for_inst, LInstIter iter_, size_t depth) {
            return Context{for_inst, PrevType::ForBody, depth, iter_};
        }
        static Context makeFunc(LinearFunction *lfunc, LInstIter iter_, size_t depth) {
            return Context{lfunc, PrevType::Func, depth, iter_};
        }
    };

    virtual void visit(Context ctx, LinearFunction &lfunc) {
        for (auto it = lfunc.begin(); it != lfunc.end(); ++it)
            visit(Context::makeFunc(&lfunc, it, ctx.depth + 1), **it);
    }
    virtual void visit(Context ctx, IFInst &if_inst) {
        visit(Context::makeIfCond(&if_inst, ctx.depth + 1), *if_inst.getCond());
        for (auto it = if_inst.body_begin(); it != if_inst.body_end(); ++it)
            visit(Context::makeIfBody(&if_inst, it, ctx.depth + 1), **it);
        for (auto it = if_inst.else_begin(); it != if_inst.else_end(); ++it)
            visit(Context::makeIfElse(&if_inst, it, ctx.depth + 1), **it);
    }
    virtual void visit(Context ctx, FORInst &for_inst) {
        for (auto it = for_inst.body_begin(); it != for_inst.body_end(); ++it)
            visit(Context::makeForBody(&for_inst, it, ctx.depth + 1), **it);
    }
    virtual void visit(Context ctx, WHILEInst &while_inst) {
        for (auto it = while_inst.cond_begin(); it != while_inst.cond_end(); ++it)
            visit(Context::makeWhCondInsts(&while_inst, it, ctx.depth + 1), **it);

        visit(Context::makeWhCond(&while_inst, ctx.depth + 1), *while_inst.getCond());

        for (auto it = while_inst.body_begin(); it != while_inst.body_end(); ++it)
            visit(Context::makeWhBody(&while_inst, it, ctx.depth + 1), **it);
    }
    virtual void visit(Context ctx, CONDValue &cond) {
        visit(Context::makeCondLhs(&cond, ctx.depth + 1), *cond.getLHS());
        for (auto it = cond.rhs_insts_begin(); it != cond.rhs_insts_end(); ++it)
            visit(Context::makeCondRhsInsts(&cond, it, ctx.depth + 1), **it);
        visit(Context::makeCondRhs(&cond, ctx.depth + 1), *cond.getRHS());
    }

    template <typename T, typename... Args> static std::unique_ptr<ContextVisitor> make(Args &&...args) {
        return std::make_unique<T>(std::forward<Args>(args)...);
    }

    virtual void visit(Context ctx, Instruction &inst) {
        if (auto if_inst = inst.as_raw<IFInst>())
            visit(ctx, *if_inst);
        else if (auto while_inst = inst.as_raw<WHILEInst>())
            visit(ctx, *while_inst);
        else if (auto for_inst = inst.as_raw<FORInst>())
            visit(ctx, *for_inst);
    }
    virtual void visit(Context ctx, Value &value) {
        if (auto cond_value = value.as_raw<CONDValue>())
            visit(ctx, *cond_value);
    }
};
} // namespace SIR
#endif
