// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

/**
 * @brief 由于采取的 IR 生成策略是先生成指令流，再划分基本块，故定义一些辅助指令用于基本块划分
 *        这些指令在 IRGenerator 内的 CFGBuilder 执行完之后将被移除，后续优化与此无关
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_HELPER_HPP
#define GNALC_IR_INSTRUCTIONS_HELPER_HPP

#include "../function.hpp"
#include "../instruction.hpp"
#include "../type_alias.hpp"
#include "../../sir/base.hpp"

#include <stack>
#include <string>
#include <utility>
#include <vector>

namespace SIR {
struct Visitor;
struct ContextVisitor;
class While2ForPass;
class LoopInterchangePass;
} // namespace SIR
namespace IR {
enum class HELPERTY { IF, WHILE, BREAK, CONTINUE, FOR };

static inline bool is_cond_type(const pVal &v) {
    auto type = v->getType()->as<BType>();
    if (v->getType()->getTrait() == IRCTYPE::BASIC)
        return v->getType()->as<BType>()->getInner() == IRBTYPE::I1;
    return false;
}

class HELPERInst : public Instruction {
private:
    HELPERTY hlp_type;

public:
    HELPERInst(HELPERTY _hlp_ty)
        : Instruction(OP::HELPER, "__HELPER", makeBType(IRBTYPE::UNDEFINED)), hlp_type(_hlp_ty) {}
    HELPERTY getHlpType() { return hlp_type; }
    void accept(IRVisitor &visitor) override = 0;

    virtual NestedInstIterator nested_insts_begin() { Err::not_implemented(); }
    virtual NestedInstIterator nested_insts_end() { Err::not_implemented(); }
    using NIterT = Util::make_iterator_range<NestedInstIterator, NestedInstIterator>;
    virtual NIterT nested_insts() { Err::not_implemented(); }
    virtual void accept(SIR::Visitor &visitor) { Err::not_implemented(); }
    virtual void accept(SIR::ContextVisitor &visitor) { Err::not_implemented(); }
};

enum class CONDTY { AND, OR };

class CONDValue : public Instruction {
    friend struct SIR::ContextVisitor;

protected:
    CONDTY cond_type;

    // This is not always the LHS/RHS, but hold the initial LHS/RHS's shared_ptr to extend its lifetime
    // The real LHS/RHS is in the operands, and can be replaced by `replaceSelf`
    // FIXME: Refactor this
    pVal lhs_mem_holder;
    pVal rhs_mem_holder;

    // Note that only rhs_insts are store in the current CONDValue,
    // and the lhs_insts are in the outer scope
    // ( namely CONDValue's rhs_insts, outer WHILEInst's cond_insts or function
    // body before IFInst)
    std::list<pInst> rhs_insts;

public:
    explicit CONDValue(CONDTY ty, const pVal &lhs_, const pVal &rhs_, std::list<pInst> rhs_insts_)
        : Instruction(OP::HELPER, "__COND", makeBType(IRBTYPE::I1), ValueTrait::CONDHELPER), cond_type(ty),
          lhs_mem_holder(lhs_), rhs_mem_holder(rhs_), rhs_insts(std::move(rhs_insts_)) {
        Err::gassert(is_cond_type(lhs_) && is_cond_type(rhs_));
        addOperand(lhs_);
        addOperand(rhs_);
    }

    void setLHSMemHolder(const pVal &lhs_) { lhs_mem_holder = lhs_; }
    void setRHSMemHolder(const pVal &rhs_) { rhs_mem_holder = rhs_; }

    LInstIter rhs_insts_begin() { return rhs_insts.begin(); }
    LInstIter rhs_insts_end() { return rhs_insts.end(); }

    pVal getLHS() const { return getOperand(0)->getValue(); }
    pVal getRHS() const { return getOperand(1)->getValue(); }
    const std::list<pInst> &getRHSInsts() const { return rhs_insts; }
    std::list<pInst> &getRHSInsts() { return rhs_insts; }
    CONDTY getCondType() const { return cond_type; }

    void accept(SIR::Visitor &visitor);
    void accept(SIR::ContextVisitor &visitor);

private:
    pVal cloneImpl() const override {
        return std::make_shared<CONDValue>(getCondType(), getLHS(), getRHS(), getRHSInsts());
    }
};

class ANDValue : public CONDValue {
public:
    ANDValue(pVal lhs_, pVal rhs_, std::list<pInst> rhs_insts_)
        : CONDValue(CONDTY::AND, std::move(lhs_), std::move(rhs_), std::move(rhs_insts_)) {}
};

class ORValue : public CONDValue {
public:
    ORValue(pVal lhs_, pVal rhs_, std::list<pInst> rhs_insts_)
        : CONDValue(CONDTY::OR, std::move(lhs_), std::move(rhs_), std::move(rhs_insts_)) {}
};

inline size_t getCondInstCount(const pVal &cond) {
    if (auto cond_v = cond->as<CONDValue>()) {
        return cond_v->getRHSInsts().size() + getCondInstCount(cond_v->getRHS());
    }
    return 0;
}
// IF Block Entry
class IFInst : public HELPERInst {
    friend struct SIR::ContextVisitor;
    std::list<pInst> body_insts;
    std::list<pInst> else_insts;

    // This is not always the cond, but hold the initial cond's shared_ptr to extend its lifetime
    // The real cond is in the operands, and can be replaced by `replaceSelf`
    // FIXME: Refactor this
    pVal cond_mem_holder;

public:
    explicit IFInst(const pVal &cond_, std::list<pInst> body_insts_, std::list<pInst> else_insts_)
        : HELPERInst(HELPERTY::IF), body_insts(std::move(body_insts_)), else_insts(std::move(else_insts_)),
          cond_mem_holder(cond_) {
        Err::gassert(is_cond_type(cond_));
        addOperand(cond_);
    }

    void setMemHolder(const pVal &mem_holder) { cond_mem_holder = mem_holder; }

    pVal getCond() const { return getOperand(0)->getValue(); }
    const std::list<pInst> &getBodyInsts() const { return body_insts; }
    const std::list<pInst> &getElseInsts() const { return else_insts; }

    std::list<pInst> &getBodyInsts() { return body_insts; }
    std::list<pInst> &getElseInsts() { return else_insts; }

    bool hasElse() const { return !else_insts.empty(); }

    LInstIter body_begin() { return LInstIter(body_insts.begin()); }
    LInstIter body_end() { return LInstIter(body_insts.end()); }

    LInstIter else_begin() { return LInstIter(else_insts.begin()); }
    LInstIter else_end() { return LInstIter(else_insts.end()); }

    NestedInstIterator nested_insts_begin() override { return NestedInstIterator(as<HELPERInst>()); }
    NestedInstIterator nested_insts_end() override { return NestedInstIterator(); }

    NIterT nested_insts() override { return Util::make_iterator_range(nested_insts_begin(), nested_insts_end()); }

    size_t getInstCount() const { return body_insts.size() + else_insts.size() + getCondInstCount(getCond()); }
    void accept(IRVisitor &visitor) override;
    void accept(SIR::Visitor &visitor) override;
    void accept(SIR::ContextVisitor &visitor) override;
};

class WHILEInst : public HELPERInst {
    friend struct SIR::ContextVisitor;

    std::list<pInst> cond_insts;
    std::list<pInst> body_insts;

    // This is not always the cond, but hold the initial cond's shared_ptr to extend its lifetime
    // The real cond is in the operands, and can be replaced by `replaceSelf`
    // FIXME: Refactor this
    pVal cond_mem_holder;

public:
    explicit WHILEInst(const pVal &cond_, std::list<pInst> cond_insts_, std::list<pInst> body_insts_)
        : HELPERInst(HELPERTY::WHILE), cond_insts(std::move(cond_insts_)), body_insts(std::move(body_insts_)),
          cond_mem_holder(cond_) {
        Err::gassert(is_cond_type(cond_));
        addOperand(cond_);
    }

    void setMemHolder(const pVal &mem_holder) { cond_mem_holder = mem_holder; }

    pVal getCond() const { return getOperand(0)->getValue(); }
    const std::list<pInst> &getCondInsts() const { return cond_insts; }
    const std::list<pInst> &getBodyInsts() const { return body_insts; }

    std::list<pInst> &getCondInsts() { return cond_insts; }
    std::list<pInst> &getBodyInsts() { return body_insts; }

    LInstIter cond_begin() { return LInstIter(cond_insts.begin()); }
    LInstIter cond_end() { return LInstIter(cond_insts.end()); }

    LInstIter body_begin() { return LInstIter(body_insts.begin()); }
    LInstIter body_end() { return LInstIter(body_insts.end()); }

    NestedInstIterator nested_insts_begin() override { return NestedInstIterator(as<HELPERInst>()); }
    NestedInstIterator nested_insts_end() override { return NestedInstIterator(); }
    NIterT nested_insts() override { return Util::make_iterator_range(nested_insts_begin(), nested_insts_end()); }

    size_t getInstCount() const { return body_insts.size() + getCondInstCount(getCond()); }

    void accept(IRVisitor &visitor) override;
    void accept(SIR::Visitor &visitor) override;
    void accept(SIR::ContextVisitor &visitor) override;
};

class BREAKInst : public HELPERInst {
    wpVal loop;

public:
    BREAKInst() : HELPERInst(HELPERTY::BREAK) {}
    void accept(IRVisitor &visitor) override;
    pVal getLoop() const { return loop.lock(); }
    void setLoop(const pVal &loop_) { loop = loop_; }
};

class CONTINUEInst : public HELPERInst {
    wpVal loop;

public:
    CONTINUEInst() : HELPERInst(HELPERTY::CONTINUE) {}
    void accept(IRVisitor &visitor) override;
    pVal getLoop() const { return loop.lock(); }
    void setLoop(const pVal &loop_) { loop = loop_; }
};

class IndVar : public Instruction {
private:
    // Base, Bound and Step are in operands list.
    // This can let IndVar can be replaced by `replaceSelf`.
    // Original Memory is not, because it is only used to ensure correctness in CFGBuilder.
    pVal orig_mem;
    size_t depth;

public:
    explicit IndVar(std::string name_, pVal orig_alloca_, const pVal &base, const pVal &bound, const pVal &step,
                    size_t depth_)
        : Instruction(OP::INDVAR, std::move(name_), base->getType(), ValueTrait::INDUCTION_VARIABLE),
          orig_mem(std::move(orig_alloca_)), depth(depth_) {
        Err::gassert(isSameType(base, bound));
        Err::gassert(isSameType(base, step));
        addOperand(base);
        addOperand(bound);
        addOperand(step);
    }

    size_t getDepth() const { return depth; }
    const pVal &getOrigMem() const { return orig_mem; }
    pVal getBase() const { return getOperand(0)->getValue(); }
    pVal getBound() const { return getOperand(1)->getValue(); }
    pVal getStep() const { return getOperand(2)->getValue(); }

    void setBase(const pVal & new_base) { setOperand(0, new_base); }
    void setBound(const pVal & new_bound) { setOperand(1, new_bound); }
    void setStep(const pVal & new_step) { setOperand(2, new_step); }

    bool isConstantDomain() const {
        return getBase()->getVTrait() == ValueTrait::CONSTANT_LITERAL
        && getBound()->getVTrait() == ValueTrait::CONSTANT_LITERAL
        && getStep()->getVTrait() == ValueTrait::CONSTANT_LITERAL;
    }
};

class FORInst : public HELPERInst {
    friend struct SIR::ContextVisitor;
    friend class SIR::LoopInterchangePass;

    pIndVar indvar;
    std::list<pInst> body_insts;

public:
    FORInst(pIndVar indvar_, std::list<pInst> body_insts_)
        : HELPERInst(HELPERTY::FOR), indvar(std::move(indvar_)), body_insts(std::move(body_insts_)) {}

    const pIndVar &getIndVar() { return indvar; }
    pVal getBase() const { return indvar->getBase(); }
    pVal getBound() const { return indvar->getBound(); }
    pVal getStep() const { return indvar->getStep(); }
    void setBase(const pVal & new_base) { indvar->setBase(new_base); }
    void setBound(const pVal & new_bound) { indvar->setBound(new_bound); }
    void setStep(const pVal & new_step) { indvar->setStep(new_step); }
    const std::list<pInst> &getBodyInsts() const { return body_insts; }
    std::list<pInst> &getBodyInsts() { return body_insts; }

    LInstIter body_begin() { return LInstIter(body_insts.begin()); }
    LInstIter body_end() { return LInstIter(body_insts.end()); }

    NestedInstIterator nested_insts_begin() override { return NestedInstIterator(as<HELPERInst>()); }
    NestedInstIterator nested_insts_end() override { return NestedInstIterator(); }
    NIterT nested_insts() override { return Util::make_iterator_range(nested_insts_begin(), nested_insts_end()); }

    size_t getInstCount() const { return body_insts.size(); }

    void accept(IRVisitor &visitor) override;
    void accept(SIR::Visitor &visitor) override;
    void accept(SIR::ContextVisitor &visitor) override;
};
} // namespace IR

#endif