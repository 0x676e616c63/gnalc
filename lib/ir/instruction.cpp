#include <utility>

#include "../../include/ir/instruction.hpp"
#include "../../include/ir/visitor.hpp"

namespace IR {

Instruction::Instruction(OP opcode, std::string _name, const std::shared_ptr<Type>& _type)
    : opcode(opcode), User(std::move(_name), _type,
        _type->getTrait() != IRCTYPE::BASIC || (_type->getTrait() == IRCTYPE::BASIC
        && toBType(_type)->getInner() != IRBTYPE::UNDEFINED
        && toBType(_type)->getInner() != IRBTYPE::VOID)
        ? ValueTrait::ORDINARY_VARIABLE : ValueTrait::VOID_INSTRUCTION) {}

void Instruction::setParent(const std::shared_ptr<BasicBlock>& p) {
    parent = p;
}

OP Instruction::getOpcode() const {
    return opcode;
}

std::shared_ptr<BasicBlock> Instruction::getParent() const {
    return parent.lock();
}

void Instruction::accept(IRVisitor& visitor) {
    visitor.visit(*this);
}

Instruction::~Instruction() = default;

}
