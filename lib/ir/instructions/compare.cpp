//
// Created by BEE172 on 24-12-5.
//
#include "../../../include/ir/instructions/compare.hpp"
#include "../../../include/ir/visitor.hpp"

namespace IR {
ICMPOP flipCond(ICMPOP cond) {
    switch (cond) {
    case ICMPOP::eq:
        return ICMPOP::ne;
    case ICMPOP::ne:
        return ICMPOP::eq;
    case ICMPOP::sgt:
        return ICMPOP::sle;
    case ICMPOP::sge:
        return ICMPOP::slt;
    case ICMPOP::slt:
        return ICMPOP::sge;
    case ICMPOP::sle:
        return ICMPOP::sgt;
    default: break;
    }
    Err::unreachable("Invalid ICMPOP to flip");
    return cond;
}

FCMPOP flipCond(FCMPOP cond) {
    switch (cond) {
    case FCMPOP::oeq:
        return FCMPOP::one;
    case FCMPOP::ogt:
        return FCMPOP::ole;
    case FCMPOP::oge:
        return FCMPOP::olt;
    case FCMPOP::olt:
        return FCMPOP::oge;
    case FCMPOP::ole:
        return FCMPOP::ogt;
    case FCMPOP::one:
        return FCMPOP::oeq;
    case FCMPOP::ord:
        Err::not_implemented("FCMPOP::ord flip");
    default: break;
    }
    Err::unreachable("Invalid FCMPOP to flip.");
    return cond;
}

ICMPOP reverseCond(ICMPOP cond) {
    switch (cond) {
    case ICMPOP::eq:
        return ICMPOP::eq;
    case ICMPOP::ne:
        return ICMPOP::ne;
    case ICMPOP::sgt:
        return ICMPOP::slt;
    case ICMPOP::sge:
        return ICMPOP::sle;
    case ICMPOP::slt:
        return ICMPOP::sgt;
    case ICMPOP::sle:
        return ICMPOP::sge;
    default: break;
    }
    Err::unreachable("Invalid ICMPOP to reverse.");
    return cond;
}

FCMPOP reverseCond(FCMPOP cond) {
    switch (cond) {
    case FCMPOP::oeq:
        return FCMPOP::oeq;
    case FCMPOP::ogt:
        return FCMPOP::olt;
    case FCMPOP::oge:
        return FCMPOP::ole;
    case FCMPOP::olt:
        return FCMPOP::ogt;
    case FCMPOP::ole:
        return FCMPOP::oge;
    case FCMPOP::one:
        return FCMPOP::one;
    case FCMPOP::ord:
        Err::not_implemented("FCMPOP::ord reverse");
    default: break;
    }
    Err::unreachable("Invalid FCMPOP to reverse.");
    return cond;
}

ICMPInst::ICMPInst(NameRef name, ICMPOP cond, const std::shared_ptr<Value> &lhs,
                   const std::shared_ptr<Value> &rhs)
    : Instruction(OP::ICMP, name, makeBType(IRBTYPE::I1)), cond(cond) {
    addOperand(lhs);
    addOperand(rhs);
}

std::shared_ptr<Value> ICMPInst::getLHS() const {
    return getOperand(0)->getValue();
}

std::shared_ptr<Value> ICMPInst::getRHS() const {
    return getOperand(1)->getValue();
}

ICMPOP ICMPInst::getCond() const { return cond; }

void ICMPInst::condFlip() {
    cond = flipCond(cond);
}


FCMPInst::FCMPInst(NameRef name, FCMPOP cond, const std::shared_ptr<Value> &lhs,
                   const std::shared_ptr<Value> &rhs)
    : Instruction(OP::FCMP, name, makeBType(IRBTYPE::I1)), cond(cond) {
    addOperand(lhs);
    addOperand(rhs);
}

std::shared_ptr<Value> FCMPInst::getLHS() const {
    return getOperand(0)->getValue();
}

std::shared_ptr<Value> FCMPInst::getRHS() const {
    return getOperand(1)->getValue();
}

FCMPOP FCMPInst::getCond() const { return cond; }

void FCMPInst::condFlip() {
    cond = flipCond(cond);
}

void ICMPInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void FCMPInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
} // namespace IR
