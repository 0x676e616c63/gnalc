#include "../../../include/ir/instructions/phi.hpp"
#include "../../../include/ir/visitor.hpp"

#include <algorithm>

namespace IR {
PHIInst::PHIInst(NameRef name, const std::shared_ptr<Type> &_type)
    : Instruction(OP::PHI, name, _type) {}

std::shared_ptr<Value> PHIInst::getValueForBlock(const std::shared_ptr<BasicBlock> &block) const {
    if (block == nullptr)
        Err::error("PHIInst::getValueForBlock(): block is null.");
    for (auto it = operand_begin(); it != operand_end(); ++it) {
        ++it;
        if (*it == block)
            return *--it;
    }
    Err::unreachable("Not a pred block.");
    return nullptr;
}

std::shared_ptr<BasicBlock> PHIInst::getBlockForValue(const std::shared_ptr<Use> &use) const {
    for (auto it = use_begin(); it != use_end(); ++it) {
        if (*it == use)
            return std::dynamic_pointer_cast<BasicBlock>((*++it)->getValue());
    }
    return nullptr;
}

void PHIInst::addPhiOper(const std::shared_ptr<Value> &val, const std::shared_ptr<BasicBlock> &blk) {
    Err::gassert(isSameType(getType(), val->getType()), "PHIInst::addPhiOper(): type mismatched");
    addOperand(val);
    addOperand(blk);
}

std::vector<PHIInst::PhiOper> PHIInst::getPhiOpers() const {
    std::vector<PhiOper> ret;
    for (auto it = operand_begin(); it != operand_end(); ++it) {
        auto v = *it;
        auto b = std::dynamic_pointer_cast<BasicBlock>(*++it);
        ret.emplace_back(v, b);
    }
    return ret;
}

bool PHIInst::delPhiOperByBlock(const std::shared_ptr<BasicBlock> &target) {
    for (size_t i = 1; i < getOperands().size(); i += 2) {
        if (getOperand(i)->getValue() == target) {
            delOperand(i);
            delOperand(i - 1);
            return true;
        }
    }
    return false;
}

bool PHIInst::hasBlock(const std::shared_ptr<BasicBlock> & target) {
    for (size_t i = 1; i < getOperands().size(); i += 2) {
        if (getOperand(i)->getValue() == target)
            return true;
    }
    return false;
}

void PHIInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

} // namespace IR
