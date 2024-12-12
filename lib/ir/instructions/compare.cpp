//
// Created by BEE172 on 24-12-5.
//
#include "../../../include/ir/instructions/compare.hpp"
#include "../../../include/ir/visitor.hpp"


namespace IR {
    ICMPInst::ICMPInst(NameRef name, ICMPOP cond, Value *lhs, Value *rhs)
        : Instruction(OP::ICMP, name, IRTYPE::I32), cond(cond) {
        addOperand(lhs);
        addOperand(rhs);
    }

    Value* ICMPInst::GetLHS() const {
        return getOperands().begin()->getValue();
    }

    Value* ICMPInst::GetRHS() const {
        return getOperands().rbegin()->getValue();
    }

    ICMPOP ICMPInst::GetCond() const {
        return cond;
    }

    FCMPInst::FCMPInst(NameRef name, FCMPOP cond, Value *lhs, Value *rhs)
        : Instruction(OP::FCMP, name, IRTYPE::FLOAT), cond(cond) {
        addOperand(lhs);
        addOperand(rhs);
    }

    Value* FCMPInst::GetLHS() const {
        return getOperands().begin()->getValue();
    }

    Value* FCMPInst::GetRHS() const {
        return getOperands().rbegin()->getValue();
    }

    FCMPOP FCMPInst::GetCond() const {
        return cond;
    }

    void ICMPInst::accept(IRVisitor& visitor) override { visitor.visit(*this); }

    void FCMPInst::accept(IRVisitor& visitor) override { visitor.visit(*this); }
}
