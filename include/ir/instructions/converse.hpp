/**
 * @brief Conversion Operations
 * @brief fptosi, sitofp
 */


#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_CONVERSE_HPP
#define GNALC_IR_INSTRUCTIONS_CONVERSE_HPP

#include "../instruction.hpp"
#include "../constant.hpp"
#include <memory>

namespace IR {

// %Y = fptosi float 1.0E-247 to i32
// 默认全为float to i32
class FPTOSIInst : public Instruction {
private:
    IRTYPE origin_type = IRTYPE::FLOAT;
public:
    FPTOSIInst(NameRef name, Value* origin_val);

    Value* getOVal() const;
    IRTYPE getOType() const; // ORIGINAL TYPE FLOAT
    IRTYPE getTType() const; // TARGET TYPE I32

    void accept(IRVisitor& visitor) override { visitor.visit(*this); }
};

// <result> = sitofp <ty> <value> to <ty2>
class SITOFPInst : public Instruction {
private:
    IRTYPE origin_type = IRTYPE::I32;
public:
    SITOFPInst(NameRef name, Value* origin_val);

    Value* getOVal() const;
    IRTYPE getOType() const; // ORIGINAL TYPE I32
    IRTYPE getTType() const; // TARGET TYPE FLOAT

    void accept(IRVisitor& visitor) override { visitor.visit(*this); }
};

}

#endif