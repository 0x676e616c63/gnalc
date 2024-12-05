/**
 * @brief Conversion Operations
 * @brief fptosi, sitofp
 */


#pragma once
#ifndef IR_INSTRUCTIONS_CONVERSE_HPP
#define IR_INSTRUCTIONS_CONVERSE_HPP

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

    Value* getOVal();
    IRTYPE getOType(); // ORIGINAL TYPE FLOAT
    IRTYPE getTType(); // TARGET TYPE I32
};

// <result> = sitofp <ty> <value> to <ty2>
class SITOFPInst : public Instruction {
private:
    IRTYPE origin_type = IRTYPE::I32;
public:
    SITOFPInst(NameRef name, Value* origin_val);

    Value* getOVal();
    IRTYPE getOType(); // ORIGINAL TYPE I32
    IRTYPE getTType(); // TARGET TYPE FLOAT
};

}

#endif