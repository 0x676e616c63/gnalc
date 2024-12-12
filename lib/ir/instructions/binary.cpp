//
// Created by BEE172 on 24-12-5.
//
#include "../../../include/ir/instructions/binary.hpp"

namespace IR {
    BinaryInst::BinaryInst(NameRef name, OP opcode, Value *lhs, Value *rhs)
        : Instruction(OP::ADD, name, IRTYPE::I32) {
        addOperands(lhs, rhs);
    }

    Value *BinaryInst::GetLHS() const {
        return getOperands().begin()->getValue();
    }

    Value *BinaryInst::GetRHS() const {
        return getOperands().rbegin()->getValue();
    }

    FNEGInst::FNEGInst(NameRef name, Value *val)
        : Instruction(OP::FNEG, name, IRTYPE::FLOAT) {
        addOperands(val);
    }

    Value *FNEGInst::GetVal() const {
        return getOperands().begin()->getValue();
    }
}
