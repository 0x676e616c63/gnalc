#include "../../../include/ir/instructions/phi.hpp"
#include "../../../include/ir/visitor.hpp"

#include <algorithm>

namespace IR {
PHIInst::PHIInst(NameRef name, const std::shared_ptr<Type> &_type)
    : Instruction(OP::PHI, name, _type) {}

std::shared_ptr<Value>
PHIInst::getValueForBlock(const std::shared_ptr<BasicBlock> &block) const {
    if (block == nullptr)
        Err::error("PHIInst::getValueForBlock(): block is null.");
    for (auto it = getOperands().begin(); it != getOperands().end(); ++it) {
        ++it;
        if ((*it)->getValue() == block)
            return (*--it)->getValue();
    }
    return nullptr;
}

void PHIInst::addPhiOper(const std::shared_ptr<Value> &val, const std::shared_ptr<BasicBlock> &blk) {
    addOperand(val);
    addOperand(blk);
}

std::vector<PHIInst::PhiOper> PHIInst::getPhiOpers() const {
    std::vector<PhiOper> ret;
    for (auto it = getOperands().begin(); it != getOperands().end(); ++it) {
        auto v = (*it)->getValue();
        auto b = std::dynamic_pointer_cast<BasicBlock>((*++it)->getValue());
        ret.emplace_back(v, b);
    }
    return ret;
}

bool PHIInst::replaceBlock(const std::shared_ptr<BasicBlock> &before,
    const std::shared_ptr<BasicBlock> &after) {
    return replaceUse(before, after);
}

bool PHIInst::delPhiOper(const std::shared_ptr<BasicBlock> &target) {
    int index = -1;
    for (auto it = getOperands().begin(); it != getOperands().end(); ++it) {
        ++it;
        index += 2;
        if ((*it)->getValue() == target) {
            delOperand(index);
            delOperand(index-1);
            return true;
        }
    }
    return false;
}

void PHIInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

} // namespace IR
