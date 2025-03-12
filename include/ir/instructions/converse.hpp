/**
 * @brief Conversion Operations
 * @brief fptosi, sitofp
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_CONVERSE_HPP
#define GNALC_IR_INSTRUCTIONS_CONVERSE_HPP

#include "../constant.hpp"
#include "../instruction.hpp"
#include <memory>

namespace IR {

class CastInst : public Instruction {
private:
    std::shared_ptr<Type> dest_type;

public:
    CastInst(OP opcode_, NameRef name, const std::shared_ptr<Value> &origin_val,
             const std::shared_ptr<Type> &dest_type);

    std::shared_ptr<Value> getOVal() const;

    std::shared_ptr<Type> getOType() const;
    std::shared_ptr<Type> getTType() const;

    void accept(IRVisitor &visitor) override;
};

// %Y = fptosi float 1.0E-247 to i32
// 默认全为float to i32
class FPTOSIInst : public CastInst {
public:
    FPTOSIInst(NameRef name, const std::shared_ptr<Value> &origin_val);

    void accept(IRVisitor &visitor) override;

private:
    std::shared_ptr<Value> cloneImpl() const override {
        return std::make_shared<FPTOSIInst>(getName(), getOVal());
    }
};

// <result> = sitofp <ty> <value> to <ty2>
class SITOFPInst : public CastInst {
public:
    SITOFPInst(NameRef name, const std::shared_ptr<Value> &origin_val);

    void accept(IRVisitor &visitor) override;

private:
    std::shared_ptr<Value> cloneImpl() const override {
        return std::make_shared<SITOFPInst>(getName(), getOVal());
    }
};

// <result> = zext <ty> <value> to <ty2>
class ZEXTInst : public CastInst {
public:
    ZEXTInst(NameRef name, const std::shared_ptr<Value> &origin_val,
             IRBTYPE dest_type);

    void accept(IRVisitor &visitor) override;

private:
    std::shared_ptr<Value> cloneImpl() const override {
        return std::make_shared<ZEXTInst>(getName(),
            getOVal(), toBType(getTType())->getInner());
    }
};

// <result> = bitcast <ty> <value> to <ty2>
class BITCASTInst : public CastInst {
public:
    BITCASTInst(NameRef name, const std::shared_ptr<Value> &origin_val,
                const std::shared_ptr<Type> &dest_type);

    void accept(IRVisitor &visitor) override;

private:
    std::shared_ptr<Value> cloneImpl() const override {
        return std::make_shared<BITCASTInst>(getName(), getOVal(), getTType());
    }
};

} // namespace IR

#endif