/**
 * @attention BB的uselist内是调用它的br，而不是它的父函数
 */

#pragma once
#ifndef GNALC_IR_BASIC_BLOCK_HPP
#define GNALC_IR_BASIC_BLOCK_HPP

#include "base.hpp"
#include "instruction.hpp"

#include <memory>
#include <set>

namespace IR {
class Function;
class IRVisitor;
/**
 * @brief BB继承自value, 其被br指令'use', 'use'了它所包含的指令
 * @note next_bb包含的BB和最后一条br指令中的相同
 */
inline void linkBB(const std::shared_ptr<BasicBlock> &prebb,
                   const std::shared_ptr<BasicBlock> &nxtbb);

class BasicBlock : public Value,
                   public std::enable_shared_from_this<BasicBlock> {
    friend void linkBB(const std::shared_ptr<BasicBlock> &prebb,
                   const std::shared_ptr<BasicBlock> &nxtbb);
    friend void unlinkBB(const std::shared_ptr<BasicBlock> &prebb,
               const std::shared_ptr<BasicBlock> &nxtbb);

    std::list<std::weak_ptr<BasicBlock>> pre_bb;   // 前驱
    std::list<std::weak_ptr<BasicBlock>> next_bb;  // 后继
    std::list<std::shared_ptr<Instruction>> insts; // 指令列表
    std::vector<std::shared_ptr<Value>> bb_params;
    std::weak_ptr<Function> parent;

public:
    using const_iterator = decltype(insts)::const_iterator;
    using iterator = decltype(insts)::iterator;

    explicit BasicBlock(std::string _name);
    BasicBlock(std::string _name,
               std::list<std::shared_ptr<Instruction>> _insts);
    BasicBlock(std::string _name, std::list<std::weak_ptr<BasicBlock>> _pre_bb,
               std::list<std::weak_ptr<BasicBlock>> _next_bb,
               std::list<std::shared_ptr<Instruction>> _insts);

    void addInst(const std::shared_ptr<Instruction> &inst);

    std::list<std::shared_ptr<BasicBlock>> getPreBB() const;
    std::list<std::shared_ptr<BasicBlock>> getNextBB() const;
    std::list<std::weak_ptr<BasicBlock>> &getRPreBB();
    std::list<std::weak_ptr<BasicBlock>> &getRNextBB();

    // usually we can use range-based for instead of these
    const std::list<std::shared_ptr<Instruction>> &getInsts() const;
    std::list<std::shared_ptr<Instruction>> &getInsts();

    void updateInstIndex() const;

    unsigned index = 0; // 使用前调用父函数的update方法！

    // No use-def check, just remove the first matched item
    bool delFirstOfInst(const std::shared_ptr<Instruction> &inst);

    // With use-def check, remove all matched.
    // The instruction must have no users.
    bool delInst(const std::shared_ptr<Instruction> &inst);

    // Delete insts and its user.
    // If pred(a) == true, pred(a->users) must be true
    template <typename Pred> bool delInstIf(Pred pred) {
        bool found = false;
        for (auto it = insts.begin(); it != insts.end();) {
            if (pred(*it)) {
                for (auto &&use : (*it)->getUseList()) {
                    Err::gassert(pred(std::dynamic_pointer_cast<Instruction>(
                                     use->getUser())),
                                 "BasicBlock::delInstIf(): Cannot delete a "
                                 "Inst without deleting its User.");
                }
                it = insts.erase(it);
                found = true;
            } else
                ++it;
        }

        Err::gassert(found, "BasicBlock::delInstIf(): Not found");
        return found;
    }

    const_iterator cbegin() const;
    const_iterator cend() const;
    iterator begin();
    iterator end();
    // ...

    void setBBParam(const std::vector<std::shared_ptr<Value>> &params);
    const std::vector<std::shared_ptr<Value>> &getBBParams() const;

    std::shared_ptr<Function> getParent() const;
    void setParent(const std::shared_ptr<Function> &_parent);

    void accept(IRVisitor &visitor) override;
    ~BasicBlock() override;

    private:
    void addPreBB(const std::shared_ptr<BasicBlock> &bb);
    void addNextBB(const std::shared_ptr<BasicBlock> &bb);
    bool delPreBB(const std::shared_ptr<BasicBlock> &bb);
    bool delNextBB(const std::shared_ptr<BasicBlock> &bb);
};

inline void linkBB(const std::shared_ptr<BasicBlock> &prebb,
                   const std::shared_ptr<BasicBlock> &nxtbb) {
    prebb->addNextBB(nxtbb);
    nxtbb->addPreBB(prebb);
}
inline void unlinkBB(const std::shared_ptr<BasicBlock> &prebb,
                   const std::shared_ptr<BasicBlock> &nxtbb) {
    bool ok = prebb->delNextBB(nxtbb);
    Err::gassert(ok);
    ok = nxtbb->delPreBB(prebb);
    Err::gassert(ok);
}
} // namespace IR

#endif