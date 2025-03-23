/**
 * @brief phi
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_PHI_HPP
#define GNALC_IR_INSTRUCTIONS_PHI_HPP

#include "../instruction.hpp"
#include "../type_alias.hpp"

namespace IR {
// PHI_INST --USE-> {val, blk}
// %result = phi <type> [ <val1>, <block1> ], [ <val2>, <block2> ], ...
class PHIInst : public Instruction {
public:
    // [ <val1>, <block1> ]
    // 只有getPhiOpers会构造
    struct PhiOper {
        pVal value;
        pBlock block;
        PhiOper(const pVal &_value, const pBlock &_block) : value(_value), block(_block) {}
    };
    PHIInst() = delete;
    PHIInst(NameRef name, const pType &_type);

    pVal getValueForBlock(const pBlock &block) const;
    pBlock getBlockForValue(const std::shared_ptr<Use> &use) const;

    void addPhiOper(const pVal &val, const pBlock &blk);

    std::vector<PhiOper> getPhiOpers() const;

    bool delPhiOperByBlock(const pBlock &);

    bool hasBlock(const pBlock &);

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override {
        auto cloned = std::make_shared<PHIInst>(getName(), getType());
        auto opers = getPhiOpers();
        for (const auto &[val, bb] : opers)
            cloned->addPhiOper(val, bb);
        return cloned;
    }
};

} // namespace IR

#endif