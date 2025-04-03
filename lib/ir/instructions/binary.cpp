#include "ir/instructions/binary.hpp"
#include "ir/visitor.hpp"

namespace IR {
pType OPtoTY(OP op) {
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
BinaryInst::BinaryInst(NameRef name, OP opcode, const pVal &lhs, const pVal &rhs)
    : Instruction(opcode, name, OPtoTY(opcode)) {
    addOperand(lhs);
    addOperand(rhs);
}

pVal BinaryInst::getLHS() const { return getOperand(0)->getValue(); }

pVal BinaryInst::getRHS() const { return getOperand(1)->getValue(); }

void BinaryInst::setLHS(const pVal &lhs) { setOperand(0, lhs); }

void BinaryInst::setRHS(const pVal &rhs) { setOperand(1, rhs); }

void BinaryInst::swapLHSRHS() { swapOperand(0, 1); }

FNEGInst::FNEGInst(NameRef name, pVal val) : Instruction(OP::FNEG, name, makeBType(IRBTYPE::FLOAT)) { addOperand(val); }

pVal FNEGInst::getVal() const { return getOperand(0)->getValue(); }

void BinaryInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
void FNEGInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
} // namespace IR
