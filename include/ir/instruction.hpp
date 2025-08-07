// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

/**
 * @brief 各种 instruction 的基类
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
    SDIV,
    UDIV,
    FDIV,
    SREM,
    UREM,
    FREM, // not implemented in IRGen
    SHL,
    LSHR,
    ASHR,
    AND,
    OR,
    XOR,

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
    SEXT,
    BITCAST,
    PTRTOINT,
    INTTOPTR,

    // Compare
    ICMP,
    FCMP,

    // Select
    SELECT,

    // Phi Node
    PHI,

    // Function Call
    CALL,

    // Vector
    EXTRACT,
    INSERT,
    SHUFFLE,

    // Helper for easy IRGen, pruned after CFGBuilder
    HELPER,
    INDVAR,
};

// We can't see BasicBlock's definition here, use `BBInstIter` to get around it.
using BBInstIter = std::list<pInst>::iterator;
using BBPhiInstIter = std::list<pPhi>::iterator;

using LInstIter = std::list<pInst>::iterator;

// Warning: PHIInst MUST NOT invoke the following four `moveInst(s)`
// Move `inst` to `new_bb`'s `location`
// This deletes `inst` from its parent, and insert it before `new_bb`'s location
void moveInst(const pInst &inst, const pBlock &new_bb, BBInstIter location);
void moveInsts(BBInstIter beg, BBInstIter end, const pBlock &new_bb, BBInstIter location);
// The following two functions move `inst` to `new_bb`'s end
void moveInst(const pInst &inst, const pBlock &new_bb);
void moveInsts(BBInstIter beg, BBInstIter end, const pBlock &new_bb);

void movePhiInsts(const pBlock &src_bb, const pBlock &dest_bb);

/**
 * @brief Instruction的操作数实际上由User的Operands来管理
 */
class Instruction : public User {
    friend class BasicBlock;
    friend class LinearFunction;

private:
    OP opcode;
    wpBlock parent = {}; // 隶属的basic block
    size_t inst_index = 0;
    std::vector<std::string> dbg_data;

public:
    // 此构造方法用于初始生成时，最开始没有划分Block，故parent为空
    Instruction(OP opcode, std::string _name, const pType &_type);
    Instruction(OP opcode, std::string _name, const pType &_type, ValueTrait value_trait_);

    OP getOpcode() const;
    void setParent(const pBlock &p);
    pBlock getParent() const;
    size_t getIndex() const;
    // Warning: PHIInst MUST NOT invoke this.
    BBInstIter iter() const;

    bool isCommutative() const;

    const std::vector<std::string>& getDbgData() const;
    void appendDbgData(const std::string& data);
    void appendDbgData(const std::vector<std::string>& data);
    void clearDbgData();

    void accept(IRVisitor &visitor) override;

    ~Instruction() override;
};
} // namespace IR

#endif