#include "../../../include/ir/instructions/phi.hpp"
#include "../../../include/ir/visitor.hpp"

#include <algorithm>

namespace IR {
PHIInst::PHIInst(NameRef name, const pType &_type) : Instruction(OP::PHI, name, _type) {}

pVal PHIInst::getValueForBlock(const pBlock &block) const {
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

pBlock PHIInst::getBlockForValue(const std::shared_ptr<Use> &use) const {
    Err::gassert(use->getValue()->getVTrait() != ValueTrait::BASIC_BLOCK);
    for (auto it = operand_use_begin(); it != operand_use_end(); ++it) {
        if (*it == use)
            return (*(it + 1))->getValue()->as<BasicBlock>();
    }
    return nullptr;
}

void PHIInst::addPhiOper(const pVal &val, const pBlock &blk) {
    Err::gassert(isSameType(getType(), val->getType()), "PHIInst::addPhiOper(): type mismatched");
    addOperand(val);
    addOperand(blk);
}

std::vector<PHIInst::PhiOper> PHIInst::getPhiOpers() const {
    std::vector<PhiOper> ret;
    for (auto it = operand_begin(); it != operand_end(); ++it) {
        auto v = *it;
        auto b = (*++it)->as<BasicBlock>();
        ret.emplace_back(v, b);
    }
    return ret;
}

bool PHIInst::delPhiOperByBlock(const pBlock &target) {
    for (size_t i = 1; i < getOperands().size(); i += 2) {
        if (getOperand(i)->getValue() == target) {
            delOperand(i);
            delOperand(i - 1);
            return true;
        }
    }
    return false;
}

bool PHIInst::hasBlock(const pBlock &target) {
    for (size_t i = 1; i < getOperands().size(); i += 2) {
        if (getOperand(i)->getValue() == target)
            return true;
    }
    return false;
}

void PHIInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

} // namespace IR
