// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../include/ir/instructions/converse.hpp"
#include "../../../include/ir/visitor.hpp"
#include "../../../include/utils/exception.hpp"

namespace IR {
CastInst::CastInst(OP opcode_, NameRef name, const pVal &origin_val, const pType &dest_type_)
    : Instruction(opcode_, name, dest_type_), dest_type(dest_type_) {
    addOperand(origin_val);
}

pVal CastInst::getOVal() const { return getOperand(0)->getValue(); }

pType CastInst::getOType() const { return getOVal()->getType(); }

pType CastInst::getTType() const { return dest_type; }

void CastInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

FPTOSIInst::FPTOSIInst(NameRef name, const pVal &origin_val)
    : CastInst(OP::FPTOSI, name, origin_val, makeBType(IRBTYPE::I32)) {}

SITOFPInst::SITOFPInst(NameRef name, const pVal &origin_val)
    : CastInst(OP::SITOFP, name, origin_val, makeBType(IRBTYPE::FLOAT)) {}

ZEXTInst::ZEXTInst(NameRef name, const pVal &origin_val, IRBTYPE dest_type_)
    : CastInst(OP::ZEXT, name, origin_val, makeBType(dest_type_)) {}

SEXTInst::SEXTInst(NameRef name, const pVal &origin_val, IRBTYPE dest_type_)
    : CastInst(OP::SEXT, name, origin_val, makeBType(dest_type_)) {}

BITCASTInst::BITCASTInst(NameRef name, const pVal &origin_val, const pType &dest_type_)
    : CastInst(OP::BITCAST, name, origin_val, dest_type_) {}

void FPTOSIInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void SITOFPInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void ZEXTInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void SEXTInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void BITCASTInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
} // namespace IR
