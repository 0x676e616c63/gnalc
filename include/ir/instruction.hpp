/**
 * @brief 各种instruction的基类
 * @todo 关于指针的问题
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTION_HPP
#define GNALC_IR_INSTRUCTION_HPP

#include "base.hpp"

namespace IR {

// INSTRUCTION'S OPCODE
enum class OP {
    RET, // ctrl
    BR,

    FNEG, // unary

    ADD, // binary
    FADD,
    SUB,
    FSUB,
    MUL,
    FMUL,
    DIV,
    FDIV,
    REM,
    FREM,

    AND, // bitwise binary
    OR,

    ALLOCA, // memory
    LOAD,
    STORE,
    GEP,

    FPTOSI, // converse
    SITOFP,
    ZEXT,
    BITCAST,

    ICMP, // compare
    FCMP,

    PHI,

    CALL,

    HELPER

};

/**
 * @brief Instruction的操作数实际上由User的Oprands来管理
 *
 * @todo BB的指针问题？
 * @todo 类型是否会为ARRAY?
 */
class BasicBlock;
class Instruction : public User {
private:
    OP opcode;
    std::weak_ptr<BasicBlock> parent = {}; // 隶属的basic block

public:
    // 此构造方法用于初始生成时，最开始没有划分Block，故parent为空
    Instruction(OP opcode, std::string _name,
                const std::shared_ptr<Type> &_type);
    // 用于后续划分之后的构造
    // Instruction(OP opcode, BasicBlock* parent, NameParam name = "", _type t =
    // UNDEFINED) : User(t, name), opcode(opcode), parent(parent) {}

    // addOprand in User

    void setParent(const std::shared_ptr<BasicBlock> &p);
    OP getOpcode() const;
    std::shared_ptr<BasicBlock> getParent() const;

    unsigned index = 0; // 不经过插入删除接口修改后使用先调用父块的update方法！

    void accept(IRVisitor &visitor) override;
    ~Instruction() override;
};

} // namespace IR

#endif