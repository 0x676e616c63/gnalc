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
    void addPhiOper(const std::shared_ptr<Value> &val, const std::shared_ptr<BasicBlock> &blk);
    std::vector<PhiOper> getPhiOpers() const;

    bool replaceBlock(const std::shared_ptr<BasicBlock> &before,
        const std::shared_ptr<BasicBlock> &after);

    bool delPhiOper(const std::shared_ptr<BasicBlock> &);

    void accept(IRVisitor &visitor) override;
};

} // namespace IR

#endif