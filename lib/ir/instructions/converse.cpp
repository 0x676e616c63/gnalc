#include "../../../include/ir/instructions/converse.hpp"
#include "../../../include/ir/visitor.hpp"

namespace IR {
    FPTOSIInst::FPTOSIInst(NameRef name, Value* origin_val)
        : Instruction(OP::FPTOSI, name, IRTYPE::I32)
    {
        operands = {Use{origin_val, this}};
    }

    Value* FPTOSIInst::getOVal() const
    {
        return operands.begin()->getValue();
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
        operands = {Use{origin_val, this}};
    }

    Value* SITOFPInst::getOVal() const
    {
        return operands.begin()->getValue();
    }

    IRTYPE SITOFPInst::getOType() const
    {
        return origin_type;
    }

    IRTYPE SITOFPInst::getTType() const
    {
        return ty;
    }

    void SITOFPInst::accept(IRVisitor& visitor) override { visitor.visit(*this); }

    void FPTOSIInst::accept(IRVisitor& visitor) override { visitor.visit(*this); }
}