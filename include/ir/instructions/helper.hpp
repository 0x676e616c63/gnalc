/**
 * @brief 由于采取的 IR 生成策略是先生成指令流，再划分基本块，故定义一些辅助指令用于基本块划分
 *        这些指令在 IRGenerator 内的 CFGBuilder 执行完之后将被移除，后续优化与此无关
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_HELPER_HPP
#define GNALC_IR_INSTRUCTIONS_HELPER_HPP

#include "ir/instruction.hpp"
#include "ir/type_alias.hpp"

#include <stack>
#include <string>
#include <utility>
#include <vector>

namespace SIR {
struct LookBehindVisitor;
class While2ForPass;
}
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
    virtual void accept(IRVisitor &visitor) override = 0;
};

enum class CONDTY { AND, OR };

class CONDValue : public Value {
    friend struct SIR::LookBehindVisitor;

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

    const pVal &getLHS() const { return lhs; }
    const pVal &getRHS() const { return rhs; }
    const std::list<pInst> &getRHSInsts() const { return rhs_insts; }
    CONDTY getCondType() const { return cond_type; }
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

class NestedInstIterator {
private:
    std::deque<pInst> stack;
    void pushNestedInstructions(const std::vector<const std::list<pInst>*>& lists);
public:
    using iterator_category = std::input_iterator_tag;
    using value_type = pInst;
    using difference_type = std::ptrdiff_t;
    using pointer = pInst*;
    using reference = pInst&;
    explicit NestedInstIterator(const pInst& helper);
    NestedInstIterator() = default;
    pInst operator*() const;
    NestedInstIterator& operator++();
    NestedInstIterator operator++(int);
    bool operator==(const NestedInstIterator& other) const;
    bool operator!=(const NestedInstIterator& other) const;
};

inline size_t getCondInstCount(const pVal& cond) {
    if (auto cond_v = cond->as<CONDValue>()) {
         return cond_v->getRHSInsts().size() + getCondInstCount(cond_v->getRHS());
    }
    return 0;
}
// IF Block Entry
class IFInst : public HELPERInst {
    friend struct SIR::LookBehindVisitor;
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
    const std::list<pInst> &getBodyInsts() { return body_insts; }
    const std::list<pInst> &getElseInsts() { return else_insts; }

    bool hasElse() const { return !else_insts.empty(); }

    NestedInstIterator all_insts_begin() { return NestedInstIterator(as<HELPERInst>()); }
    NestedInstIterator all_insts_end() { return NestedInstIterator(); }
    auto all_insts() { return Util::make_iterator_range(all_insts_begin(), all_insts_end()); }

    size_t getInstCount() const {
        return body_insts.size() + else_insts.size() + getCondInstCount(cond);
    }
    void accept(IRVisitor &visitor) override;
};

class WHILEInst : public HELPERInst {
    friend struct SIR::LookBehindVisitor;

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
    const std::list<pInst> &getCondInsts() { return cond_insts; }
    const std::list<pInst> &getBodyInsts() { return body_insts; }

    NestedInstIterator all_insts_begin() { return NestedInstIterator(as<HELPERInst>()); }
    NestedInstIterator all_insts_end() { return NestedInstIterator(); }
    auto all_insts() { return Util::make_iterator_range(all_insts_begin(), all_insts_end()); }

    size_t getInstCount() const { return body_insts.size() + getCondInstCount(cond); }

    void accept(IRVisitor &visitor) override;
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

class FORInst : public HELPERInst {
    friend struct SIR::LookBehindVisitor;

    int base;
    int bound;
    int step;
    pAlloca indvar;
    std::list<pInst> body_insts;

public:
    explicit FORInst(const pAlloca& indvar_, int base_, int bound_, int step_, std::list<pInst> body_insts_)
        : HELPERInst(HELPERTY::FOR),  indvar(indvar_), base(base_), bound(bound_), step(step_),
          body_insts(std::move(body_insts_)) {}

    const pAlloca &getIndvar() { return indvar; }
    int getBase() const { return base; }
    int getBound() const { return bound; }
    int getStep() const { return step; }
    const std::list<pInst> &getBodyInsts() const { return body_insts; }

    NestedInstIterator all_insts_begin() { return NestedInstIterator(as<HELPERInst>()); }
    NestedInstIterator all_insts_end() { return NestedInstIterator(); }
    auto all_insts() { return Util::make_iterator_range(all_insts_begin(), all_insts_end()); }

    size_t getInstCount() const { return body_insts.size(); }

    void accept(IRVisitor &visitor) override;
};
} // namespace IR

#endif