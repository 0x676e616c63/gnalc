// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

/**
 * @attention BasicBlock 的 use_list 内是调用它的 BRInst，而不是它的父函数
 */

#pragma once
#ifndef GNALC_IR_BASIC_BLOCK_HPP
#define GNALC_IR_BASIC_BLOCK_HPP

#include "base.hpp"
#include "instruction.hpp"
#include "instructions/phi.hpp"
#include "type_alias.hpp"
#include "../utils/generic_visitor.hpp"
#include "../utils/iterator.hpp"

#include <memory>
#include <variant>

namespace Parser {
class CFGBuilder;
}

namespace IR {
class IRVisitor;
class PostDomTreeAnalysis;
// We can't see Function's definition here, use `FunctionBBIter` to get around it.
using FunctionBBIter = std::list<pBlock>::iterator;

/**
 * @brief BB继承自value, 其被br指令'use', 'use'了它所包含的指令
 * @note next_bb包含的BB和最后一条br指令中的相同
 */
class BasicBlock : public Value {
    friend class Parser::CFGBuilder;
    friend class Function;
    friend class Instruction;
    friend class PostDomTreeAnalysis;
    friend void linkBB(const pBlock &prebb, const pBlock &nxtbb);

    // This should be deprecated in the future.
    // When there are multiple identical edges between two BBs, this function
    // can be error-prone.
    friend void unlinkBB(const pBlock &prebb, const pBlock &nxtbb);

    // Use the following two instead
    // Only unlink one edge
    friend void unlinkOneEdge(const pBlock &prebb, const pBlock &nxtbb);
    // Unlink all such edges
    friend size_t unlinkAllEdges(const pBlock &prebb, const pBlock &nxtbb);

    std::list<wpBlock> pre_bb;  // 前驱
    std::list<wpBlock> next_bb; // 后继
    std::list<pInst> insts;     // 指令列表
    std::list<pPhi> phi_insts;
    std::vector<pVal> bb_params;
    wpFunc parent;
    size_t index = 0;
    // Warning: BasicBlock's index is updated in an eager way,
    //          while Instructions are lazily updated for performance.
    // Delay update until Instruction's getIndex()
    bool inst_index_valid = false;

    struct BBSuccGetter {
        auto operator()(const pBlock &bb) { return bb->getNextBB(); }
    };

public:
    using iterator = decltype(insts)::iterator;
    using const_iterator = decltype(insts)::const_iterator;
    using reverse_iterator = decltype(insts)::reverse_iterator;
    using const_reverse_iterator = decltype(insts)::const_reverse_iterator;
    using phi_const_iterator = decltype(phi_insts)::const_iterator;
    using phi_iterator = decltype(phi_insts)::iterator;
    using CFGBFVisitor = Util::GenericBFVisitor<pBlock, BBSuccGetter>;
    template <Util::DFVOrder order> using CFGDFVisitor = Util::GenericDFVisitor<pBlock, BBSuccGetter, order>;

    auto getBFVisitor() { return CFGBFVisitor(as<BasicBlock>()); }

    template <Util::DFVOrder order = Util::DFVOrder::PreOrder> auto getDFVisitor() {
        return CFGDFVisitor<order>(as<BasicBlock>());
    }

    explicit BasicBlock(std::string _name);
    BasicBlock(std::string _name, std::list<pInst> _insts);
    BasicBlock(std::string _name, std::list<wpBlock> _pre_bb, std::list<wpBlock> _next_bb, std::list<pInst> _insts);

    void addInst(iterator it, const pInst &inst);
    void addInst(size_t index, const pInst &inst);
    void addInst(const pInst &inst);
    void addInstAfterPhi(const pInst &inst);
    void addInstAfterAlloca(const pInst &inst);
    void addPhiInst(const pPhi &node); // 插入到phi_insts

    void addInsts(iterator it, const std::vector<pInst> &insts);
    void addInsts(const std::vector<pInst> &insts);

    // Returns a proper insert point at the end of this block.
    // This preserves the consecutive CMP-BRInst pattern.
    BBInstIter getEndInsertPoint() const;
    // Add instructions right before the terminator. (do not preserve consecutive CMP-BRInst)
    void addInstBeforeTerminator(const pInst &inst);

    // Usually we use `preds()` and `succs()` instead of them
    std::list<pBlock> getPreBB() const;
    std::list<pBlock> getNextBB() const;

    size_t getNumPreds() const;
    size_t getNumSuccs() const;

    // Usually we use range-based for instead of these
    const std::list<pInst> &getInsts() const;
    const std::list<pPhi> &getPhiInsts() const;

    // Returns a temporary object.
    // Deleting/Adding Instruction while iterating it is safe.
    // Some pass rely on this. (like ADCE).
    std::list<pInst> getAllInsts() const;
    unsigned getPhiCount() const;

    size_t getIndex() const;

    FunctionBBIter getIter() const;

    // No use-def check, just remove the first matched item
    // PHI Instruction is not included!
    bool delFirstOfInst(const pInst &inst);
    // No use-def check, just remove the first matched item
    bool delFirstOfPhiInst(const pPhi &inst);

