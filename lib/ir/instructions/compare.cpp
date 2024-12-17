//
// Created by BEE172 on 24-12-5.
//
#include "../../../include/ir/instructions/compare.hpp"
#include "../../../include/ir/visitor.hpp"


namespace IR {
    ICMPInst::ICMPInst(NameRef name, ICMPOP cond, Value *lhs, Value *rhs)
        : Instruction(OP::ICMP, name, IRTYPE::I1), cond(cond) {
        addOperand(lhs);
        addOperand(rhs);
    }

    Value* ICMPInst::getLHS() const {
        return getOperands().begin()->getValue();
    }

    Value* ICMPInst::getRHS() const {
        return getOperands().rbegin()->getValue();
    }

    ICMPOP ICMPInst::getCond() const {
        return cond;
    }

    FCMPInst::FCMPInst(NameRef name, FCMPOP cond, Value *lhs, Value *rhs)
        : Instruction(OP::FCMP, name, IRTYPE::I1), cond(cond) {
        addOperand(lhs);
        addOperand(rhs);
    }

    Value* FCMPInst::getLHS() const {
        return getOperands().begin()->getValue();
    }

    Value* FCMPInst::getRHS() const {
        return getOperands().rbegin()->getValue();
    }

    FCMPOP FCMPInst::getCond() const {
        return cond;
    }

    void ICMPInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void FCMPInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
}
