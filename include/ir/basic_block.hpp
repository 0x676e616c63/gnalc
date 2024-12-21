/**
 * @attention BB的uselist内是调用它的br，而不是它的父函数
 */

#pragma once
#ifndef GNALC_IR_BASIC_BLOCK_HPP
#define GNALC_IR_BASIC_BLOCK_HPP

#include "base.hpp"

#include <memory>

namespace IR {
    class Instruction;
    class IRVisitor;
/**
 * @brief BB继承自value, 其被br指令'use', 'use'了它所包含的指令
 * @note next_bb包含的BB和最后一条br指令中的相同
 */
class BasicBlock : public Value {
    std::list<std::weak_ptr<BasicBlock>> pre_bb; // 前驱
    std::list<std::weak_ptr<BasicBlock>> next_bb; // 后继
    std::list<std::shared_ptr<Instruction>> insts; // 指令列表
    std::list<std::shared_ptr<Value>> livein;
    std::list<std::shared_ptr<Value>> liveout;
public:
    BasicBlock(std::string _name);
    BasicBlock(std::string _name, std::list<std::shared_ptr<Instruction>> _insts);
    BasicBlock(std::string _name, std::list<std::weak_ptr<BasicBlock>> _pre_bb, std::list<std::weak_ptr<BasicBlock>> _next_bb, std::list<std::shared_ptr<Instruction>> _insts);

    void addPreBB(const std::shared_ptr<BasicBlock>& bb);
    void addNextBB(const std::shared_ptr<BasicBlock>& bb);
    void addInst(const std::shared_ptr<Instruction>& inst);
    auto getPreBB() const;
    auto getNextBB() const;
    const auto& getInsts() const;
    auto& getRPreBB();
    auto& getRNextBB();
    auto& getInsts();
    // ...

    auto& getLiveIn();
    auto& getLiveOut();

    void accept(IRVisitor& visitor) override;
    ~BasicBlock() override;
};

}

#endif