// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../include/ir/instructions/vector.hpp"
#include "../../../include/ir/visitor.hpp"

namespace IR {
EXTRACTInst::EXTRACTInst(NameRef name, const pVal &vector, const pVal &idx)
    : Instruction(OP::EXTRACT, name, getElm(vector->getType())) {
    Err::gassert(vector->getType()->is<VectorType>(), "Vector type expected");
    addOperand(vector);
    addOperand(idx);
}

pVal EXTRACTInst::getVector() const { return getOperand(0)->getValue(); }
pVal EXTRACTInst::getIdx() const { return getOperand(1)->getValue(); }

INSERTInst::INSERTInst(NameRef name, const pVal &vector, const pVal &element, const pVal &idx)
    : Instruction(OP::INSERT, name, vector->getType()) {
    Err::gassert(vector->getType()->is<VectorType>(), "Vector type expected");
    addOperand(vector);
    addOperand(element);
    addOperand(idx);
}
pVal INSERTInst::getVector() const { return getOperand(0)->getValue(); }
pVal INSERTInst::getElm() const { return getOperand(1)->getValue(); }
pVal INSERTInst::getIdx() const { return getOperand(2)->getValue(); }

size_t getVecSize(const pVal &v) { return v->getType()->as<VectorType>()->getVectorSize(); }

SHUFFLEInst::SHUFFLEInst(NameRef name, const pVal &v1, const pVal &v2, const pConstI32Vec &mask)
    : Instruction(OP::SHUFFLE, name, makeVectorType(getElm(v1->getType()), getVecSize(mask))) {
    Err::gassert(v1->getType()->is<VectorType>(), "Vector type expected");
    Err::gassert(isSameType(v1->getType(), v2->getType()));
    for (auto i : *mask)
        Err::gassert(i >= 0 && i < getVecSize(v1) * 2);

    addOperand(v1);
    addOperand(v2);
    addOperand(mask);
}

pVal SHUFFLEInst::getVector1() const { return getOperand(0)->getValue(); }
pVal SHUFFLEInst::getVector2() const { return getOperand(1)->getValue(); }
pConstI32Vec SHUFFLEInst::getMask() const { return getOperand(2)->getValue()->as<ConstantIntVector>(); }

void EXTRACTInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
void INSERTInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
void SHUFFLEInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
} // namespace IR