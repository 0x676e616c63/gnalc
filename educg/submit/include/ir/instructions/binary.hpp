// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

/**
 * @brief binary operation and fneg
 * @brief add, fadd, sub, fsub, mul, fmul, sdiv, fdiv, srem, frem, fneg
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_BINARY_HPP
#define GNALC_IR_INSTRUCTIONS_BINARY_HPP

#include "../instruction.hpp"
#include "../type_alias.hpp"

namespace IR {
// type 由op决定
// 例如 %3 = add i32 %1, %2
// name = "%3"
// type = i32
// opcode = ADD
// operands = [%1, %2]
class BinaryInst : public Instruction {
public:
    BinaryInst(NameRef name, OP opcode, const pVal &lhs, const pVal &rhs);

    pVal getLHS() const;
    pVal getRHS() const;

    void setLHS(const pVal &lhs);
    void setRHS(const pVal &rhs);
    void swapLHSRHS();

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override { return std::make_shared<BinaryInst>(getName(), getOpcode(), getLHS(), getRHS()); }
};

// OP = FNEG, type = f32
// <result> = fneg [fast-math flags]* <ty> <op1>
class FNEGInst : public Instruction {
public:
    FNEGInst(NameRef name, pVal val);

    pVal getVal() const;

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override { return std::make_shared<FNEGInst>(getName(), getVal()); }
};
} // namespace IR

#endif