/**
 * @attention BB的uselist内是调用它的br，而不是它的父函数
 */

#pragma once
#ifndef GNALC_IR_BASIC_BLOCK_HPP
#define GNALC_IR_BASIC_BLOCK_HPP

#include "base.hpp"
#include "instruction.hpp"
#include "instructions/phi.hpp"
#include "../utils/iterator.hpp"

#include <memory>
#include <set>
#include <variant>

namespace Parser {
class CFGBuilder;
}

namespace IR {
class Function;
class IRVisitor;
class PostDomTreeAnalysis;
class BRInst;
class RETInst;

// We can't see Function's definition here, use `FunctionBBIter` to get around it.
using FunctionBBIter = std::list<std::shared_ptr<BasicBlock>>::iterator;

/**
 * @brief BB继承自value, 其被br指令'use', 'use'了它所包含的指令
 * @note next_bb包含的BB和最后一条br指令中的相同
 */
class BasicBlock : public Value,
                   public std::enable_shared_from_this<BasicBlock> {
    friend class Parser::CFGBuilder;
    friend class Function;
    friend class PostDomTreeAnalysis;
    friend void linkBB(const std::shared_ptr<BasicBlock> &prebb,
                       const std::shared_ptr<BasicBlock> &nxtbb);
    friend void unlinkBB(const std::shared_ptr<BasicBlock> &prebb,
                         const std::shared_ptr<BasicBlock> &nxtbb);

    std::list<std::weak_ptr<BasicBlock>> pre_bb;   // 前驱
    std::list<std::weak_ptr<BasicBlock>> next_bb;  // 后继
    std::list<std::shared_ptr<Instruction>> insts; // 指令列表
    std::list<std::shared_ptr<PHIInst>> phi_insts;
    std::vector<std::shared_ptr<Value>> bb_params;
    std::weak_ptr<Function> parent;
    size_t index = 0;

public:
    using iterator = decltype(insts)::iterator;
    using const_iterator = decltype(insts)::const_iterator;
    using reverse_iterator = decltype(insts)::reverse_iterator;
    using const_reverse_iterator = decltype(insts)::const_reverse_iterator;
    using phi_const_iterator = decltype(phi_insts)::const_iterator;
    using phi_iterator = decltype(phi_insts)::iterator;

    explicit BasicBlock(std::string _name);
    BasicBlock(std::string _name,
               std::list<std::shared_ptr<Instruction>> _insts);
    BasicBlock(std::string _name, std::list<std::weak_ptr<BasicBlock>> _pre_bb,
               std::list<std::weak_ptr<BasicBlock>> _next_bb,
               std::list<std::shared_ptr<Instruction>> _insts);

    void addInst(iterator it, const std::shared_ptr<Instruction>& inst);
    void addInst(size_t index, const std::shared_ptr<Instruction> &inst);
    void addInst(const std::shared_ptr<Instruction> &inst);
    void addInstAfterPhi(const std::shared_ptr<Instruction> &inst);
    void addInstBeforeTerminator(const std::shared_ptr<Instruction> &inst);
    void addPhiInst(const std::shared_ptr<PHIInst> &node); // 插入到phi_insts

    // Usually we use `preds()` and `succs()` instead of them
    std::list<std::shared_ptr<BasicBlock>> getPreBB() const;
    std::list<std::shared_ptr<BasicBlock>> getNextBB() const;

    size_t getNumPreds() const;
    size_t getNumSuccs() const;

    // Usually we use range-based for instead of these
    const std::list<std::shared_ptr<Instruction>> &getInsts() const;
    const std::list<std::shared_ptr<PHIInst>> &getPhiInsts() const;

    // Returns a temporary object.
    // Deleting/Adding Instruction while iterating it is safe.
    // Some pass rely on this. (like ADCE).
    std::list<std::shared_ptr<Instruction>> getAllInsts() const;
    unsigned getPhiCount() const;

    size_t getIndex() const;

    FunctionBBIter getIter() const;

    // No use-def check, just remove the first matched item
    // PHI Instruction is not included!
    bool delFirstOfInst(const std::shared_ptr<Instruction> &inst);
    // No use-def check, just remove the first matched item
    bool delFirstOfPhiInst(const std::shared_ptr<PHIInst> &inst);

    enum class DEL_MODE {
        ALL,
        PHI,
        NON_PHI
    };
    // With use-def check, remove all matched.
    // The instruction must have no users.
    bool delInst(const std::shared_ptr<Instruction> &inst, DEL_MODE mode = DEL_MODE::ALL);

    // Delete instructions that satisfied: `pred(inst) == true`
    // Requires the target instruction have no users than expiring users.
    // "expiring users": users that are being deleted. (pred(inst->getUsers()) == true)
    // In other word, If pred(a) == true, pred(a->users) must be true
    template <typename Pred>
    bool delInstIf(Pred pred, const DEL_MODE mode = DEL_MODE::ALL) {
        bool found = false;
        if (mode != DEL_MODE::NON_PHI) {
            for (auto it = phi_insts.begin(); it != phi_insts.end();) {
                if (pred(*it)) {
                    for (const auto& user : (*it)->inst_users()) {
                        Err::gassert(pred(user),
                                     "BasicBlock::delInstIf(): Cannot delete a Phi without deleting its User.");
                    }
                    (*it)->setParent(nullptr);
                    it = phi_insts.erase(it);
                    found = true;
                } else
                    ++it;
            }
        }
        if (mode != DEL_MODE::PHI) {
            for (auto it = insts.begin(); it != insts.end();) {
                if (pred(*it)) {
                    for (const auto& user : (*it)->inst_users()) {
                        Err::gassert(pred(user),
                                    "BasicBlock::delInstIf(): Cannot delete a Inst without deleting its User.");
                    }
                    (*it)->setParent(nullptr);
                    it = insts.erase(it);
                    found = true;
                } else
                    ++it;
            }
        }
        if (found)
            updateInstIndex();
        return found;
    }

    const_iterator begin() const;
    const_iterator end() const;
    iterator begin();
    iterator end();
    const_iterator cbegin() const;
    const_iterator cend() const;

    const_reverse_iterator rbegin() const;
    const_reverse_iterator rend() const;
    reverse_iterator rbegin();
    reverse_iterator rend();
    const_reverse_iterator crbegin() const;
    const_reverse_iterator crend() const;

    phi_const_iterator phi_begin() const;
    phi_const_iterator phi_end() const;
    phi_iterator phi_begin();
    phi_iterator phi_end();
    phi_const_iterator phi_cbegin() const;
    phi_const_iterator phi_cend() const;
    auto phis() const {
        return Util::make_iterator_range(phi_begin(), phi_end());
    }

    // (phi, insts)
    class AllInstIterator {
    private:
        using PhiIterT = decltype(phi_insts)::const_iterator;
        using InstIter = decltype(insts)::const_iterator;
        struct PhiIter {
            PhiIterT iter;
            PhiIterT phi_end;
            InstIter inst_begin;
            bool operator==(const PhiIter &other) const {
                return iter == other.iter && phi_end == other.phi_end && inst_begin == other.inst_begin;
            }
        };
        std::variant<PhiIter, InstIter> iter;

    public:
        using difference_type = PhiIterT::difference_type;
        using value_type = std::shared_ptr<Instruction>;
        using pointer = std::shared_ptr<Instruction> *;
        using reference = std::shared_ptr<Instruction> &;
        using iterator_category = std::forward_iterator_tag;

        explicit AllInstIterator(PhiIterT iter, PhiIterT phi_end, InstIter inst_begin)
            : iter(PhiIter{iter, phi_end, inst_begin}) {}

        explicit AllInstIterator(InstIter inst_iter)
            : iter(inst_iter) {}


        AllInstIterator &operator++() {
            if (std::holds_alternative<PhiIter>(iter)) {
                auto& phi_iter = std::get<PhiIter>(iter);
                if (std::next(phi_iter.iter) != phi_iter.phi_end) {
                    ++phi_iter.iter;
                    return *this;
                }
                iter = phi_iter.inst_begin;
                return *this;
            }
            auto& inst_iter = std::get<InstIter>(iter);
            ++inst_iter;
            return *this;
        }

        AllInstIterator operator++(int) {
            auto ret = AllInstIterator{*this};
            if (std::holds_alternative<PhiIter>(iter)) {
                auto& phi_iter = std::get<PhiIter>(iter);
                if (std::next(phi_iter.iter) != phi_iter.phi_end) {
                    ++phi_iter.iter;
                    return ret;
                }
                iter = phi_iter.inst_begin;
                return *this;
            }
            auto& inst_iter = std::get<InstIter>(iter);
            ++inst_iter;
            return ret;
        }

        bool operator==(AllInstIterator other) const{ return iter == other.iter; }
        bool operator!=(AllInstIterator other) const { return !(*this == other); }
        std::shared_ptr<Instruction> operator*() const {
            if (std::holds_alternative<PhiIter>(iter))
                return *std::get<PhiIter>(iter).iter;
            return *std::get<InstIter>(iter);
        }
    };

    AllInstIterator all_inst_begin() const {
        if (!phi_insts.empty())
            return AllInstIterator{phi_insts.begin(), phi_insts.end(), insts.begin()};
        return AllInstIterator{insts.begin()};
    }
    AllInstIterator all_inst_end() const {
        return AllInstIterator{insts.end()};
    }

    auto all_insts() const {
        return Util::make_iterator_range(all_inst_begin(), all_inst_end());
    }

    void setBBParam(const std::vector<std::shared_ptr<Value>> &params);
    const std::vector<std::shared_ptr<Value>> &getBBParams() const;

    std::shared_ptr<Function> getParent() const;
    void setParent(const std::shared_ptr<Function> &_parent);

    std::shared_ptr<Instruction> getTerminator() const;
    std::shared_ptr<BRInst> getBRInst() const;
    std::shared_ptr<RETInst> getRETInst() const;

    void accept(IRVisitor &visitor) override;
    ~BasicBlock() override;

    size_t getAllInstCount() const;

    class BasicBlockIterator {
    private:
        using InnerIterT = decltype(pre_bb)::const_iterator;
        InnerIterT iter;

    public:
        using difference_type = InnerIterT::difference_type;
        using value_type = std::shared_ptr<BasicBlock>;
        using pointer = std::shared_ptr<BasicBlock> *;
        using reference = std::shared_ptr<BasicBlock> &;
        using iterator_category = InnerIterT::iterator_category;

        explicit BasicBlockIterator(InnerIterT iter_) : iter(iter_) {}

        BasicBlockIterator &operator++() {
            ++iter;
            return *this;
        }
        BasicBlockIterator operator++(int) {
            return BasicBlockIterator{iter++};
        }

        BasicBlockIterator &operator--() {
            --iter;
            return *this;
        }
        BasicBlockIterator operator--(int) {
            return BasicBlockIterator{iter--};
        }

        bool operator==(BasicBlockIterator other) const { return iter == other.iter; }
        bool operator!=(BasicBlockIterator other) const { return iter != other.iter; }
        std::shared_ptr<BasicBlock> operator*() const {
            return iter->lock();
        }
    };

    BasicBlockIterator pred_begin() const {
        return BasicBlockIterator{pre_bb.begin()};
    }
    BasicBlockIterator pred_end() const {
        return BasicBlockIterator{pre_bb.end()};
    }
    BasicBlockIterator succ_begin() const {
        return BasicBlockIterator{next_bb.begin()};
    }
    BasicBlockIterator succ_end() const {
        return BasicBlockIterator{next_bb.end()};
    }

    auto preds() const {
        return Util::make_iterator_range(pred_begin(), pred_end());
    }

    auto succs() const {
        return Util::make_iterator_range(succ_begin(), succ_end());
    }

private:
    std::shared_ptr<Value> cloneImpl() const override;
    void addPreBB(const std::shared_ptr<BasicBlock> &bb);
    void addNextBB(const std::shared_ptr<BasicBlock> &bb);
    bool delPreBB(const std::shared_ptr<BasicBlock> &bb);
    bool delNextBB(const std::shared_ptr<BasicBlock> &bb);
    void updateInstIndex() const;
};
} // namespace IR

#endif