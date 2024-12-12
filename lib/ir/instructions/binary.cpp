//
// Created by BEE172 on 24-12-5.
//
#include "../../../include/ir/instructions/binary.hpp"
#include "../../../include/ir/visitor.hpp"

namespace IR {
    BinaryInst::BinaryInst(NameRef name, OP opcode, Value *lhs, Value *rhs)
        : Instruction(OP::ADD, name, IRTYPE::I32) {
        operands = {Use{lhs, this}, Use{rhs, this}};
    }

    Value *BinaryInst::GetLHS() const {
        return operands.begin()->getValue();
    }

    Value *BinaryInst::GetRHS() const {
        return operands.rbegin()->getValue();
    }

    FNEGInst::FNEGInst(NameRef name, Value *val)
        : Instruction(OP::FNEG, name, IRTYPE::FLOAT) {
        operands = {Use{val, this}};
    }

    Value *FNEGInst::GetVal() const {
        return operands.begin()->getValue();
    }


    void BinaryInst::accept(IRVisitor& visitor) override { visitor.visit(*this); }

    void FNEGInst::accept(IRVisitor& visitor) override { visitor.visit(*this); }
}
