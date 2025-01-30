#include "../../../include/ir/instructions/phi.hpp"
#include "../../../include/ir/visitor.hpp"

namespace IR
{
    PHIInst::PHIInst(NameRef name, const std::shared_ptr<Type>& _type, const std::vector<std::shared_ptr<PhiOperand>>& _operands)
        : Instruction(OP::PHI, name, _type) {
        for (const auto& oper : _operands)
            addOperand(oper);
    }

    std::shared_ptr<Value> PHIInst::getValueForBlock(const std::shared_ptr<BasicBlock> &block) const {
        if (block == nullptr) Err::error("PHIInst::getValueForBlock(): block is null.");
        for (const auto & it : getOperands()) {
            auto phioper = std::dynamic_pointer_cast<PhiOperand>(it->getValue());
            Err::gassert(phioper != nullptr, "PHIInst::getValueForBlock(): cast to PhiOperand failed.");
            if (phioper->getBlock() == block) {
                return phioper->getValue();
            }
        }
        return nullptr;
    }

    std::vector<std::shared_ptr<PHIInst::PhiOperand>> PHIInst::getPhiOpers() const {
        std::vector<std::shared_ptr<PhiOperand>> ret;
        for (const auto & oper : getOperands()) {
            auto phioper = std::dynamic_pointer_cast<PhiOperand>(oper->getValue());
            ret.emplace_back(phioper);
        }
        return ret;
    }

    void PHIInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    PHIInst::PhiOperand::PhiOperand(const std::shared_ptr<Value> &_value, const std::shared_ptr<BasicBlock> &_block)
        : User("__phi_operand", makeBType(IRBTYPE::UNDEFINED), ValueTrait::PHI_OPERAND) {
        addOperand(_value);
        addOperand(_block);
    }

    std::shared_ptr<Value> PHIInst::PhiOperand::getValue() const {
        return getOperands().front()->getValue();
    }

    std::shared_ptr<BasicBlock> PHIInst::PhiOperand::getBlock() const {
        return std::dynamic_pointer_cast<BasicBlock>(getOperands().back()->getValue());
    }

    PHIInst * PHIInst::PhiOperand::getPhi() const {
        return dynamic_cast<PHIInst*>(getUseList().front()->getUser());
    }
}
