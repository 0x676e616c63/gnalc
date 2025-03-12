#include <utility>

#include "../../include/ir/instruction.hpp"
#include "../../include/ir/visitor.hpp"

namespace IR {

Instruction::Instruction(OP opcode, std::string _name,
                         const std::shared_ptr<Type> &_type)
    : opcode(opcode),
      User(std::move(_name), _type,
           _type->getTrait() != IRCTYPE::BASIC ||
                   (_type->getTrait() == IRCTYPE::BASIC &&
                    toBType(_type)->getInner() != IRBTYPE::UNDEFINED &&
                    toBType(_type)->getInner() != IRBTYPE::VOID)
               ? ValueTrait::ORDINARY_VARIABLE
               : ValueTrait::VOID_INSTRUCTION) {}

void Instruction::setParent(const std::shared_ptr<BasicBlock> &p) {
    parent = p;
}

OP Instruction::getOpcode() const { return opcode; }

std::shared_ptr<BasicBlock> Instruction::getParent() const {
    return parent.lock();
}

size_t Instruction::getIndex() const {
    return index;
}

BBInstIter Instruction::getIter() const {
    Err::gassert(getOpcode() != OP::PHI);
    auto ret = std::next(parent.lock()->begin(), index - parent.lock()->getPhiCount());
    Err::gassert(ret->get() == this);
    return ret;
}

void Instruction::accept(IRVisitor &visitor) { visitor.visit(*this); }

Instruction::~Instruction() = default;

void moveInst(const std::shared_ptr<Instruction>& inst,
    const std::shared_ptr<BasicBlock>& new_bb, BBInstIter location) {
    Err::gassert(inst->getOpcode() != OP::PHI && inst->getParent() != new_bb);
    auto target = std::dynamic_pointer_cast<Instruction>(inst->shared_from_this());
    inst->getParent()->delFirstOfInst(target);
    new_bb->addInst(location, target);
}
void moveInsts(BBInstIter beg, BBInstIter end,
    const std::shared_ptr<BasicBlock>& new_bb, BBInstIter location) {
    std::vector<std::shared_ptr<Instruction>> tmp {beg, end};
    for (const auto& inst : tmp)
        moveInst(inst, new_bb, location);
}
void moveInst(const std::shared_ptr<Instruction>& inst,
    const std::shared_ptr<BasicBlock>& new_bb) {
    moveInst(inst, new_bb, new_bb->end());
}
void moveInsts(BBInstIter beg, BBInstIter end,
    const std::shared_ptr<BasicBlock>& new_bb) {
    moveInsts(beg, end, new_bb, new_bb->end());
}

void movePhiInsts(const std::shared_ptr<BasicBlock>& src_bb, const std::shared_ptr<BasicBlock>& dest_bb)
{
    Err::gassert(src_bb != dest_bb);
    std::list<std::shared_ptr<PHIInst>> phis = src_bb->getPhiInsts(); // Not a reference
    for (const auto& phi : phis) {
        src_bb->delFirstOfPhiInst(phi);
        dest_bb->addPhiInst(phi);
    }
}
} // namespace IR
