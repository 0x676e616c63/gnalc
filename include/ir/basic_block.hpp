/**
 * @attention BB的uselist内是调用它的br，而不是它的父函数
 */

#pragma once
#ifndef GNALC_IR_BASIC_BLOCK_HPP
#define GNALC_IR_BASIC_BLOCK_HPP

#include "base.hpp"

#include <memory>
#include <set>

namespace IR {
    class Instruction;
    class IRVisitor;
/**
 * @brief BB继承自value, 其被br指令'use', 'use'了它所包含的指令
 * @note next_bb包含的BB和最后一条br指令中的相同
 */

class BasicBlock : public Value, public std::enable_shared_from_this<BasicBlock> {
    std::list<std::weak_ptr<BasicBlock>> pre_bb; // 前驱
    std::list<std::weak_ptr<BasicBlock>> next_bb; // 后继
    std::list<std::shared_ptr<Instruction>> insts; // 指令列表
    std::vector<std::shared_ptr<Value>> bb_params;
public:
    using const_iterator = decltype(insts)::const_iterator;
    using iterator = decltype(insts)::iterator;

    explicit BasicBlock(std::string _name);
    BasicBlock(std::string _name, std::list<std::shared_ptr<Instruction>> _insts);
    BasicBlock(std::string _name, std::list<std::weak_ptr<BasicBlock>> _pre_bb, std::list<std::weak_ptr<BasicBlock>> _next_bb, std::list<std::shared_ptr<Instruction>> _insts);

    void addPreBB(const std::shared_ptr<BasicBlock>& bb);
    void addNextBB(const std::shared_ptr<BasicBlock>& bb);
    void addInst(const std::shared_ptr<Instruction>& inst);

    std::list<std::shared_ptr<BasicBlock>> getPreBB() const;
    std::list<std::shared_ptr<BasicBlock>> getNextBB() const;
    std::list<std::weak_ptr<BasicBlock>>& getRPreBB();
    std::list<std::weak_ptr<BasicBlock>>& getRNextBB();

    // usually we can use range-based for instead of these
    const std::list<std::shared_ptr<Instruction>>& getInsts() const;
    std::list<std::shared_ptr<Instruction>>& getInsts();

    const_iterator cbegin() const;
    const_iterator cend() const;
    iterator begin();
    iterator end();
    // ...

    void setBBParam(const std::vector<std::shared_ptr<Value>> &params);
    const std::vector<std::shared_ptr<Value>>& getBBParams() const;

    void accept(IRVisitor& visitor) override;
    ~BasicBlock() override;
};

inline void linkBB(const std::shared_ptr<BasicBlock>& prebb, const std::shared_ptr<BasicBlock>& nxtbb) {
    prebb->addNextBB(nxtbb);
    nxtbb->addPreBB(prebb);
}

}

#endif