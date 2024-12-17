#include "../../../include/ir/instructions/converse.hpp"
#include "../../../include/ir/visitor.hpp"
#include <cassert>

namespace IR {
    FPTOSIInst::FPTOSIInst(NameRef name, Value* origin_val)
        : Instruction(OP::FPTOSI, name, IRTYPE::I32)
    {
        assert(origin_val->getType() == IRTYPE::FLOAT);
        addOperand(origin_val);
    }

    Value* FPTOSIInst::getOVal() const
    {
        return getOperands().begin()->getValue();
    }

    IRTYPE FPTOSIInst::getOType() const
    {
        return origin_type;
    }

    IRTYPE FPTOSIInst::getTType() const
    {
        return ty;
    }

    SITOFPInst::SITOFPInst(NameRef name, Value* origin_val)
        : Instruction(OP::SITOFP, name, IRTYPE::FLOAT)
    {
        assert(origin_val->getType() == IRTYPE::I32);
        addOperand(origin_val);
    }

    Value* SITOFPInst::getOVal() const
    {
        return getOperands().begin()->getValue();
    }

    IRTYPE SITOFPInst::getOType() const
    {
        return origin_type;
    }

    IRTYPE SITOFPInst::getTType() const
    {
        return ty;
    }

    void SITOFPInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void FPTOSIInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
}