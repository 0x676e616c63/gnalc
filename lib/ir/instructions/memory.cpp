#include "../../../include/ir/instructions/memory.hpp"
#include "../../../include/ir/visitor.hpp"
#include <cassert>
#include <stdexcept>

namespace IR
{
    ALLOCAInst::ALLOCAInst(NameRef name, std::shared_ptr<Type> btype, int _align)
        : Instruction(OP::ALLOCA, name, makePtrType(btype)),
            basetype(std::move(btype)), align(_align), is_static(true) {}

    // ALLOCAInst::ALLOCAInst(NameRef name, std::shared_ptr<Type> btype, std::shared_ptr<Value> num_elements, int _align)
    //     : Instruction(OP::ALLOCA, name, makePtrType(makeArrayType(btype, num_elements->))),
    //         basetype(std::move(btype)), align(_align), is_static(false)
    // {
    //     addOperand(num_elements);
    // }

    int ALLOCAInst::getAlign() const
    {
        return align;
    }

    bool ALLOCAInst::isStatic() const
    {
        return is_static;
    }

    // std::vector<int> ALLOCAInst::getStaticArraySize() const
    // {
    //     return static_array_size;
    // }

    bool ALLOCAInst::isArray() const
    {
        return basetype->getTrait() == IRCTYPE::ARRAY;
    }

    // Value* ALLOCAInst::getNumElements() const
    // {
    //     assert(isArray());
    //     return getOperands().begin()->getValue();
    // }

    std::shared_ptr<Type> ALLOCAInst::getBaseType() const
    {
        return basetype;
    }

    LOADInst::LOADInst(NameRef name, std::shared_ptr<Value> _ptr, int _align)
        : Instruction(OP::LOAD, name, getElm(_ptr->getType())), align(_align)
    {
        addOperand(_ptr);
    }

    std::shared_ptr<Value> LOADInst::getPtr() const
    {
        return (*(getOperands().begin()))->getValue();
    }

    int LOADInst::getAlign() const
    {
        return align;
    }

    STOREInst::STOREInst(std::shared_ptr<Value> _value, std::shared_ptr<Value> _ptr, int _align)
        : Instruction(OP::STORE, "__store", makeBType(IRBTYPE::UNDEFINED)),
            align(_align)
    {
        addOperand(_value);
        addOperand(_ptr);
    }

    std::shared_ptr<Type> STOREInst::getBaseType() const
    {
        return /*(*(getOperands().begin()))->*/getValue()->getType();
    }

    std::shared_ptr<Value> STOREInst::getValue() const
    {
        return (*(getOperands().begin()))->getValue();
    }

    std::shared_ptr<Value> STOREInst::getPtr() const
    {
        return (*(std::next(getOperands().begin())))->getValue();
    }

    int STOREInst::getAlign() const
    {
        return align;
    }

    GEPInst::GEPInst(NameRef name, std::shared_ptr<Value> _ptr, const std::vector<std::shared_ptr<Value>>& idxs)
        : Instruction(OP::GEP, name, makePtrType(getElm(getElm(_ptr->getType()))))
    {
        addOperand(_ptr);
        for (auto idx : idxs)
            addOperand(idx);
    }

    std::shared_ptr<Type> GEPInst::getBaseTypePtr() const
    {
        return getElm(getPtr()->getType());
    }

    // std::vector<int> GEPInst::getArraySize() const
    // {
    //     return array_size;
    // }

    std::shared_ptr<Value> GEPInst::getPtr() const
    {
        return (*(getOperands().begin()))->getValue();
    }

    std::vector<std::shared_ptr<Value>> GEPInst::getIdxs() const
    {
        std::vector<std::shared_ptr<Value>> ret;
        for (auto it = std::next(getOperands().begin()); it != getOperands().end(); ++it)
            ret.emplace_back((*it)->getValue());
        return ret;
    }

    void ALLOCAInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
    void LOADInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
    void STOREInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
    void GEPInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
}