    enum class DEL_MODE { ALL, PHI, NON_PHI };
    // With use-def check, remove all matched.
    // The instruction must have no users in any basic block.
    // Note that it can have users that have no parent.
    bool delInst(const pInst &inst, DEL_MODE mode = DEL_MODE::ALL);

    // Delete instructions that satisfied: `pred(inst) == true`
    // Requires the target instruction have no users than expiring users.
    // "expiring users": users that are being deleted or have no parent.
    // (inst.getParent() == nullptr || pred(inst->getUsers()) == true)
    // In other word, If pred(a) == true, pred(a->users) must be true
    template <typename Pred> bool delInstIf(Pred pred, const DEL_MODE mode = DEL_MODE::ALL) {
        bool found = false;
        if (mode != DEL_MODE::NON_PHI) {
            for (auto it = phi_insts.begin(); it != phi_insts.end();) {
                if (pred(*it)) {
                    for (const auto &user : (*it)->inst_users()) {
                        Err::gassert(user->getParent() == nullptr || pred(user),
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
                    for (const auto &user : (*it)->inst_users()) {
                        Err::gassert(user->getParent() == nullptr || pred(user),
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
            inst_index_valid = false;
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
    auto phis() const { return Util::make_iterator_range(phi_begin(), phi_end()); }

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
        using value_type = pInst;
        using pointer = pInst *;
        using reference = pInst &;
        using iterator_category = std::forward_iterator_tag;

        explicit AllInstIterator(PhiIterT iter, PhiIterT phi_end, InstIter inst_begin)
            : iter(PhiIter{iter, phi_end, inst_begin}) {}

        explicit AllInstIterator(InstIter inst_iter) : iter(inst_iter) {}

        AllInstIterator &operator++() {
            if (std::holds_alternative<PhiIter>(iter)) {
                auto &phi_iter = std::get<PhiIter>(iter);
                if (std::next(phi_iter.iter) != phi_iter.phi_end) {
                    ++phi_iter.iter;
                    return *this;
                }
                iter = phi_iter.inst_begin;
                return *this;
            }
            auto &inst_iter = std::get<InstIter>(iter);
            ++inst_iter;
            return *this;
        }

        AllInstIterator operator++(int) {
            auto ret = AllInstIterator{*this};
            if (std::holds_alternative<PhiIter>(iter)) {
                auto &phi_iter = std::get<PhiIter>(iter);
                if (std::next(phi_iter.iter) != phi_iter.phi_end) {
                    ++phi_iter.iter;
                    return ret;
                }
                iter = phi_iter.inst_begin;
                return *this;
            }
            auto &inst_iter = std::get<InstIter>(iter);
            ++inst_iter;
            return ret;
        }

        bool operator==(AllInstIterator other) const { return iter == other.iter; }
        bool operator!=(AllInstIterator other) const { return !(*this == other); }
        pInst operator*() const {
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
    AllInstIterator all_inst_end() const { return AllInstIterator{insts.end()}; }

    auto all_insts() const { return Util::make_iterator_range(all_inst_begin(), all_inst_end()); }

    void setBBParam(const std::vector<pVal> &params);
    const std::vector<pVal> &getBBParams() const;

    pFunc getParent() const;
    void setParent(const pFunc &_parent);

    pInst getTerminator() const;
    pBr getBRInst() const;
    pRet getRETInst() const;

    void accept(IRVisitor &visitor) override;
    ~BasicBlock() override;

    size_t getAllInstCount() const;

    class BasicBlockIterator {
    private:
        using InnerIterT = decltype(pre_bb)::const_iterator;
        InnerIterT iter;

    public:
        using difference_type = InnerIterT::difference_type;
        using value_type = pBlock;
        using pointer = pBlock *;
        using reference = pBlock &;
        using iterator_category = InnerIterT::iterator_category;

        explicit BasicBlockIterator(InnerIterT iter_) : iter(iter_) {}

        BasicBlockIterator &operator++() {
            ++iter;
            return *this;
        }
        BasicBlockIterator operator++(int) { return BasicBlockIterator{iter++}; }

        BasicBlockIterator &operator--() {
            --iter;
            return *this;
        }
        BasicBlockIterator operator--(int) { return BasicBlockIterator{iter--}; }

        bool operator==(BasicBlockIterator other) const { return iter == other.iter; }
        bool operator!=(BasicBlockIterator other) const { return iter != other.iter; }
        pBlock operator*() const { return iter->lock(); }
    };

    BasicBlockIterator pred_begin() const { return BasicBlockIterator{pre_bb.begin()}; }
    BasicBlockIterator pred_end() const { return BasicBlockIterator{pre_bb.end()}; }
    BasicBlockIterator succ_begin() const { return BasicBlockIterator{next_bb.begin()}; }
    BasicBlockIterator succ_end() const { return BasicBlockIterator{next_bb.end()}; }

    auto preds() const { return Util::make_iterator_range(pred_begin(), pred_end()); }

    auto succs() const { return Util::make_iterator_range(succ_begin(), succ_end()); }

private:
    pVal cloneImpl() const override;
    void addPreBB(const pBlock &bb);
    void addNextBB(const pBlock &bb);
    bool delPreBB(const pBlock &bb);
    bool delNextBB(const pBlock &bb);
    void updateInstIndex();
};
} // namespace IR

#endif