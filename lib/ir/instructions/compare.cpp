//
// Created by BEE172 on 24-12-5.
//
#include "../../../include/ir/instructions/compare.hpp"
#include "../../../include/ir/visitor.hpp"


namespace IR {
    ICMPInst::ICMPInst(NameRef name, ICMPOP cond, std::shared_ptr<Value> lhs, std::shared_ptr<Value> rhs)
        : Instruction(OP::ICMP, name, makeBType(IRBTYPE::I1)), cond(cond) {
        addOperand(lhs);
        addOperand(rhs);
    }

    std::shared_ptr<Value> ICMPInst::getLHS() const {
        return (*(getOperands().begin()))->getValue();
    }

    std::shared_ptr<Value> ICMPInst::getRHS() const {
        return (*(getOperands().rbegin()))->getValue();
    }

    ICMPOP ICMPInst::getCond() const {
        return cond;
    }

    FCMPInst::FCMPInst(NameRef name, FCMPOP cond, std::shared_ptr<Value> lhs, std::shared_ptr<Value> rhs)
        : Instruction(OP::FCMP, name, makeBType(IRBTYPE::I1)), cond(cond) {
        addOperand(lhs);
        addOperand(rhs);
    }

    std::shared_ptr<Value> FCMPInst::getLHS() const {
        return (*(getOperands().begin()))->getValue();
    }

    std::shared_ptr<Value> FCMPInst::getRHS() const {
        return (*(getOperands().rbegin()))->getValue();
    }

    FCMPOP FCMPInst::getCond() const {
        return cond;
    }

    void ICMPInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void FCMPInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
}
