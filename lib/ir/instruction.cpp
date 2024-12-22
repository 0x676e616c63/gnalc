#include <utility>

#include "../../include/ir/instruction.hpp"

namespace IR {

Instruction::Instruction(OP opcode, std::string _name, std::shared_ptr<Type> _type)
    : opcode(opcode), User(std::move(_name), std::move(_type)) {}

void Instruction::setParent(const std::shared_ptr<BasicBlock>& p) {
    parent = p;
}

OP Instruction::getOpcode() const {
    return opcode;
}

std::shared_ptr<BasicBlock> Instruction::getParent() const {
    return parent.lock();
}

Instruction::~Instruction() = default;

}