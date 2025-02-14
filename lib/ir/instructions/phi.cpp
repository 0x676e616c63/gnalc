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
    Err::unreachable("Not a pred block.");
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
bool PHIInst::delPhiOperByVal(const std::shared_ptr<Value> & target) {
    for (size_t i = 1; i < getOperands().size(); i += 2) {
        if (getOperand(i - 1)->getValue() == target) {
            delOperand(i);
            delOperand(i - 1);
            return true;
        }
    }
    return false;
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

void PHIInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

} // namespace IR
