// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/instructions/binary.hpp"
#include "ir/visitor.hpp"

namespace IR {
BinaryInst::BinaryInst(NameRef name, OP opcode, const pVal &lhs, const pVal &rhs)
    : Instruction(opcode, name, lhs->getType()) {
    // Err::gassert(isSameType(lhs, rhs));
    addOperand(lhs);
    addOperand(rhs);
}

pVal BinaryInst::getLHS() const { return getOperand(0)->getValue(); }

pVal BinaryInst::getRHS() const { return getOperand(1)->getValue(); }

void BinaryInst::setLHS(const pVal &lhs) { setOperand(0, lhs); }

void BinaryInst::setRHS(const pVal &rhs) { setOperand(1, rhs); }

void BinaryInst::swapLHSRHS() { swapOperand(0, 1); }

FNEGInst::FNEGInst(NameRef name, pVal val) : Instruction(OP::FNEG, name, val->getType()) { addOperand(val); }

pVal FNEGInst::getVal() const { return getOperand(0)->getValue(); }

void BinaryInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
void FNEGInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
} // namespace IR
