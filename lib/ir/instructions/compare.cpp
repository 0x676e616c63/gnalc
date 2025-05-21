#include "ir/instructions/compare.hpp"
#include "ir/visitor.hpp"

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
    default:
        break;
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
    default:
        break;
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
    default:
        break;
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
    default:
        break;
    }
    Err::unreachable("Invalid FCMPOP to reverse.");
    return cond;
}

bool isFalseWhenEqual(ICMPOP cond) {
    switch (cond) {
    case ICMPOP::ne:
    case ICMPOP::sgt:
    case ICMPOP::slt:
        return true;
    default:
        return false;
    }
    return false;
}
bool isTrueWhenEqual(ICMPOP cond) {
    switch (cond) {
    case ICMPOP::eq:
    case ICMPOP::sge:
    case ICMPOP::sle:
        return true;
    default:
        return false;
    }
    return false;
}
bool isFalseWhenEqual(FCMPOP cond) {
    switch (cond) {
    case FCMPOP::one:
    case FCMPOP::ogt:
    case FCMPOP::olt:
        return true;
    default:
        return false;
    }
}
bool isTrueWhenEqual(FCMPOP cond) {
    switch (cond) {
    case FCMPOP::oeq:
    case FCMPOP::oge:
    case FCMPOP::ole:
        return true;
    default:
        return false;
    }
}

ICMPInst::ICMPInst(NameRef name, ICMPOP cond, const pVal &lhs, const pVal &rhs)
    : Instruction(OP::ICMP, name, makeBType(IRBTYPE::I1)), cond(cond) {
    addOperand(lhs);
    addOperand(rhs);
}

pVal ICMPInst::getLHS() const { return getOperand(0)->getValue(); }

pVal ICMPInst::getRHS() const { return getOperand(1)->getValue(); }

ICMPOP ICMPInst::getCond() const { return cond; }

void ICMPInst::condFlip() { cond = flipCond(cond); }

FCMPInst::FCMPInst(NameRef name, FCMPOP cond, const pVal &lhs, const pVal &rhs)
    : Instruction(OP::FCMP, name, makeBType(IRBTYPE::I1)), cond(cond) {
    addOperand(lhs);
    addOperand(rhs);
}

pVal FCMPInst::getLHS() const { return getOperand(0)->getValue(); }

pVal FCMPInst::getRHS() const { return getOperand(1)->getValue(); }

FCMPOP FCMPInst::getCond() const { return cond; }

void FCMPInst::condFlip() { cond = flipCond(cond); }

void ICMPInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void FCMPInst::accept(IRVisitor &visitor) { visitor.visit(*this); }
} // namespace IR
