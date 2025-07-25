// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_FUNCTION_HPP
#define GNALC_IR_FUNCTION_HPP

#include "base.hpp"
#include "basic_block.hpp"
#include "constant_pool.hpp"
#include "utils/generic_visitor.hpp"

#include <memory>
#include <set>
#include <utility>
#include <vector>

namespace SIR {
struct Visitor;
struct ContextVisitor;
}
namespace IR {
enum class FuncAttr {
    // User defined functions
    NotBuiltin,

    // Main function
    isProgramEntry,

    // Typically this is a main function
    ExecuteExactlyOnce,

    // Sylib
    isSylib,

    // Width
    PromoteFromChar,
    TruncateToChar,

    // Intrinsic
    isIntrinsic,
    isMemsetIntrinsic,
    isMemcpyIntrinsic,
    isSIMDIntrinsic,

    isLoweredIntrinsic,

    // Only Builtin Functions
    // For user-defined functions, use AliasAnalysis instead.
    builtinMemReadOnly,
    builtinMemWriteOnly,
    builtinMemReadWrite,

    // Loop Parallel
    isRuntime,
    ParallelEntry,
    ParallelBody,
    isAtomicAddI32,
    isAtomicAddF32,
};
class FunctionDecl : public Value {
private:
    std::unordered_set<FuncAttr> func_attrs;
    Module *parent{};

public:
    FunctionDecl(std::string name_, std::vector<pType> params, pType ret_type, bool is_va_arg_,
                 std::unordered_set<FuncAttr> attrs = {});

    void accept(IRVisitor &visitor) override;

    bool isSylib() const;
    bool isIntrinsic() const;

    bool hasAttr(FuncAttr attr) const;
    void addAttr(FuncAttr attr);
    const std::unordered_set<FuncAttr> &getAttrs() const;

    void setParent(Module *module);
    Module *getParent() const;

    bool isRecursive() const;

    ~FunctionDecl() override;
};

// FormalParam shouldn't contain a parent.
// If really need it, update CFGBuilder to move them correctly from LinearFunction to Function.
class FormalParam : public Value {
    size_t index;

public:
    explicit FormalParam(std::string name, pType ty, size_t index_)
        : Value(std::move(name), std::move(ty), ValueTrait::FORMAL_PARAMETER), index(index_) {}

    size_t getIndex() const { return index; }
    void setIndex(size_t index_) { index = index_; }

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override { return std::make_shared<FormalParam>(getName(), getType(), index); }
};

class CFGBuilder;
class Function : public FunctionDecl {
    friend class CFGBuilder;

private:
    std::vector<pFormalParam> params;
    std::list<pBlock> blks;
    ConstantPool *constant_pool;

    // 后面需要再说
    // int vreg_idx = 0;
public:
    using iterator = decltype(blks)::iterator;
    using const_iterator = decltype(blks)::const_iterator;
    using reverse_iterator = decltype(blks)::reverse_iterator;
    using const_reverse_iterator = decltype(blks)::const_reverse_iterator;

    Function(std::string name_, const std::vector<pFormalParam> &params, pType ret_type, ConstantPool *pool,
             std::unordered_set<FuncAttr> attrs = {});

    void addBlock(iterator it, pBlock blk);
    void addBlock(size_t index, pBlock blk);
    void addBlock(pBlock blk);

    // Add the given block as the entry block
    // Caller should take care of the CFG.
    void addBlockAsEntry(const pBlock &blk);

    // No check. Only deletes the first matched
    bool delFirstOfBlock(const pBlock &blk);

    // Delete a Block
    // Requires the target block have no predecessors or successors
    bool delBlock(const pBlock &blk);

    // Delete blocks that satisfied: `pred(block) == true`
    // Requires the target block have no predecessors or successors
    // In other word, If pred(a) == true, pred(a->user->getPre/NextBB()) must be true
    template <typename Pred> bool delBlockIf(Pred pred) {
        // Do check first because after erasing the predecessors might get expired.
        for (const auto &bb : blks) {
            if (pred(bb)) {
                for (const auto &prebb : bb->preds()) {
                    Err::gassert(pred(prebb), "Cannot delete a block that have predecessors");
                }
                for (const auto &nextbb : bb->succs()) {
                    Err::gassert(pred(nextbb), "Cannot delete a block that have successors");
                }
            }
        }

        bool found = false;
        for (auto it = blks.begin(); it != blks.end();) {
            if (pred(*it)) {
                (*it)->setParent(nullptr);
                it = blks.erase(it);
                found = true;
            } else
                ++it;
        }
        if (found)
            updateBBIndex();
        return found;
    }

