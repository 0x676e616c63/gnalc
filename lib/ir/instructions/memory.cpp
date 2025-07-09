// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/instructions/memory.hpp"
#include "ir/visitor.hpp"

#include <algorithm>

namespace IR {
ALLOCAInst::ALLOCAInst(NameRef name, pType btype, int _align)
    : Instruction(OP::ALLOCA, name, makePtrType(btype)), basetype(std::move(btype)), align(_align) {}

int ALLOCAInst::getAlign() const { return align; }
void ALLOCAInst::setAlign(int a) { align = a; }

bool ALLOCAInst::isArray() const { return basetype->getTrait() == IRCTYPE::ARRAY; }

pType ALLOCAInst::getBaseType() const { return basetype; }

LOADInst::LOADInst(NameRef name, const pVal &_ptr, int _align)
    : Instruction(OP::LOAD, name, getElm(_ptr->getType())), align(_align) {
    addOperand(_ptr);
}

LOADInst::LOADInst(NameRef name, size_t n, const pVal &_ptr, int _align)
    : Instruction(OP::LOAD, name, makeVectorType(getElm(_ptr->getType()), n)), align(_align) {
}

pVal LOADInst::getPtr() const { return getOperand(0)->getValue(); }

int LOADInst::getAlign() const { return align; }
void LOADInst::setAlign(int a) {
    align = a;
}

bool LOADInst::isVectorLoad() const {
    return getType()->getTrait() == IRCTYPE::VECTOR;
}

// Unique Store Names For Quick Debug
std::string getStoreName() {
    static size_t i = 0;
    return "__store" + std::to_string(i++);
}

STOREInst::STOREInst(const pVal &_value, const pVal &_ptr, int _align)
    : Instruction(OP::STORE, getStoreName(), makeBType(IRBTYPE::UNDEFINED)), align(_align) {
    addOperand(_value);
    addOperand(_ptr);
    appendDbgData("name='" + getName() + "',");
}

pType STOREInst::getBaseType() const { return getValue()->getType(); }

pVal STOREInst::getValue() const { return getOperand(0)->getValue(); }

pVal STOREInst::getPtr() const { return getOperand(1)->getValue(); }

int STOREInst::getAlign() const { return align; }
void STOREInst::setAlign(int a) {
    align = a;
}

bool STOREInst::isVectorStore() const {
    return getValue()->getType()->getTrait() == IRCTYPE::VECTOR;
}

// 这是 gep 本身的类型，不是它的 BaseType，只辅助构造函数使用，所以只在 memory.cpp 里定义。
pType getGEPType(pType gep_ptr_type, size_t idx_size) {
    while (idx_size--)
        gep_ptr_type = getElm(gep_ptr_type);
    return makePtrType(gep_ptr_type);
}

GEPInst::GEPInst(NameRef name, const pVal &_ptr, const pVal &idx1, const pVal &idx2)
    : Instruction(OP::GEP, name, getGEPType(_ptr->getType(), 2)) {
    Err::gassert(_ptr->getType()->getTrait() == IRCTYPE::PTR);
    addOperand(_ptr);
    addOperand(idx1);
    addOperand(idx2);
}

GEPInst::GEPInst(NameRef name, const pVal &_ptr, const pVal &idx)
    : Instruction(OP::GEP, name, getGEPType(_ptr->getType(), 1)) {
    Err::gassert(_ptr->getType()->getTrait() == IRCTYPE::PTR);
    addOperand(_ptr);
    addOperand(idx);
}

GEPInst::GEPInst(NameRef name, const pVal &_ptr, const std::vector<pVal> &idxs)
    : Instruction(OP::GEP, name, getGEPType(_ptr->getType(), idxs.size())) {
    Err::gassert(_ptr->getType()->getTrait() == IRCTYPE::PTR);
    addOperand(_ptr);
    for (const auto &idx : idxs)
        addOperand(idx);
}

pType GEPInst::getBaseType() const { return getElm(getPtr()->getType()); }

pVal GEPInst::getPtr() const { return getOperand(0)->getValue(); }

std::vector<pVal> GEPInst::getIdxs() const {
    std::vector<pVal> ret;
    for (auto it = operand_begin() + 1; it != operand_end(); ++it)
        ret.emplace_back(*it);
    return ret;
}
bool GEPInst::isConstantOffset() const {
    auto idx = getIdxs();
    return std::all_of(idx.cbegin(), idx.cend(),
                       [](const auto &i) { return i->getVTrait() == ValueTrait::CONSTANT_LITERAL; });
}

size_t GEPInst::getConstantOffset() const {
    auto idx = getIdxs();

    size_t offset = 0;
    pType curr_type = getBaseType();
    for (const auto &i : idx) {
        auto ci = i->as<ConstantInt>();
        Err::gassert(ci != nullptr, "Not constant offset.");
        Err::gassert(curr_type != nullptr, "Invalid GEPInst, type mismatched with indices.");
        offset += ci->getVal() * curr_type->getBytes();
        curr_type = getElm(curr_type);
    }

    return offset;
}

void ALLOCAInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
void LOADInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
void STOREInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
void GEPInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
} // namespace IR