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

/**
 * @brief Instruction的操作数实际上由User的Operands来管理
 */
class BasicBlock;
class Instruction : public User {
private:
    OP opcode;
    std::weak_ptr<BasicBlock> parent = {}; // 隶属的basic block

public:
    // 此构造方法用于初始生成时，最开始没有划分Block，故parent为空
    Instruction(OP opcode, std::string _name, const std::shared_ptr<Type> &_type);

    void setParent(const std::shared_ptr<BasicBlock> &p);
    OP getOpcode() const;
    std::shared_ptr<BasicBlock> getParent() const;

    std::list<std::shared_ptr<Instruction>>::iterator getIter() const;

    unsigned index = 0; // 不经过插入删除接口修改后使用先调用父块的update方法！

    void accept(IRVisitor &visitor) override;
    ~Instruction() override;
};

} // namespace IR

#endif