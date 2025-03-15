/**
 * @brief phi
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_PHI_HPP
#define GNALC_IR_INSTRUCTIONS_PHI_HPP

#include "../instruction.hpp"

namespace IR {
// PHI_INST --USE-> {val, blk}
// %result = phi <type> [ <val1>, <block1> ], [ <val2>, <block2> ], ...
class PHIInst : public Instruction {
public:
    // [ <val1>, <block1> ]
    // 只有getPhiOpers会构造
    struct PhiOper {
        std::shared_ptr<Value> value;
        std::shared_ptr<BasicBlock> block;
        PhiOper(const std::shared_ptr<Value> &_value, const std::shared_ptr<BasicBlock> &_block)
            : value(_value), block(_block) {}
    };
    PHIInst() = delete;
    PHIInst(NameRef name, const std::shared_ptr<Type> &_type);

    std::shared_ptr<Value> getValueForBlock(const std::shared_ptr<BasicBlock> &block) const;
    std::shared_ptr<BasicBlock> getBlockForValue(const std::shared_ptr<Use> &use) const;

    void addPhiOper(const std::shared_ptr<Value> &val, const std::shared_ptr<BasicBlock> &blk);

    std::vector<PhiOper> getPhiOpers() const;

    bool delPhiOperByBlock(const std::shared_ptr<BasicBlock> &);

    bool hasBlock(const std::shared_ptr<BasicBlock> &);

    void accept(IRVisitor &visitor) override;

private:
    std::shared_ptr<Value> cloneImpl() const override {
        auto cloned = std::make_shared<PHIInst>(getName(), getType());
        auto opers = getPhiOpers();
        for (const auto& [val, bb] : opers)
            cloned->addPhiOper(val, bb);
        return cloned;
    }
};

} // namespace IR

#endif