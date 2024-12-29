#include "../../../include/ir/instructions/converse.hpp"
#include "../../../include/ir/visitor.hpp"
#include "../../../include/utils/exception.hpp"

namespace IR {
    FPTOSIInst::FPTOSIInst(NameRef name, std::shared_ptr<Value> origin_val)
        : Instruction(OP::FPTOSI, name, makeBType(IRBTYPE::I32))
    {
        addOperand(origin_val);
    }

    std::shared_ptr<Value> FPTOSIInst::getOVal() const
    {
        return (*(getOperands().begin()))->getValue();
    }

    IRBTYPE FPTOSIInst::getOType() const
    {
        return IRBTYPE::FLOAT;
    }

    IRBTYPE FPTOSIInst::getTType() const
    {
        return IRBTYPE::I32;
    }

    std::shared_ptr<Type> FPTOSIInst::getOTypePtr() const {
        return makeBType(IRBTYPE::FLOAT);
    }

    std::shared_ptr<Type> FPTOSIInst::getTTypePtr() const {
        return makeBType(IRBTYPE::I32);
    }

    SITOFPInst::SITOFPInst(NameRef name, std::shared_ptr<Value> origin_val)
        : Instruction(OP::SITOFP, name, makeBType(IRBTYPE::FLOAT))
    {
        addOperand(origin_val);
    }

    std::shared_ptr<Value> SITOFPInst::getOVal() const
    {
        return (*(getOperands().begin()))->getValue();
    }

    IRBTYPE SITOFPInst::getOType() const
    {
        return IRBTYPE::I32;
    }

    IRBTYPE SITOFPInst::getTType() const
    {
        return IRBTYPE::FLOAT;
    }

    std::shared_ptr<Type> SITOFPInst::getOTypePtr() const {
        return makeBType(IRBTYPE::I32);
    }

    std::shared_ptr<Type> SITOFPInst::getTTypePtr() const {
        return makeBType(IRBTYPE::FLOAT);
    }

    void SITOFPInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void FPTOSIInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
}