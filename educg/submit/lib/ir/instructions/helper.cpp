// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../include/ir/instructions/helper.hpp"
#include "../../../include/ir/visitor.hpp"
#include "../../../include/sir/visitor.hpp"
namespace IR {
void IFInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
void IFInst::accept(SIR::Visitor &visitor) { visitor.visit(*this); }
void IFInst::accept(SIR::ContextVisitor &visitor) {
    visitor.visit(SIR::ContextVisitor::Context::makeInitial(), *this);
}

void WHILEInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
void WHILEInst::accept(SIR::Visitor &visitor) { visitor.visit(*this); }
void WHILEInst::accept(SIR::ContextVisitor &visitor) {
    visitor.visit(SIR::ContextVisitor::Context::makeInitial(), *this);
}

void BREAKInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
void CONTINUEInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void FORInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
void FORInst::accept(SIR::Visitor &visitor) { visitor.visit(*this); }
void FORInst::accept(SIR::ContextVisitor &visitor) {
    visitor.visit(SIR::ContextVisitor::Context::makeInitial(), *this);
}

void CONDValue::accept(SIR::Visitor &visitor) { visitor.visit(*this); }
void CONDValue::accept(SIR::ContextVisitor &visitor) {
    visitor.visit(SIR::ContextVisitor::Context::makeInitial(), *this);
}
} // namespace IR