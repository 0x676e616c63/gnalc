#pragma once
#ifndef GNALC_IR_FUNCTION_HPP
#define GNALC_IR_FUNCTION_HPP

#include "base.hpp"
#include "basic_block.hpp"
#include "constant_pool.hpp"
#include "instruction.hpp"
#include "instructions/phi.hpp"
#include "../utils/generic_visitor.hpp"

#include <memory>
#include <utility>
#include <vector>

namespace Parser {
class CFGBuilder;
}

namespace IR {
class FunctionDecl : public Value {
private:
    bool is_builtin;
    bool is_sylib;

public:
    FunctionDecl(std::string name_, std::vector<std::shared_ptr<Type>> params,
                 std::shared_ptr<Type> ret_type, bool is_va_arg_,
                 bool is_builtin_, bool is_sylib_);

    void accept(IRVisitor &visitor) override;

    bool isSylib() const;
    bool isBuiltin() const;

    ~FunctionDecl() override;
};

// FormalParam shouldn't contain a parent.
// If really need it, update CFGBuilder to move them correctly from LinearFunction to Function.
class FormalParam : public Value {
    size_t index;

public:
    explicit FormalParam(std::string name, std::shared_ptr<Type> ty, size_t index_)
        : Value(std::move(name), std::move(ty), ValueTrait::FORMAL_PARAMETER),
          index(index_) {}

    size_t getIndex() const { return index; }
    void setIndex(size_t index_) { index = index_; }

    void accept(IRVisitor &visitor) override;
};

struct BBSuccGetter {
    auto operator()(const std::shared_ptr<BasicBlock>& bb)
    {
        return bb->getNextBB();
    }
};

class Function : public FunctionDecl,
                 public std::enable_shared_from_this<Function> {
    friend class Parser::CFGBuilder;
private:
    std::vector<std::shared_ptr<FormalParam>> params;
    std::vector<std::shared_ptr<BasicBlock>> blks;
    ConstantPool *constant_pool;

    // 后面需要再说
    // int vreg_idx = 0;
public:
    using CFGBFVisitor = Util::GenericBFVisitor<std::shared_ptr<BasicBlock>, BBSuccGetter>;
    using CFGDFVisitor = Util::GenericDFVisitor<std::shared_ptr<BasicBlock>, BBSuccGetter>;
    using const_iterator = decltype(blks)::const_iterator;
    using iterator = decltype(blks)::iterator;

    Function(std::string name_,
             const std::vector<std::shared_ptr<FormalParam>> &params,
             std::shared_ptr<Type> ret_type, ConstantPool *pool);

    void addBlock(std::shared_ptr<BasicBlock> blk);

    // Add the given block as the entry block
    // Caller should take care of the CFG.
    void addBlockAsEntry(const std::shared_ptr<BasicBlock>& blk);

    // Delete a Block
    // Requires the target block have no users than Phi.
    bool delBlock(const std::shared_ptr<BasicBlock> &blk);

    // Delete blocks that satisfied: `pred(block) == true`
    // Requires the target block have no predecessors or successors
    // In other word, If pred(a) == true, pred(a->user->getPre/NextBB()) must be true
    template <typename Pred> bool delBlockIf(Pred pred) {
        bool found = false;
        for (auto it = blks.begin(); it != blks.end();) {
            if (pred(*it)) {
                for (const auto &prebb : (*it)->getPreBB()) {
                    Err::gassert(pred(prebb),
                        "Cannot delete a block that have predecessors");
                }
                for (const auto &nextbb : (*it)->getNextBB()) {
                    Err::gassert(pred(nextbb),
                        "Cannot delete a block that have successors");
                }
                it = blks.erase(it);
                found = true;
            } else
                ++it;
        }
        if (found) updateBBIndex();
        return found;
    }

    const std::vector<std::shared_ptr<FormalParam>> &getParams() const;

    // usually we can use range-based for instead of this
    const std::vector<std::shared_ptr<BasicBlock>> &getBlocks() const;

    const_iterator begin() const;
    const_iterator end() const;
    iterator begin();
    iterator end();
    const_iterator cbegin() const;
    const_iterator cend() const;
    // ...

    // 后面需要再说
    // int getVRegIdx() { return vreg_idx++; } //
    // 用于生成SSA时的虚拟寄存器计数，从0开始，GetIdx后++ int getVRegNum() const
    // { return vreg_idx; } // 虚拟寄存器数量

    ConstantPool &getConstantPool();

    void accept(IRVisitor &visitor) override;

    auto getBFVisitor() const {
        return CFGBFVisitor(blks[0]);
    }

    auto getDFVisitor(Util::DFVOrder order = Util::DFVOrder::PreOrder) const {
        return CFGDFVisitor(blks[0], order);
    }

    std::vector<std::shared_ptr<BasicBlock>> getExitBBs() const;

    size_t getInstCount() const;

private:
    void updateBBIndex();
    void updateAllIndex();
};

// 基本块划分前的过渡
// IRGenerator 生成之后， CFGBuilder 之前
class LinearFunction : public Function {
private:
    std::vector<std::shared_ptr<Instruction>> insts;

public:
    using const_iterator = decltype(insts)::const_iterator;
    using iterator = decltype(insts)::iterator;

    LinearFunction(std::string name_,
                   const std::vector<std::shared_ptr<FormalParam>> &params,
                   std::shared_ptr<Type> ret_type, ConstantPool *pool)
        : Function(std::move(name_), params, std::move(ret_type), pool) {}

    // usually we can use range-based for instead of these
    const std::vector<std::shared_ptr<Instruction>> &getInsts() const;

    const_iterator begin() const;
    const_iterator end() const;
    iterator begin();
    iterator end();
    const_iterator cbegin() const;
    const_iterator cend() const;

    void addInst(std::shared_ptr<Instruction> inst);
    void appendInsts(std::vector<std::shared_ptr<Instruction>> insts_);

    void accept(IRVisitor &visitor) override;
};
} // namespace IR

#endif