/**
 * @brief 各种instruction的基类
 */

#pragma once
#include "base.hpp"
#include "basic_block.hpp"

namespace IR {

// opcode
class Instruction : public User {
private:
    int opcode; // 后续修改
    BasicBlock* parent;

public:
    Instruction(int opcode, NameParam name = "") : User(VOID, name), opcode(opcode) {}

    int getOpcode() { return opcode; }
    void setParent(BasicBlock* p) {  parent = p; } // set parent block
    BasicBlock* getParent() {  return parent; }
};

}