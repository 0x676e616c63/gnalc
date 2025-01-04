/**
 * @brief 由于采取的IR生成策略是先生成指令流，再划分基本块，故定义一些LLVM IR中没有的指令用于辅助标记
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_HELPER_HPP
#define GNALC_IR_INSTRUCTIONS_HELPER_HPP

#include <utility>

#include "../instruction.hpp"

namespace IR {
enum class HELPERTY {
    IF,
    WHILE,
    BREAK,
    CONTINUE
};

static inline bool is_cond_type(const std::shared_ptr<Value>& v) {
    auto type = toBType(v->getType());
    if (v->getType()->getTrait() == IRCTYPE::BASIC)
        return toBType(v->getType())->getInner() == IRBTYPE::I1;
    return false;
}

class HELPERInst : public Instruction {
private:
    HELPERTY hlp_type;
public:
    HELPERInst(HELPERTY _hlp_ty)
    : Instruction(OP::HELPER, "__HELPER", makeBType(IRBTYPE::UNDEFINED)), hlp_type(_hlp_ty) {}
    HELPERTY getHlpType() { return hlp_type; }
    virtual void accept(IRVisitor& visitor) override = 0;
};

enum class CONDTY {
    AND, OR
};

class CONDValue : public Value {
private:
    CONDTY cond_type;
public:
    explicit CONDValue(CONDTY ty)
    : Value("__COND", makeBType(IRBTYPE::I1), ValueTrait::HELPER), cond_type(ty) {}
};

class ANDValue : public CONDValue {
    std::shared_ptr<Value> lhs;
    std::shared_ptr<Value> rhs;

public:
    explicit ANDValue(std::shared_ptr<Value> lhs_, std::shared_ptr<Value> rhs_)
        : CONDValue(CONDTY::AND), lhs(std::move(lhs_)), rhs(std::move(rhs_)) {
        Err::gassert(is_cond_type(lhs) && is_cond_type(rhs));
        // Warning: don't let its name begin with '%', or it will affect the name changing in irgen.
        setName("  ; " + lhs->getName() + " && " + rhs->getName());
    }

    const std::shared_ptr<Value>& getLHS() const { return lhs; }
    const std::shared_ptr<Value>& getRHS() const { return rhs; }
};

class ORValue : public CONDValue {
    std::shared_ptr<Value> lhs;
    std::shared_ptr<Value> rhs;

public:
    explicit ORValue(std::shared_ptr<Value> lhs_, std::shared_ptr<Value> rhs_)
        : CONDValue(CONDTY::OR), lhs(std::move(lhs_)), rhs(std::move(rhs_)) {
        Err::gassert(is_cond_type(lhs) && is_cond_type(rhs));
        // Warning: don't let its name begin with '%', or it will affect the name changing in irgen.
        setName("  ; " + lhs->getName() + " || " + rhs->getName());
    }

    const std::shared_ptr<Value>& getLHS() const { return lhs; }
    const std::shared_ptr<Value>& getRHS() const { return rhs; }
};

// IF Block Entry
class IFInst : public HELPERInst {
    std::shared_ptr<Value> cond;
    std::vector<std::shared_ptr<Instruction>> body_insts;
    std::vector<std::shared_ptr<Instruction>> else_insts;
public:
    explicit IFInst(std::shared_ptr<Value> cond_,
        std::vector<std::shared_ptr<Instruction>> body_insts_,
        std::vector<std::shared_ptr<Instruction>> else_insts_)
        : HELPERInst(HELPERTY::IF),
        cond(std::move(cond_)), body_insts(std::move(body_insts_)), else_insts(std::move(else_insts_))
    {
        Err::gassert(is_cond_type(cond));
    }

    const std::shared_ptr<Value>& getCond() { return cond; }
    const std::vector<std::shared_ptr<Instruction>>& getBodyInsts() { return body_insts; }
    const std::vector<std::shared_ptr<Instruction>>& getElseInsts() { return else_insts; }

    bool hasElse() const { return !else_insts.empty(); }

    void accept(IRVisitor& visitor) override;
};

class WHILEInst : public HELPERInst {
    std::shared_ptr<Value> cond;
    std::vector<std::shared_ptr<Instruction>> cond_insts;
    std::vector<std::shared_ptr<Instruction>> body_insts;
public:
    explicit WHILEInst(std::shared_ptr<Value> cond_,
        std::vector<std::shared_ptr<Instruction>> cond_insts_,
        std::vector<std::shared_ptr<Instruction>> body_insts_)
        : HELPERInst(HELPERTY::WHILE),
        cond(std::move(cond_)), cond_insts(std::move(cond_insts_)), body_insts(std::move(body_insts_))
    {
        Err::gassert(is_cond_type(cond));
    }

    const std::shared_ptr<Value>& getCond() { return cond; }
    const std::vector<std::shared_ptr<Instruction>>& getCondInsts() { return cond_insts; }
    const std::vector<std::shared_ptr<Instruction>>& getBodyInsts() { return body_insts; }

    void accept(IRVisitor& visitor) override;
};

class BREAKInst : public HELPERInst {
public:
    BREAKInst() : HELPERInst(HELPERTY::BREAK) {}
    void accept(IRVisitor& visitor) override;
};

class CONTINUEInst : public HELPERInst {
public:
    CONTINUEInst() : HELPERInst(HELPERTY::CONTINUE) {}
    void accept(IRVisitor& visitor) override;
};

}

#endif