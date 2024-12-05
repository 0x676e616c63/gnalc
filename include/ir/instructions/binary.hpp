/**
 * @brief binary operation and fneg
 * @brief add, fadd, sub, fsub, mul, fmul, sdiv, fdiv, srem, frem, fneg
 */

#pragma once
#ifndef IR_INSTRUCTIONS_BINARY_HPP
#define IR_INSTRUCTIONS_BINARY_HPP

#include "../instruction.hpp"

namespace IR {

// type 由op决定
// 例如 %3 = add i32 %1, %2
// name = "%3"
// type = i32
// opcode = ADD
// operands = [%1, %2]
class BinaryInst : public Instruction {
public:
    BinaryInst(NameRef name, OP opcode, Value* lhs, Value* rhs);

    Value* GetLHS();
    Value* GetRHS();
};

// OP = FNEG, type = f32
// <result> = fneg [fast-math flags]* <ty> <op1>
class FNEGInst : public Instruction {
public:
    FNEGInst(NameRef name, Value* val);

    Value* GetVal();
};

}

#endif