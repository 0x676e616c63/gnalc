#include "../../../include/ir/instructions/memory.hpp"
#include "../../../include/ir/visitor.hpp"
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
        operands = { Use{num_elements, this} };
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

    GEPInst::GEPInst(NameRef name, IRTYPE btype, std::vector<int> _array_size,  Value* _ptr, const std::list<Value*>& idxs)
        : Instruction(OP::GEP, name, IRTYPE::PTR), basetype(btype), array_size(_array_size)
    {
        operands = {Use{_ptr, this}};
        for (auto idx : idxs)
            operands.emplace_back(Use{idx, this});
    }

    IRTYPE GEPInst::getBaseType() const
    {
        return basetype;
    }

    std::vector<int> GEPInst::getArraySize() const
    {
        return array_size;
    }

    Value* GEPInst::getPtr() const
    {
        return operands.begin()->getValue();
    }

    std::vector<Value*> GEPInst::getIdxs() const
    {
        std::vector<Value*> ret;
        for (auto it = std::next(operands.begin()); it != operands.end(); ++it)
            ret.emplace_back(it->getValue());
        return ret;
    }

    void ALLOCAInst::accept(IRVisitor& visitor) override { visitor.visit(*this); }
    void LOADInst::accept(IRVisitor& visitor) override { visitor.visit(*this); }
    void STOREInst::accept(IRVisitor& visitor) override { visitor.visit(*this); }
    void GEPInst::accept(IRVisitor& visitor) override { visitor.visit(*this); }
}