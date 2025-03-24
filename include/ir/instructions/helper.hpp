/**
 * @brief 由于采取的IR生成策略是先生成指令流，再划分基本块，故定义一些LLVM
 * IR中没有的指令用于辅助标记
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_HELPER_HPP
#define GNALC_IR_INSTRUCTIONS_HELPER_HPP

#include <utility>

#include "../instruction.hpp"
#include "../type_alias.hpp"

namespace IR {
enum class HELPERTY { IF, WHILE, BREAK, CONTINUE };

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
protected:
    CONDTY cond_type;
    pVal lhs;
    pVal rhs;

    // Note that only rhs_insts are store in the current CONDValue,
    // and the lhs_insts are in the outer scope
    // ( namely CONDValue's rhs_insts, outer WHILEInst's cond_insts or function
    // body before IFInst)
    std::vector<pInst> rhs_insts;

public:
    explicit CONDValue(CONDTY ty, pVal lhs_, pVal rhs_, std::vector<pInst> rhs_insts_)
        : Value("__COND", makeBType(IRBTYPE::I1), ValueTrait::CONDHELPER), cond_type(ty), lhs(std::move(lhs_)),
          rhs(std::move(rhs_)), rhs_insts(std::move(rhs_insts_)) {
        Err::gassert(is_cond_type(lhs) && is_cond_type(rhs));
    }

    const pVal &getLHS() const { return lhs; }
    const pVal &getRHS() const { return rhs; }
    const std::vector<pInst> &getRHSInsts() const { return rhs_insts; }
    CONDTY getCondType() const { return cond_type; }
};

class ANDValue : public CONDValue {
public:
    ANDValue(pVal lhs_, pVal rhs_, std::vector<pInst> rhs_insts_)
        : CONDValue(CONDTY::AND, std::move(lhs_), std::move(rhs_), std::move(rhs_insts_)) {}
};

class ORValue : public CONDValue {
public:
    ORValue(pVal lhs_, pVal rhs_, std::vector<pInst> rhs_insts_)
        : CONDValue(CONDTY::OR, std::move(lhs_), std::move(rhs_), std::move(rhs_insts_)) {}
};

// IF Block Entry
class IFInst : public HELPERInst {
    pVal cond;
    std::vector<pInst> body_insts;
    std::vector<pInst> else_insts;

public:
    explicit IFInst(pVal cond_, std::vector<pInst> body_insts_, std::vector<pInst> else_insts_)
        : HELPERInst(HELPERTY::IF), cond(std::move(cond_)), body_insts(std::move(body_insts_)),
          else_insts(std::move(else_insts_)) {
        Err::gassert(is_cond_type(cond));
    }

    const pVal &getCond() { return cond; }
    const std::vector<pInst> &getBodyInsts() { return body_insts; }
    const std::vector<pInst> &getElseInsts() { return else_insts; }

    bool hasElse() const { return !else_insts.empty(); }

    void accept(IRVisitor &visitor) override;
};

class WHILEInst : public HELPERInst {
    pVal cond;
    std::vector<pInst> cond_insts;
    std::vector<pInst> body_insts;

public:
    explicit WHILEInst(pVal cond_, std::vector<pInst> cond_insts_, std::vector<pInst> body_insts_)
        : HELPERInst(HELPERTY::WHILE), cond(std::move(cond_)), cond_insts(std::move(cond_insts_)),
          body_insts(std::move(body_insts_)) {
        Err::gassert(is_cond_type(cond));
    }

    const pVal &getCond() { return cond; }
    const std::vector<pInst> &getCondInsts() { return cond_insts; }
    const std::vector<pInst> &getBodyInsts() { return body_insts; }

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

} // namespace IR

#endif