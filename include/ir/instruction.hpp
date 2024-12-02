/**
 * @brief 各种instruction的基类
 * @todo 关于指针的问题
 */

#pragma once
#include "base.hpp"
#include "basic_block.hpp"

namespace IR {

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

    ALLOCA, // memory
    LOAD,
    STORE,
    GEP,

    FPTOSI, // converse
    SITOFP,

    ICMP, // compare
    FCMP,

    PHI,

    CALL

};


/**
 * @brief Instruction的操作数实际上由User基类的Oprands来管理
 */
class Instruction : public User {
private:
    OP opcode;
    BasicBlock* parent = nullptr; // 隶属的basic block

public:
    // 此构造方法用于初始生成时，最开始没有划分Block，故parent为空
    Instruction(OP opcode, NameParam name = "", _type t = UNDEFINED) : User(t, name), opcode(opcode) {}
    // 用于后续划分之后的构造
    // Instruction(OP opcode, BasicBlock* parent, NameParam name = "", _type t = UNDEFINED) : User(t, name), opcode(opcode), parent(parent) {}

    // addOprand in User

    void setParent(BasicBlock* p) { parent = p; }
    OP getOpcode() { return opcode; }
    BasicBlock* getParent() { return parent; }
};

}