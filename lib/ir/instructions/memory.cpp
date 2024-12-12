#include "../../../include/ir/instructions/memory.hpp"
#include <cassert>
#include <stdexcept>

namespace IR
{
    ALLOCAInst::ALLOCAInst(NameRef name, IRTYPE btype, int _align)
        : Instruction(OP::ALLOCA, name, IRTYPE::PTR),
            basetype(btype), align(_align), is_array(false), is_static(true) {}

    ALLOCAInst::ALLOCAInst(NameRef name, IRTYPE btype, const std::vector<int>& _array_size, int _align)
        : Instruction(OP::ALLOCA, name, IRTYPE::PTR),
            basetype(btype), align(_align), is_array(true), is_static(true), static_array_size(_array_size) {}

    ALLOCAInst::ALLOCAInst(NameRef name, IRTYPE btype, Value* num_elements, int _align)
        : Instruction(OP::ALLOCA, name, IRTYPE::PTR),
            basetype(btype), align(_align), is_array(true), is_static(false)
    {
        addOperands(num_elements);
    }

    int ALLOCAInst::getAlign() const
    {
        return align;
    }

    bool ALLOCAInst::isStatic() const
    {
        return is_static;
    }

    std::vector<int> ALLOCAInst::getStaticArraySize() const
    {
        return static_array_size;
    }

    bool ALLOCAInst::isArray() const
    {
        return is_array;
    }

    Value* ALLOCAInst::getNumElements() const
    {
        assert(isArray());
        return getOperands().begin()->getValue();
    }

    IRTYPE ALLOCAInst::getBaseType() const
    {
        return basetype;
    }

    LOADInst::LOADInst(NameRef name, IRTYPE ty, Value* _ptr, int _align)
        : Instruction(OP::LOAD, name, ty), align(_align)
    {
        addOperands(_ptr);
    }

    Value* LOADInst::getPtr() const
    {
        return getOperands().begin()->getValue();
    }

    int LOADInst::getAlign() const
    {
        return align;
    }

    STOREInst::STOREInst(IRTYPE btype, Value* _value, Value* _ptr, int _align)
        : Instruction(OP::STORE, "__store", IRTYPE::UNDEFINED),
            basetype(btype), align(_align)
    {
        addOperands(_value,_ptr);
    }

    IRTYPE STOREInst::getBaseType() const
    {
        return basetype;
    }

    Value* STOREInst::getValue() const
    {
        return getOperands().begin()->getValue();
    }

    Value* STOREInst::getPtr() const
    {
        return std::next(getOperands().begin())->getValue();
    }

    int STOREInst::getAlign() const
    {
        return align;
    }

    GEPInst::GEPInst(NameRef name, IRTYPE btype, Value* _ptr, const std::list<Value*>& idxs)
        : Instruction(OP::GEP, name, IRTYPE::PTR), basetype(btype)
    {
        addOperands(_ptr,idxs);
        for (auto idx : idxs)
            operands.emplace_back(Use{idx, this});
    }

    Value* GEPInst::getPtr() const
    {
        return getOperands().begin()->getValue();
    }

    std::vector<Value*> GEPInst::getIdxs() const
    {
        std::vector<Value*> ret;
        for (auto it = std::next(getOperands().begin()); it != getOperands().end(); ++it)
            ret.emplace_back(it->getValue());
        return ret;
    }
}