    const std::vector<pFormalParam> &getParams() const;

    // usually we can use range-based for instead of this
    const std::list<pBlock> &getBlocks() const;

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

    ConstantPool &getConstantPool();

    template <typename T> auto getConst(T &&val) const { return constant_pool->getConst(std::forward<T>(val)); }
    pVal getZero(const pType &type) const { return constant_pool->getZero(type); }
    pVal getInteger(int64_t i, IRBTYPE type) const { return constant_pool->getInteger(i, type); }
    pVal getInteger(int64_t i, const pType& type) const { return constant_pool->getInteger(i, type); }

    void accept(IRVisitor &visitor) override;

    auto getBFVisitor() const { return BasicBlock::CFGBFVisitor(blks.front()); }

    template <Util::DFVOrder order = Util::DFVOrder::PreOrder> auto getDFVisitor() const {
        return BasicBlock::CFGDFVisitor<order>(blks.front());
    }

    std::vector<pBlock> getExitBBs() const;

    size_t getInstCount() const;

    void updateCFG();
    void updateAndCheckCFG();
    bool removeParam(size_t index);
private:
    void updateBBIndex();
    void updateAllIndex();

    pVal cloneImpl() const override;
};
class NestedInstIterator {
private:
    std::deque<pInst> stack;
    void pushNestedInstructions(const std::vector<const std::list<pInst> *> &lists);

public:
    using iterator_category = std::input_iterator_tag;
    using value_type = pInst;
    using difference_type = std::ptrdiff_t;
    using pointer = pInst *;
    using reference = pInst &;
    explicit NestedInstIterator(const pInst &helper);
    explicit NestedInstIterator(const std::list<pInst> &insts);
    NestedInstIterator() = default;
    pInst operator*() const;
    NestedInstIterator &operator++();
    NestedInstIterator operator++(int);
    bool operator==(const NestedInstIterator &other) const;
    bool operator!=(const NestedInstIterator &other) const;
};
// 基本块划分前的过渡
// IRGenerator 生成之后， CFGBuilder 之前
class LinearFunction : public FunctionDecl {
    friend class Instruction;
    friend class SIR::ContextVisitor;
private:
    std::list<pInst> insts;
    std::vector<pFormalParam> params;
    ConstantPool *constant_pool;

public:
    using iterator = decltype(insts)::iterator;
    using const_iterator = decltype(insts)::const_iterator;
    using reverse_iterator = decltype(insts)::reverse_iterator;
    using const_reverse_iterator = decltype(insts)::const_reverse_iterator;

    LinearFunction(std::string name_, const std::vector<pFormalParam> &params, pType ret_type, ConstantPool *pool);

    const std::list<pInst> &getInsts() const;
    std::list<pInst> &getInsts();

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

    void addInst(iterator it, const pInst &inst);
    void addInst(size_t index, const pInst &inst);
    void addInst(pInst inst);
    void appendInsts(std::list<pInst> insts_);

    size_t getInstCount() const;

    const std::vector<pFormalParam> &getParams() const;
    ConstantPool &getConstantPool();

    template <typename T> auto getConst(T &&val) { return constant_pool->getConst(std::forward<T>(val)); }
    pVal getZero(const pType &type) { return constant_pool->getZero(type); }

    NestedInstIterator nested_begin() const { return NestedInstIterator(insts); }
    NestedInstIterator nested_end() const { return NestedInstIterator(); }
    auto nested_insts() const {
        return Util::make_iterator_range(nested_begin(), nested_end());
    }

    void accept(IRVisitor &visitor) override;
    void accept(SIR::Visitor &visitor);
    void accept(SIR::ContextVisitor &visitor);

private:
    pVal cloneImpl() const override;
};
} // namespace IR

#endif