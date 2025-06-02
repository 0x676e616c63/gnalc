#pragma once
#ifndef GNALC_SIR_VISITOR_HPP
#define GNALC_SIR_VISITOR_HPP

#include "sir/base.hpp"

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

private:
    void visit(Instruction &inst) {
        if (auto if_inst = inst.as_raw<IFInst>())
            visit(*if_inst);
        else if (auto while_inst = inst.as_raw<WHILEInst>())
            visit(*while_inst);
        else if (auto for_inst = inst.as_raw<FORInst>())
            visit(*for_inst);
    }
    void visit(Value &value) {
        if (auto cond_value = value.as_raw<CONDValue>())
            visit(*cond_value);
    }
};

struct LookBehindVisitor {
    virtual ~LookBehindVisitor() = default;
    enum class PrevType {
        Initial,
        CondLhs,
        CondRhs,
        CondRhsInsts,
        IfCond,
        IfBody,
        IfElse,
        WhCond,
        WhBody,
        ForBody,
        Func,
    };
    struct PrevInfo {
        Value *val;
        PrevType type;

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

        IList* func() const {
            if (type == PrevType::Func)
                return &val->as_raw<LinearFunction>()->insts;
            return nullptr;
        }

        IList* iList() const {
            if (auto if_body = ifBody())
                return if_body;
            if (auto if_else = ifElse())
                return if_else;
            if (auto while_body = whBody())
                return while_body;
            if (auto for_body = forBody())
                return for_body;
            if (auto fn = func())
                return fn;
            return nullptr;
        }

        static PrevInfo makeInitial() { return PrevInfo{nullptr, PrevType::Initial}; }
        static PrevInfo makeCondLhs(CONDValue *cond_inst) { return PrevInfo{cond_inst, PrevType::CondLhs}; }
        static PrevInfo makeCondRhs(CONDValue *cond_inst) { return PrevInfo{cond_inst, PrevType::CondRhs}; }
        static PrevInfo makeCondRhsInsts(CONDValue *cond_inst) { return PrevInfo{cond_inst, PrevType::CondRhsInsts}; }
        static PrevInfo makeIfCond(IFInst *if_inst) { return PrevInfo{if_inst, PrevType::IfCond}; }
        static PrevInfo makeIfBody(IFInst *if_inst) { return PrevInfo{if_inst, PrevType::IfBody}; }
        static PrevInfo makeIfElse(IFInst *if_inst) { return PrevInfo{if_inst, PrevType::IfElse}; }
        static PrevInfo makeWhCond(WHILEInst *while_inst) { return PrevInfo{while_inst, PrevType::WhCond}; }
        static PrevInfo makeWhBody(WHILEInst *while_inst) { return PrevInfo{while_inst, PrevType::WhBody}; }
        static PrevInfo makeForBody(FORInst *for_inst) { return PrevInfo{for_inst, PrevType::ForBody}; }
        static PrevInfo makeFunc(LinearFunction *lfunc) { return PrevInfo{lfunc, PrevType::Func}; }
    };

    virtual void visit(PrevInfo prev, LinearFunction &lfunc) {
        for (const auto &inst : lfunc)
            visit(PrevInfo::makeFunc(&lfunc), *inst);
    }
    virtual void visit(PrevInfo prev, IFInst &if_inst) {
        visit(PrevInfo::makeIfCond(&if_inst), *if_inst.getCond());
        for (const auto &inst : if_inst.getBodyInsts())
            visit(PrevInfo::makeIfBody(&if_inst), *inst);
        for (const auto &inst : if_inst.getElseInsts())
            visit(PrevInfo::makeIfElse(&if_inst), *inst);
    }
    virtual void visit(PrevInfo prev, FORInst &for_inst) {
        for (const auto &inst : for_inst.getBodyInsts())
            visit(PrevInfo::makeForBody(&for_inst), *inst);
    }
    virtual void visit(PrevInfo prev, WHILEInst &while_inst) {
        visit(PrevInfo::makeWhCond(&while_inst), *while_inst.getCond());
        for (const auto &inst : while_inst.getBodyInsts())
            visit(PrevInfo::makeWhBody(&while_inst), *inst);
    }
    virtual void visit(PrevInfo prev, CONDValue &cond) {
        visit(PrevInfo::makeCondLhs(&cond), *cond.getLHS());
        for (const auto &inst : cond.getRHSInsts())
            visit(PrevInfo::makeCondRhsInsts(&cond), *inst);
        visit(PrevInfo::makeCondRhsInsts(&cond), *cond.getRHS());
    }

private:
    void visit(PrevInfo prev, Instruction &inst) {
        if (auto if_inst = inst.as_raw<IFInst>())
            visit(prev, *if_inst);
        else if (auto while_inst = inst.as_raw<WHILEInst>())
            visit(prev, *while_inst);
        else if (auto for_inst = inst.as_raw<FORInst>())
            visit(prev, *for_inst);
    }
    void visit(PrevInfo prev, Value &value) {
        if (auto cond_value = value.as_raw<CONDValue>())
            visit(prev, *cond_value);
    }
};
} // namespace SIR
#endif
