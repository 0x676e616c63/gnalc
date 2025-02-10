#include "../../../include/ir/instructions/phi.hpp"
#include "../../../include/ir/visitor.hpp"

#include <algorithm>

namespace IR {
PHIInst::PHIInst(NameRef name, const std::shared_ptr<Type> &_type)
    : Instruction(OP::PHI, name, _type) {}

PHIInst::PHIInst(NameRef name, const std::shared_ptr<Type> &_type,
                 const std::vector<std::shared_ptr<PhiOperand>> &_operands)
    : Instruction(OP::PHI, name, _type) {
    for (const auto &oper : _operands)
        addOperand(oper);
}

std::shared_ptr<Value>
PHIInst::getValueForBlock(const std::shared_ptr<BasicBlock> &block) const {
    if (block == nullptr)
        Err::error("PHIInst::getValueForBlock(): block is null.");
    for (const auto &it : getOperands()) {
        auto phioper = std::dynamic_pointer_cast<PhiOperand>(it->getValue());
        Err::gassert(phioper != nullptr,
                     "PHIInst::getValueForBlock(): cast to PhiOperand failed.");
        if (phioper->getBlock() == block) {
            return phioper->getValue();
        }
    }
    return nullptr;
}
void PHIInst::addPhiOper(const std::shared_ptr<PhiOperand> &_operands) {
    popers.emplace_back(_operands);
    addOperand(_operands);
}

std::vector<std::shared_ptr<PHIInst::PhiOperand>> PHIInst::getPhiOpers() const {
    std::vector<std::shared_ptr<PhiOperand>> ret;
    for (const auto &oper : getOperands()) {
        auto phioper = std::dynamic_pointer_cast<PhiOperand>(oper->getValue());
        ret.emplace_back(phioper);
    }
    return ret;
}

bool PHIInst::replaceBlock(const std::shared_ptr<BasicBlock> &before,
    const std::shared_ptr<BasicBlock> &after) {
    for (const auto& poper : popers) {
        if (poper->getBlock() == before)
            poper->setBlock(after);
        return true;
    }
    return false;
}

bool PHIInst::delPhiOper(const std::shared_ptr<BasicBlock> &target) {
    bool found = delOperandIf([&target](const auto &value) {
        return std::dynamic_pointer_cast<PhiOperand>(value)->getBlock() == target;
    });
    if (found) {
        auto it = std::find_if(popers.begin(), popers.end(),
            [&target](const auto& poper) { return poper->getBlock() == target; });
        Err::gassert(it != popers.end());
        popers.erase(it);
    }
    return found;
}

void PHIInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

PHIInst::PhiOperand::PhiOperand(const std::shared_ptr<Value> &_value,
                                const std::shared_ptr<BasicBlock> &_block)
    : User("__phi_operand", makeBType(IRBTYPE::UNDEFINED),
           ValueTrait::PHI_OPERAND) {
    addOperand(_value);
    addOperand(_block);
}

std::shared_ptr<Value> PHIInst::PhiOperand::getValue() const {
    return getOperand(0)->getValue();
}

std::shared_ptr<BasicBlock> PHIInst::PhiOperand::getBlock() const {
    return std::dynamic_pointer_cast<BasicBlock>(
        getOperand(1)->getValue());
}

void PHIInst::PhiOperand::setBlock(const std::shared_ptr<BasicBlock>& _block) {
    delOperand(1);
    addOperand(_block);
}

std::shared_ptr<PHIInst> PHIInst::PhiOperand::getPhi() const {
    return std::dynamic_pointer_cast<PHIInst>(getUseList().front()->getUser());
}

void PHIInst::PhiOperand::accept(IRVisitor &visitor) { visitor.visit(*this); }
} // namespace IR
