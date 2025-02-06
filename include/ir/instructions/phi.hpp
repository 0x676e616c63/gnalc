/**
 * @brief phi
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_PHI_HPP
#define GNALC_IR_INSTRUCTIONS_PHI_HPP

#include "../instruction.hpp"

namespace IR {
struct PhiOperand;

// PHI_INST --USE-> PHI_OPER --USE-> {val, blk}
// %result = phi <type> [ <val1>, <block1> ], [ <val2>, <block2> ], ...
class PHIInst : public Instruction {
public:
    // [ <val1>, <block1> ]
    struct PhiOperand : public User {
        PhiOperand() = delete;
        PhiOperand(const std::shared_ptr<Value> &_value,
                   const std::shared_ptr<BasicBlock> &_block);
        std::shared_ptr<Value> getValue() const;
        std::shared_ptr<BasicBlock> getBlock() const;

        std::shared_ptr<PHIInst> getPhi() const;
    };
    PHIInst() = delete;
    PHIInst(NameRef name, const std::shared_ptr<Type> &_type);
    PHIInst(NameRef name, const std::shared_ptr<Type> &_type,
        const std::vector<std::shared_ptr<PhiOperand>> &_operands);

    std::shared_ptr<Value>
    getValueForBlock(const std::shared_ptr<BasicBlock> &block) const;
    void addPhiOper(const std::shared_ptr<PhiOperand> &_operands);
    std::vector<std::shared_ptr<PhiOperand>> getPhiOpers() const;

    void delPhiOper(const std::shared_ptr<BasicBlock> &);

    void accept(IRVisitor &visitor) override;
};

} // namespace IR

#endif