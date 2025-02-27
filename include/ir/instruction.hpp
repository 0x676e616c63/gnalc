/**
 * @brief 各种instruction的基类
 * @todo 关于指针的问题
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTION_HPP
#define GNALC_IR_INSTRUCTION_HPP

#include "base.hpp"

namespace IR {

// Instruction's Opcode
enum class OP {
    // Terminator
    RET,
    BR,

    // Unary
    FNEG,

    // Binary
    ADD,
    FADD,
    SUB,
    FSUB,
    MUL,
    FMUL,
    DIV,
    FDIV,
    REM,
    FREM, // not implemented in IRGen

    AND, // bitwise, not implemented in IRGen
    OR,  // bitwise, not implemented in IRGen

    // Memory Operation
    ALLOCA,
    LOAD,
    STORE,

    // Getelementptr
    GEP,

    // Type Cast
    FPTOSI,
    SITOFP,
    ZEXT,
    BITCAST,

    // Compare
    ICMP,
    FCMP,

    // Phi Node
    PHI,

    // Function Call
    CALL,

    // Helper for easy IRGen, pruned after CFGBuilder
    HELPER
};


class Instruction;
class BasicBlock;

// We can't see BasicBlock's definition here, use `BBInstIter` to get around it.
using BBInstIter = std::list<std::shared_ptr<Instruction>>::iterator;

// Warning: PHIInst MUST NOT invoke the following four `moveInst(s)`
// Move `inst` to `new_bb`'s `location`
// This deletes `inst` from its parent, and insert it before `new_bb`'s location
void moveInst(const std::shared_ptr<Instruction>& inst,
    const std::shared_ptr<BasicBlock>& new_bb, BBInstIter location);
void moveInsts(BBInstIter beg, BBInstIter end,
    const std::shared_ptr<BasicBlock>& new_bb, BBInstIter location);
// The following two functions move `inst` to `new_bb`'s end
void moveInst(const std::shared_ptr<Instruction>& inst,
    const std::shared_ptr<BasicBlock>& new_bb);
void moveInsts(BBInstIter beg, BBInstIter end,
    const std::shared_ptr<BasicBlock>& new_bb);

/**
 * @brief Instruction的操作数实际上由User的Operands来管理
 */
class Instruction : public User {
    friend class BasicBlock;

private:
    OP opcode;
    std::weak_ptr<BasicBlock> parent = {}; // 隶属的basic block
    size_t index = 0;

public:
    // 此构造方法用于初始生成时，最开始没有划分Block，故parent为空
    Instruction(OP opcode, std::string _name, const std::shared_ptr<Type> &_type);

    void setParent(const std::shared_ptr<BasicBlock> &p);
    OP getOpcode() const;
    std::shared_ptr<BasicBlock> getParent() const;

    size_t getIndex() const;

    // Warning: PHIInst MUST NOT invoke this.
    BBInstIter getIter() const;

    void accept(IRVisitor &visitor) override;

    ~Instruction() override;
};
} // namespace IR

#endif