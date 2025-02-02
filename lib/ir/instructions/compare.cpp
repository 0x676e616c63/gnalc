//
// Created by BEE172 on 24-12-5.
//
#include "../../../include/ir/instructions/compare.hpp"
#include "../../../include/ir/visitor.hpp"

namespace IR {
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
    switch (cond) {
    case ICMPOP::eq:
        cond = ICMPOP::ne;
        break;
    case ICMPOP::ne:
        cond = ICMPOP::eq;
        break;
    case ICMPOP::sgt:
        cond = ICMPOP::sle;
        break;
    case ICMPOP::sge:
        cond = ICMPOP::slt;
        break;
    case ICMPOP::slt:
        cond = ICMPOP::sge;
        break;
    case ICMPOP::sle:
        cond = ICMPOP::sgt;
        break;
    default:
        Err::unreachable("Invalid ICMPOP to flip");
        break;
    }
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
    switch (cond) {
    case FCMPOP::oeq:
        cond = FCMPOP::one;
        break;
    case FCMPOP::ogt:
        cond = FCMPOP::ole;
        break;
    case FCMPOP::oge:
        cond = FCMPOP::olt;
        break;
    case FCMPOP::olt:
        cond = FCMPOP::oge;
        break;
    case FCMPOP::ole:
        cond = FCMPOP::ogt;
        break;
    case FCMPOP::one:
        cond = FCMPOP::oeq;
        break;
    case FCMPOP::ord:
        Err::not_implemented("FCMPOP::ord flip");
        break;
    default:
        Err::unreachable("Invalid FCMPOP to flip.");
        break;
    }
}

void ICMPInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void FCMPInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
} // namespace IR
