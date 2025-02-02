#include "../../../include/ir/instructions/converse.hpp"
#include "../../../include/ir/visitor.hpp"
#include "../../../include/utils/exception.hpp"

namespace IR {
CastInst::CastInst(OP opcode_, NameRef name,
                   const std::shared_ptr<Value> &origin_val,
                   const std::shared_ptr<Type> &dest_type_)
    : Instruction(opcode_, name, dest_type_), dest_type(dest_type_) {
    addOperand(origin_val);
}

std::shared_ptr<Value> CastInst::getOVal() const {
    return getOperand(0)->getValue();
}

std::shared_ptr<Type> CastInst::getOType() const {
    return getOVal()->getType();
}

std::shared_ptr<Type> CastInst::getTType() const { return dest_type; }

void CastInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

FPTOSIInst::FPTOSIInst(NameRef name, const std::shared_ptr<Value> &origin_val)
    : CastInst(OP::FPTOSI, name, origin_val, makeBType(IRBTYPE::I32)) {}

SITOFPInst::SITOFPInst(NameRef name, const std::shared_ptr<Value> &origin_val)
    : CastInst(OP::SITOFP, name, origin_val, makeBType(IRBTYPE::FLOAT)) {}

ZEXTInst::ZEXTInst(NameRef name, const std::shared_ptr<Value> &origin_val,
                   IRBTYPE dest_type_)
    : CastInst(OP::ZEXT, name, origin_val, makeBType(dest_type_)) {}

BITCASTInst::BITCASTInst(NameRef name, const std::shared_ptr<Value> &origin_val,
                         const std::shared_ptr<Type> &dest_type_)
    : CastInst(OP::BITCAST, name, origin_val, dest_type_) {}

void FPTOSIInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void SITOFPInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void ZEXTInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void BITCASTInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
} // namespace IR
