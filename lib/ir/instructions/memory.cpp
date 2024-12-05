#include "../../../include/ir/instructions/memory.hpp"
#include <cassert>
#include <stdexcept>

namespace IR
{
    ALLOCAInst::ALLOCAInst(NameRef name, IRTYPE btype, int _align)
        : Instruction(OP::ALLOCA, name, IRTYPE::PTR),
            basetype(btype), align(_align), is_array(false) {}

    ALLOCAInst::ALLOCAInst(NameRef name, IRTYPE btype, Value* num_elements, int _align)
        : Instruction(OP::ALLOCA, name, IRTYPE::PTR),
            basetype(btype), align(_align), is_array(true)
    {
        operands = { Use{num_elements, this} };
    }

    int ALLOCAInst::getAlign() const
    {
        return align;
    }

    bool ALLOCAInst::isArray() const
    {
        return is_array;
    }

    Value* ALLOCAInst::getNumElements() const
    {
        assert(isArray());
        return operands.begin()->getValue();
    }

    IRTYPE ALLOCAInst::getBaseType() const
    {
        return basetype;
    }

    LOADInst::LOADInst(NameRef name, IRTYPE ty, Value* _ptr, int _align)
        : Instruction(OP::LOAD, name, ty), align(_align)
    {
        operands = {Use{_ptr, this}};
    }

    Value* LOADInst::getPtr() const
    {
        return operands.begin()->getValue();
    }

    int LOADInst::getAlign() const
    {
        return align;
    }

    STOREInst::STOREInst(IRTYPE btype, Value* _value, Value* _ptr, int _align)
        : Instruction(OP::STORE, "__store", IRTYPE::UNDEFINED),
            basetype(btype), align(_align)
    {
        operands = {Use{_value, this}, Use{_ptr, this}};
    }

    IRTYPE STOREInst::getBaseType() const
    {
        return basetype;
    }

    Value* STOREInst::getValue() const
    {
        return operands.begin()->getValue();
    }

    Value* STOREInst::getPtr() const
    {
        return std::next(operands.begin())->getValue();
    }

    int STOREInst::getAlign() const
    {
        return align;
    }

    GEPInst::GEPInst(NameRef name, IRTYPE btype, Value* _ptr, Value* idx)
        : Instruction(OP::GEP, name, IRTYPE::PTR), basetype(btype)
    {
        operands = {Use{_ptr, this}, Use{idx, this}};
    }

    Value* GEPInst::getPtr() const
    {
        return operands.begin()->getValue();
    }

    Value* GEPInst::getIdx() const
    {
        return std::next(operands.begin())->getValue();
    }
}
