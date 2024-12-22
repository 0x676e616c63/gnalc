#include <utility>

#include "../../include/ir/instruction.hpp"

namespace IR {

Instruction::Instruction(OP opcode, std::string _name, IRTYPE _type)
    : opcode(opcode), User(std::move(_name), _type) {}

void Instruction::setParent(BasicBlock* p) {
    parent = p;
}

OP Instruction::getOpcode() const {
    return opcode;
}

BasicBlock* Instruction::getParent() const {
    return parent;
}

Instruction::~Instruction() = default;

}