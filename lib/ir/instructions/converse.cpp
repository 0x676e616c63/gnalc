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

    ZEXTInst::ZEXTInst(NameRef name, std::shared_ptr<Value> origin_val, IRBTYPE dest_type_)
        : Instruction(OP::ZEXT, name, makeBType(dest_type_)), dest_type(dest_type_) {
        addOperand(origin_val);
    }

    std::shared_ptr<Value> ZEXTInst::getOVal() const
    {
        return (*(getOperands().begin()))->getValue();
    }

    IRBTYPE ZEXTInst::getOType() const
    {
        return toBType(getOVal()->getType())->getInner();
    }

    IRBTYPE ZEXTInst::getTType() const
    {
        return dest_type;
    }

    std::shared_ptr<Type> ZEXTInst::getOTypePtr() const {
        return getOVal()->getType();
    }

    std::shared_ptr<Type> ZEXTInst::getTTypePtr() const {
        return makeBType(dest_type);
    }

    void SITOFPInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void FPTOSIInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void ZEXTInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
}