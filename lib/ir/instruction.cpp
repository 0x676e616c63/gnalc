#include <utility>

#include "../../include/ir/instruction.hpp"
#include "../../include/ir/visitor.hpp"

namespace IR {

Instruction::Instruction(OP opcode, std::string _name, const pType &_type)
    : opcode(opcode),
      User(std::move(_name), _type,
           _type->getTrait() != IRCTYPE::BASIC ||
                   (_type->getTrait() == IRCTYPE::BASIC && _type->as<BType>()->getInner() != IRBTYPE::UNDEFINED &&
                    _type->as<BType>()->getInner() != IRBTYPE::VOID)
               ? ValueTrait::ORDINARY_VARIABLE
               : ValueTrait::VOID_INSTRUCTION) {}

void Instruction::setParent(const pBlock &p) { parent = p; }

OP Instruction::getOpcode() const { return opcode; }

pBlock Instruction::getParent() const { return parent.lock(); }

size_t Instruction::getIndex() const { return index; }

BBInstIter Instruction::getIter() const {
    Err::gassert(getOpcode() != OP::PHI);
    auto ret = std::next(parent.lock()->begin(), index - parent.lock()->getPhiCount());
    Err::gassert(ret->get() == this);
    return ret;
}

void Instruction::accept(IRVisitor &visitor) { visitor.visit(*this); }

Instruction::~Instruction() = default;

void moveInst(const pInst &inst, const pBlock &new_bb, BBInstIter location) {
    Err::gassert(inst->getOpcode() != OP::PHI && inst->getParent() != new_bb);
    inst->getParent()->delFirstOfInst(inst);
    new_bb->addInst(location, inst);
}
void moveInsts(BBInstIter beg, BBInstIter end, const pBlock &new_bb, BBInstIter location) {
    std::vector<pInst> tmp{beg, end};
    for (const auto &inst : tmp)
        moveInst(inst, new_bb, location);
}
void moveInst(const pInst &inst, const pBlock &new_bb) { moveInst(inst, new_bb, new_bb->end()); }
void moveInsts(BBInstIter beg, BBInstIter end, const pBlock &new_bb) { moveInsts(beg, end, new_bb, new_bb->end()); }

void movePhiInsts(const pBlock &src_bb, const pBlock &dest_bb) {
    Err::gassert(src_bb != dest_bb);
    std::list<pPhi> phis = src_bb->getPhiInsts(); // Not a reference
    for (const auto &phi : phis) {
        src_bb->delFirstOfPhiInst(phi);
        dest_bb->addPhiInst(phi);
    }
}
} // namespace IR
