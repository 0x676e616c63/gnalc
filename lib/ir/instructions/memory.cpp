#include "../../../include/ir/instructions/memory.hpp"
#include "../../../include/ir/visitor.hpp"

#include <algorithm>
#include <cassert>
#include <stdexcept>

namespace IR {
ALLOCAInst::ALLOCAInst(NameRef name, std::shared_ptr<Type> btype, int _align)
    : Instruction(OP::ALLOCA, name, makePtrType(btype)),
      basetype(std::move(btype)), align(_align) {}

int ALLOCAInst::getAlign() const { return align; }

bool ALLOCAInst::isArray() const {
    return basetype->getTrait() == IRCTYPE::ARRAY;
}

std::shared_ptr<Type> ALLOCAInst::getBaseType() const { return basetype; }

LOADInst::LOADInst(NameRef name, const std::shared_ptr<Value> &_ptr, int _align)
    : Instruction(OP::LOAD, name, getElm(_ptr->getType())), align(_align) {
    addOperand(_ptr);
}

std::shared_ptr<Value> LOADInst::getPtr() const {
    return getOperand(0)->getValue();
}

int LOADInst::getAlign() const { return align; }

STOREInst::STOREInst(const std::shared_ptr<Value> &_value,
                     const std::shared_ptr<Value> &_ptr, int _align)
    : Instruction(OP::STORE, "__store", makeBType(IRBTYPE::UNDEFINED)),
      align(_align) {
    addOperand(_value);
    addOperand(_ptr);
}

std::shared_ptr<Type> STOREInst::getBaseType() const {
    return getValue()->getType();
}

std::shared_ptr<Value> STOREInst::getValue() const {
    return getOperand(0)->getValue();
}

std::shared_ptr<Value> STOREInst::getPtr() const {
    return getOperand(1)->getValue();
}

int STOREInst::getAlign() const { return align; }

// 这是 gep 本身的类型，不是它的 BaseType，只辅助构造函数使用，所以只在 memory.cpp 里定义。
std::shared_ptr<Type> getGEPType(std::shared_ptr<Type> gep_ptr_type, size_t idx_size) {
    while (idx_size--)
        gep_ptr_type = getElm(gep_ptr_type);
    return makePtrType(gep_ptr_type);
}

GEPInst::GEPInst(NameRef name, const std::shared_ptr<Value> &_ptr,
                 const std::shared_ptr<Value> &idx1,
                 const std::shared_ptr<Value> &idx2)
    : Instruction(OP::GEP, name, getGEPType(_ptr->getType(), 2)) {
    Err::gassert(_ptr->getType()->getTrait() == IRCTYPE::PTR);
    addOperand(_ptr);
    addOperand(idx1);
    addOperand(idx2);
}

GEPInst::GEPInst(NameRef name, const std::shared_ptr<Value> &_ptr,
                 const std::shared_ptr<Value> &idx)
    : Instruction(OP::GEP, name, getGEPType(_ptr->getType(), 1)) {
    Err::gassert(_ptr->getType()->getTrait() == IRCTYPE::PTR);
    addOperand(_ptr);
    addOperand(idx);
}

GEPInst::GEPInst(NameRef name, const std::shared_ptr<Value> &_ptr,
    const std::vector<std::shared_ptr<Value>> &idxs)
    : Instruction(OP::GEP, name, getGEPType(_ptr->getType(), idxs.size())) {
    Err::gassert(_ptr->getType()->getTrait() == IRCTYPE::PTR);
    addOperand(_ptr);
    for (const auto &idx : idxs)
        addOperand(idx);
}

std::shared_ptr<Type> GEPInst::getBaseType() const {
    return getElm(getPtr()->getType());
}

std::shared_ptr<Value> GEPInst::getPtr() const {
    return getOperand(0)->getValue();
}

std::vector<std::shared_ptr<Value>> GEPInst::getIdxs() const {
    std::vector<std::shared_ptr<Value>> ret;
    for (auto it = begin() + 1; it != end(); ++it)
        ret.emplace_back((*it)->getValue());
    return ret;
}
bool GEPInst::isConstantOffset() const {
    auto idx = getIdxs();
    return std::all_of(idx.cbegin(), idx.cend(),
        [](const auto& i){ return i->getVTrait() == ValueTrait::CONSTANT_LITERAL; });
}

size_t GEPInst::getConstantOffset() const {
    auto idx = getIdxs();

    size_t offset = 0;
    std::shared_ptr<Type> curr_type = getBaseType();
    for (const auto& i : idx) {
        auto ci = std::dynamic_pointer_cast<ConstantInt>(i);
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