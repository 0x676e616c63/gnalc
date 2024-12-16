//
// Created by BEE172 on 24-12-5.
//
#include "../../../include/ir/instructions/binary.hpp"
#include "../../../include/ir/visitor.hpp"

namespace IR {
    IRTYPE OPtoTY(OP op) {
        switch (op) {
            case OP::ADD:
            case OP::SUB:
            case OP::MUL:
            case OP::DIV:
            case OP::REM:
                return IRTYPE::I32;
            case OP::FADD:
            case OP::FSUB:
            case OP::FMUL:
            case OP::FDIV:
            case OP::FREM:
                return IRTYPE::FLOAT;
            case OP::AND:
            case OP::OR:
                return IRTYPE::I1;
            default:
                return IRTYPE::UNDEFINED;
        }
    }

    // TYPE 由 OP 决定
    BinaryInst::BinaryInst(NameRef name, OP opcode, Value *lhs, Value *rhs)
        : Instruction(opcode, name, OPtoTY(opcode)) {
        operands = {Use{lhs, this}, Use{rhs, this}};
    }

    Value *BinaryInst::getLHS() const {
        return operands.begin()->getValue();
    }

    Value *BinaryInst::getRHS() const {
        return operands.rbegin()->getValue();
    }

    FNEGInst::FNEGInst(NameRef name, Value *val)
        : Instruction(OP::FNEG, name, IRTYPE::FLOAT) {
        operands = {Use{val, this}};
    }

    Value *FNEGInst::getVal() const {
        return operands.begin()->getValue();
    }


    void BinaryInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void FNEGInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
}
