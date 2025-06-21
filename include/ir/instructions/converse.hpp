/**
 * @brief Conversion Operations
 * @brief fptosi, sitofp, bitcast, zext
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_CONVERSE_HPP
#define GNALC_IR_INSTRUCTIONS_CONVERSE_HPP

#include "ir/instruction.hpp"
#include "ir/type_alias.hpp"

#include <memory>

namespace IR {

class CastInst : public Instruction {
private:
    pType dest_type;

public:
    CastInst(OP opcode_, NameRef name, const pVal &origin_val, const pType &dest_type);

    pVal getOVal() const;

    pType getOType() const;
    pType getTType() const;

    void accept(IRVisitor &visitor) override;
};

// %Y = fptosi float 1.0E-247 to i32
// 默认全为float to i32
class FPTOSIInst : public CastInst {
public:
    FPTOSIInst(NameRef name, const pVal &origin_val);

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override { return std::make_shared<FPTOSIInst>(getName(), getOVal()); }
};

// <result> = sitofp <ty> <value> to <ty2>
class SITOFPInst : public CastInst {
public:
    SITOFPInst(NameRef name, const pVal &origin_val);

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override { return std::make_shared<SITOFPInst>(getName(), getOVal()); }
};

// <result> = zext <ty> <value> to <ty2>
class ZEXTInst : public CastInst {
public:
    ZEXTInst(NameRef name, const pVal &origin_val, IRBTYPE dest_type);

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override {
        return std::make_shared<ZEXTInst>(getName(), getOVal(), getTType()->as<BType>()->getInner());
    }
};

// <result> = sext <ty> <value> to <ty2>
class SEXTInst : public CastInst {
public:
    SEXTInst(NameRef name, const pVal &origin_val, IRBTYPE dest_type);

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override {
        return std::make_shared<SEXTInst>(getName(), getOVal(), getTType()->as<BType>()->getInner());
    }
};

// <result> = bitcast <ty> <value> to <ty2>
class BITCASTInst : public CastInst {
public:
    BITCASTInst(NameRef name, const pVal &origin_val, const pType &dest_type);

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override { return std::make_shared<BITCASTInst>(getName(), getOVal(), getTType()); }
};

} // namespace IR

#endif