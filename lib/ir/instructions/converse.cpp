#include "../../../include/ir/instructions/converse.hpp"
#include "../../../include/ir/visitor.hpp"
#include "../../../include/utils/exception.hpp"

namespace IR {
    FPTOSIInst::FPTOSIInst(NameRef name, std::shared_ptr<Value> origin_val)
        : Instruction(OP::FPTOSI, name, makeBType(IRBTYPE::I32))
    {
        Err::assert(origin_val->getType() == IRBTYPE::FLOAT, "FPTOSIInst: origin_val is not IRBTYPE::FLOAT.");
        addOperand(origin_val);
    }

    std::shared_ptr<Value> FPTOSIInst::getOVal() const
    {
        return (*(getOperands().begin()))->getValue();
    }

    IRBTYPE FPTOSIInst::getOType() const
    {
        return getBTy(getOVal()->getTypePtr());
    }

    IRBTYPE FPTOSIInst::getTType() const
    {
        return getBTy(getTypePtr());
    }

    std::shared_ptr<Type> FPTOSIInst::getOTypePtr() const {
        return getOVal()->getTypePtr();
    }

    std::shared_ptr<Type> FPTOSIInst::getTTypePtr() const {
        return getTypePtr();
    }

    SITOFPInst::SITOFPInst(NameRef name, std::shared_ptr<Value> origin_val)
        : Instruction(OP::SITOFP, name, makeBType(IRBTYPE::FLOAT))
    {
        Err::assert(origin_val->getType() == IRBTYPE::I32, "SITOFPInst: origin_val is not IRBTYPE::I32.");
        addOperand(origin_val);
    }

    std::shared_ptr<Value> SITOFPInst::getOVal() const
    {
        return (*(getOperands().begin()))->getValue();
    }

    IRBTYPE SITOFPInst::getOType() const
    {
        return getBTy(getOVal()->getTypePtr());
    }

    IRBTYPE SITOFPInst::getTType() const
    {
        return getBTy(getTypePtr());
    }

    std::shared_ptr<Type> SITOFPInst::getOTypePtr() const {
        return getOVal()->getTypePtr();
    }

    std::shared_ptr<Type> SITOFPInst::getTTypePtr() const {
        return getTypePtr();
    }

    void SITOFPInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void FPTOSIInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
}