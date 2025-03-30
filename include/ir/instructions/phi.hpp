/**
 * @brief phi
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_PHI_HPP
#define GNALC_IR_INSTRUCTIONS_PHI_HPP

#include <utility>

#include "../instruction.hpp"
#include "../type_alias.hpp"

namespace IR {
// PHI_INST --USE-> {val, blk}
// %result = phi <type> [ <val1>, <block1> ], [ <val2>, <block2> ], ...
class PHIInst : public Instruction {
public:
    // [ <val1>, <block1> ]
    // 只有 getPhiOpers, PhiOperIterator::operator* 会构造
    struct PhiOper {
        pVal value;
        pBlock block;
        PhiOper(pVal _value, pBlock _block) : value(std::move(_value)), block(std::move(_block)) {}
    };

    class PhiOperIterator {
    private:
        using InnerIterT = OperandIterator;
        InnerIterT iter;

    public:
        using difference_type = InnerIterT::difference_type;
        using value_type = PhiOper;
        using pointer = PhiOper*;
        using reference = PhiOper&;
        using iterator_category = InnerIterT::iterator_category;

        explicit PhiOperIterator(InnerIterT iter_);

        PhiOperIterator &operator++();
        PhiOperIterator operator++(int);
        PhiOperIterator &operator--();
        PhiOperIterator operator--(int);

        bool operator==(PhiOperIterator other) const;
        bool operator!=(PhiOperIterator other) const;

        PhiOper operator*() const;
    };

    auto incoming_begin() const {
        return PhiOperIterator{ operand_begin() };
    }

    auto incoming_end() const {
        return PhiOperIterator{ operand_end() };
    }

    auto incomings() const {
        return Util::make_iterator_range(incoming_begin(), incoming_end());
    }

    PHIInst() = delete;
    PHIInst(NameRef name, const pType &_type);

    pVal getValueForBlock(const pBlock &block) const;
    pBlock getBlockForValue(Use* use) const;

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