// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

/**
 * @brief 由于采取的 IR 生成策略是先生成指令流，再划分基本块，故定义一些辅助指令用于基本块划分
 *        这些指令在 IRGenerator 内的 CFGBuilder 执行完之后将被移除，后续优化与此无关
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_HELPER_HPP
#define GNALC_IR_INSTRUCTIONS_HELPER_HPP

#include "ir/function.hpp"
#include "ir/instruction.hpp"
#include "ir/type_alias.hpp"

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

class CONDValue : public Value {
    friend struct SIR::ContextVisitor;

protected:
    CONDTY cond_type;
    pVal lhs;
    pVal rhs;

    // Note that only rhs_insts are store in the current CONDValue,
    // and the lhs_insts are in the outer scope
    // ( namely CONDValue's rhs_insts, outer WHILEInst's cond_insts or function
    // body before IFInst)
    std::list<pInst> rhs_insts;

public:
    explicit CONDValue(CONDTY ty, pVal lhs_, pVal rhs_, std::list<pInst> rhs_insts_)
        : Value("__COND", makeBType(IRBTYPE::I1), ValueTrait::CONDHELPER), cond_type(ty), lhs(std::move(lhs_)),
          rhs(std::move(rhs_)), rhs_insts(std::move(rhs_insts_)) {
        Err::gassert(is_cond_type(lhs) && is_cond_type(rhs));
    }

    LInstIter rhs_insts_begin() { return rhs_insts.begin(); }
    LInstIter rhs_insts_end() { return rhs_insts.end(); }

    const pVal &getLHS() const { return lhs; }
    const pVal &getRHS() const { return rhs; }
    const std::list<pInst> &getRHSInsts() const { return rhs_insts; }
    std::list<pInst> &getRHSInsts() { return rhs_insts; }
    CONDTY getCondType() const { return cond_type; }

    void accept(SIR::Visitor &visitor);
    void accept(SIR::ContextVisitor &visitor);
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
    pVal cond;
    std::list<pInst> body_insts;
    std::list<pInst> else_insts;

public:
    explicit IFInst(pVal cond_, std::list<pInst> body_insts_, std::list<pInst> else_insts_)
        : HELPERInst(HELPERTY::IF), cond(std::move(cond_)), body_insts(std::move(body_insts_)),
          else_insts(std::move(else_insts_)) {
        Err::gassert(is_cond_type(cond));
    }

    const pVal &getCond() { return cond; }
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

    size_t getInstCount() const { return body_insts.size() + else_insts.size() + getCondInstCount(cond); }
    void accept(IRVisitor &visitor) override;
    void accept(SIR::Visitor &visitor) override;
    void accept(SIR::ContextVisitor &visitor) override;
};

class WHILEInst : public HELPERInst {
    friend struct SIR::ContextVisitor;

    pVal cond;
    std::list<pInst> cond_insts;
    std::list<pInst> body_insts;

public:
    explicit WHILEInst(pVal cond_, std::list<pInst> cond_insts_, std::list<pInst> body_insts_)
        : HELPERInst(HELPERTY::WHILE), cond(std::move(cond_)), cond_insts(std::move(cond_insts_)),
          body_insts(std::move(body_insts_)) {
        Err::gassert(is_cond_type(cond));
    }

    const pVal &getCond() { return cond; }
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

    size_t getInstCount() const { return body_insts.size() + getCondInstCount(cond); }

    void accept(IRVisitor &visitor) override;
    void accept(SIR::Visitor &visitor) override;
    void accept(SIR::ContextVisitor &visitor) override;
};

class BREAKInst : public HELPERInst {
public:
    BREAKInst() : HELPERInst(HELPERTY::BREAK) {}
    void accept(IRVisitor &visitor) override;
};

class CONTINUEInst : public HELPERInst {
public:
    CONTINUEInst() : HELPERInst(HELPERTY::CONTINUE) {}
    void accept(IRVisitor &visitor) override;
};

class IndVar : public Instruction {
private:
    // Base, Bound and Step are in operands list.
    // This can let IndVar can be replaced by `replaceSelf`.
    // Original Alloca is not, because it is only used to ensure correctness in CFGBuilder.
    pVal orig_alloc;

public:
    explicit IndVar(std::string name_, pVal orig_alloca_, const pVal &base, const pVal &bound, const pVal &step)
        : Instruction(OP::INDVAR, std::move(name_), base->getType(), ValueTrait::INDUCTION_VARIABLE),
          orig_alloc(std::move(orig_alloca_)) {
        Err::gassert(isSameType(base, bound));
        Err::gassert(isSameType(base, step));
        addOperand(base);
        addOperand(bound);
        addOperand(step);
    }

    const pVal &getOrigAlloc() const { return orig_alloc; }
    pVal getBase() const { return getOperand(0)->getValue(); }
    pVal getBound() const { return getOperand(1)->getValue(); }
    pVal getStep() const { return getOperand(2)->getValue(); }
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