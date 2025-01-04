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
    IFBEntry,
    IFBEnd,
    ELSEBEntry,
    ELSEBEnd,
    WHILEBEntry,
    WHILEBEnd,
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

class COND : public Value {
private:
    CONDTY cond_type;
public:
    explicit COND(CONDTY ty)
    : Value("__COND", makeBType(IRBTYPE::I1), ValueTrait::HELPER), cond_type(ty) {}
};

class AND : public COND {
    std::shared_ptr<Value> lhs;
    std::shared_ptr<Value> rhs;

public:
    explicit AND(std::shared_ptr<Value> lhs_, std::shared_ptr<Value> rhs_)
        : COND(CONDTY::AND), lhs(std::move(lhs_)), rhs(std::move(rhs_)) {
        Err::gassert(is_cond_type(lhs) && is_cond_type(rhs));
    }

    const std::shared_ptr<Value>& getLHS() const { return lhs; }
    const std::shared_ptr<Value>& getRHS() const { return rhs; }
};

class OR : public COND {
    std::shared_ptr<Value> lhs;
    std::shared_ptr<Value> rhs;

public:
    explicit OR(std::shared_ptr<Value> lhs_, std::shared_ptr<Value> rhs_)
        : COND(CONDTY::OR), lhs(std::move(lhs_)), rhs(std::move(rhs_)) {
        Err::gassert(is_cond_type(lhs) && is_cond_type(rhs));
    }

    const std::shared_ptr<Value>& getLHS() const { return lhs; }
    const std::shared_ptr<Value>& getRHS() const { return rhs; }
};

// IF Block Entry
class IFBEntry : public HELPERInst {
    std::shared_ptr<Value> cond;
public:
    explicit IFBEntry(std::shared_ptr<Value> cond_)
    : HELPERInst(HELPERTY::IFBEntry), cond(std::move(cond_)) {
        Err::gassert(is_cond_type(cond));
    }

    void accept(IRVisitor& visitor) override;
};

class IFBEnd : public HELPERInst {
public:
    IFBEnd() : HELPERInst(HELPERTY::IFBEnd) {}
    void accept(IRVisitor& visitor) override;
};

class ELSEBEntry : public HELPERInst {
public:
    ELSEBEntry() : HELPERInst(HELPERTY::ELSEBEntry) {}
    void accept(IRVisitor& visitor) override;
};

class ELSEBEnd : public HELPERInst {
public:
    ELSEBEnd() : HELPERInst(HELPERTY::ELSEBEnd) {}
    void accept(IRVisitor& visitor) override;
};

class WHILEBEntry : public HELPERInst {
    std::vector<std::shared_ptr<Value>> conds;
    std::shared_ptr<Value> cond;
public:
    explicit WHILEBEntry(std::shared_ptr<Value> cond_)
    : HELPERInst(HELPERTY::WHILEBEntry), cond(std::move(cond_)) {
        Err::gassert(is_cond_type(cond));
    }
    void accept(IRVisitor& visitor) override;
};

class WHILEBEnd : public HELPERInst {
public:
    WHILEBEnd() : HELPERInst(HELPERTY::WHILEBEnd) {}
    void accept(IRVisitor& visitor) override;
};

class BREAK : public HELPERInst {
public:
    BREAK() : HELPERInst(HELPERTY::BREAK) {}
    void accept(IRVisitor& visitor) override;
};

class CONTINUE : public HELPERInst {
public:
    CONTINUE() : HELPERInst(HELPERTY::CONTINUE) {}
    void accept(IRVisitor& visitor) override;
};

}

#endif