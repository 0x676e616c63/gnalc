//
// Created by BEE172 on 24-12-5.
//
#include "../../../include/ir/instructions/binary.hpp"
#include "../../../include/ir/visitor.hpp"

namespace IR {
    std::shared_ptr<Type> OPtoTY(OP op) {
        switch (op) {
            case OP::ADD:
            case OP::SUB:
            case OP::MUL:
            case OP::DIV:
            case OP::REM:
                return makeBType(IRBTYPE::I32);
            case OP::FADD:
            case OP::FSUB:
            case OP::FMUL:
            case OP::FDIV:
            case OP::FREM:
                return makeBType(IRBTYPE::FLOAT);
            case OP::AND:
            case OP::OR:
                return makeBType(IRBTYPE::I1);
            default:
                return makeBType(IRBTYPE::UNDEFINED);
        }
    }

    // TYPE 由 OP 决定
    BinaryInst::BinaryInst(NameRef name, OP opcode, std::shared_ptr<Value> lhs, std::shared_ptr<Value> rhs)
        : Instruction(opcode, name, OPtoTY(opcode)) {
        addOperand(lhs);
        addOperand(rhs);
    }

    std::shared_ptr<Value> BinaryInst::getLHS() const {
        return (*(getOperands().begin()))->getValue();
    }

    std::shared_ptr<Value> BinaryInst::getRHS() const {
        return (*(getOperands().rbegin()))->getValue();
    }

    FNEGInst::FNEGInst(NameRef name, std::shared_ptr<Value> val)
        : Instruction(OP::FNEG, name, makeBType(IRBTYPE::FLOAT)) {
        addOperand(val);
    }

    std::shared_ptr<Value> FNEGInst::getVal() const {
        return (*(getOperands().begin()))->getValue();
    }


    void BinaryInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void FNEGInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
}
