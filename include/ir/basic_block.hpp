/**
 * @attention BB的uselist内是调用它的br，而不是它的父函数
 */

#pragma once
#ifndef GNALC_IR_BASIC_BLOCK_HPP
#define GNALC_IR_BASIC_BLOCK_HPP

#include "base.hpp"
#include "instruction.hpp"

namespace IR {

/**
 * @brief BB继承自value, 其被br指令'use', 'use'了它所包含的指令
 * @note next_bb包含的BB和最后一条br指令中的相同
 */
class BasicBlock : public Value {
    std::list<BasicBlock*> pre_bb; // 前驱
    std::list<BasicBlock*> next_bb; // 后继
    std::list<Instruction*> insts; // 指令列表
public:
    BasicBlock(std::string _name);
    BasicBlock(std::string _name, std::list<Instruction*> _insts);
    BasicBlock(std::string _name, std::list<BasicBlock*> _pre_bb, std::list<BasicBlock*> _next_bb, std::list<Instruction*> _insts);

    void addPreBB(BasicBlock* bb);
    void addNextBB(BasicBlock* bb);
    void addInst(Instruction* inst);
    std::list<BasicBlock*>& getPreBB();
    std::list<BasicBlock*>& getNextBB();
    std::list<Instruction*>& getInsts();
    // ...
};

}

#endif