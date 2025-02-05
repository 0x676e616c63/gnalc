#pragma once
#ifndef GNALC_IR_FUNCTION_HPP
#define GNALC_IR_FUNCTION_HPP

#include "base.hpp"
#include "basic_block.hpp"
#include "constant_pool.hpp"
#include "instruction.hpp"
#include "instructions/phi.hpp"

#include <memory>
#include <utility>
#include <vector>

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

class FormalParam : public Value {
    size_t index;

public:
    explicit FormalParam(std::string name, std::shared_ptr<Type> ty, size_t index_)
        : Value(std::move(name), std::move(ty), ValueTrait::FORMAL_PARAMETER),
          index(index_) {}
    size_t getIndex() const { return index; }

    void accept(IRVisitor &visitor) override;
};

class Function : public FunctionDecl,
                 public std::enable_shared_from_this<Function> {
private:
    std::vector<std::shared_ptr<FormalParam>> params;
    std::vector<std::shared_ptr<BasicBlock>> blks;
    ConstantPool *constant_pool;

    // 后面需要再说
    // int vreg_idx = 0;
public:
    using const_iterator = decltype(blks)::const_iterator;
    using iterator = decltype(blks)::iterator;

    Function(std::string name_,
             const std::vector<std::shared_ptr<FormalParam>> &params,
             std::shared_ptr<Type> ret_type, ConstantPool *pool);

    void addBlock(std::shared_ptr<BasicBlock> blk);

    bool delBlock(const std::shared_ptr<BasicBlock> &blk);

    template <typename Pred> bool delBlockIf(Pred pred) {
        bool found = false;
        for (auto it = blks.begin(); it != blks.end();) {
            if (pred(*it)) {
                for (const auto &use : (*it)->getUseList()) {
                    auto phi =
                        std::dynamic_pointer_cast<PHIInst>(use->getUser());
                    Err::gassert(phi != nullptr,
                                 "Function::delBlockIf(): Cannot delete a "
                                 "block that has users beyond phi.");
                    phi->delPhiOper(*it);

                    // Simplify PHI
                    auto phi_opers = phi->getPhiOpers();
                    Err::gassert(!phi_opers.empty());
                    if (phi_opers.size() == 1)
                        phi->replaceSelf(phi_opers[0]->getValue());
                }
                it = blks.erase(it);
                found = true;
            } else
                ++it;
        }
        return found;
    }

    const std::vector<std::shared_ptr<FormalParam>> &getParams() const;
    std::vector<std::shared_ptr<FormalParam>> &getParams();

    // usually we can use range-based for instead of these
    const std::vector<std::shared_ptr<BasicBlock>> &getBlocks() const;
    std::vector<std::shared_ptr<BasicBlock>> &getBlocks();

    const_iterator cbegin() const;
    const_iterator cend() const;
    iterator begin();
    iterator end();
    // ...

    // 后面需要再说
    // int getVRegIdx() { return vreg_idx++; } //
    // 用于生成SSA时的虚拟寄存器计数，从0开始，GetIdx后++ int getVRegNum() const
    // { return vreg_idx; } // 虚拟寄存器数量

    ConstantPool &getConstantPool();

    void updateBBIndex();
    void updateAllIndex();

    void accept(IRVisitor &visitor) override;
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
    std::vector<std::shared_ptr<Instruction>> &getInsts();

    const_iterator cbegin() const;
    const_iterator cend() const;
    iterator begin();
    iterator end();

    void addInst(std::shared_ptr<Instruction> inst);
    void appendInsts(std::vector<std::shared_ptr<Instruction>> insts_);

    void accept(IRVisitor &visitor) override;
};
} // namespace IR

#endif