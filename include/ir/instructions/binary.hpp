/**
 * @brief binary operation and fneg
 * @brief add, fadd, sub, fsub, mul, fmul, sdiv, fdiv, srem, frem, fneg
 */

#include "../instruction.hpp"

namespace IR {

// type 由op决定
class BinaryInst : public Instruction {
public:
    BinaryInst(OP opcode, Value* lhs, Value* rhs, NameParam name = "");

    Value* GetLHS();
    Value* GetRHS();
};

// OP = FNEG, type = f32
class FNEGInst : public Instruction {
public:
    FNEGInst(Value* val, NameParam name = "");

    Value* GetVal();
};

}