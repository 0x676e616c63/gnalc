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

namespace Parser {
class CFGBuilder;
}

namespace IR {
enum class FuncAttr {
    // User defined functions
    NotBuiltin,

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

    // Only Builtin Functions
    // For user-defined functions, use AliasAnalysis instead.
    builtinMemReadOnly,
    builtinMemWriteOnly,
    builtinMemReadWrite,
};
class FunctionDecl : public Value {
private:
    std::set<FuncAttr> func_attrs;
    Module *parent{};

public:
    FunctionDecl(std::string name_, std::vector<pType> params, pType ret_type, bool is_va_arg_,
                 std::set<FuncAttr> attrs = {});

    void accept(IRVisitor &visitor) override;

    bool isSylib() const;
    bool isIntrinsic() const;

    bool hasAttr(FuncAttr attr) const;
    void addAttr(FuncAttr attr);
    const std::set<FuncAttr> &getAttrs() const;

    void setParent(Module *module);
    Module *getParent() const;

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

class Function : public FunctionDecl {
    friend class Parser::CFGBuilder;

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
             std::set<FuncAttr> attrs = {});

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

    // 后面需要再说
    // int getVRegIdx() { return vreg_idx++; } //
    // 用于生成SSA时的虚拟寄存器计数，从0开始，GetIdx后++ int getVRegNum() const
    // { return vreg_idx; } // 虚拟寄存器数量

    ConstantPool &getConstantPool();

    template <typename T> auto getConst(T &&val) { return constant_pool->getConst(std::forward<T>(val)); }

    void accept(IRVisitor &visitor) override;

    auto getBFVisitor() const { return BasicBlock::CFGBFVisitor(blks.front()); }

    template <Util::DFVOrder order = Util::DFVOrder::PreOrder> auto getDFVisitor() const {
        return BasicBlock::CFGDFVisitor<order>(blks.front());
    }

    std::vector<pBlock> getExitBBs() const;

    size_t getInstCount() const;

    void updateCFG();
    void updateAndCheckCFG();

private:
    void updateBBIndex();
    void updateAllIndex();

    pVal cloneImpl() const override;
};

// 基本块划分前的过渡
// IRGenerator 生成之后， CFGBuilder 之前
class LinearFunction : public Function {
private:
    std::vector<pInst> insts;

public:
    using iterator = decltype(insts)::iterator;
    using const_iterator = decltype(insts)::const_iterator;
    using reverse_iterator = decltype(insts)::reverse_iterator;
    using const_reverse_iterator = decltype(insts)::const_reverse_iterator;

    LinearFunction(std::string name_, const std::vector<pFormalParam> &params, pType ret_type, ConstantPool *pool)
        : Function(std::move(name_), params, std::move(ret_type), pool) {}

    // usually we can use range-based for instead of these
    const std::vector<pInst> &getInsts() const;

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

    void addInst(pInst inst);
    void appendInsts(std::vector<pInst> insts_);

    void accept(IRVisitor &visitor) override;
};
} // namespace IR

#endif