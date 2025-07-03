// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

/**
 * @brief compare instruction
 * @brief icmp, fcmp
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_COMPARE_HPP
#define GNALC_IR_INSTRUCTIONS_COMPARE_HPP

#include "ir/instruction.hpp"
#include "ir/type_alias.hpp"

namespace IR {
// eq: equal
// ne: not equal
// sgt: signed greater than
// sge: signed greater or equal
// slt: signed less than
// sle: signed less or equal
// NO UNSIGNED
enum class ICMPOP { eq, ne, sgt, sge, slt, sle };

// <result> = icmp <cond> <ty> <op1>, <op2>
// 1216修复：cmp指令的type(运算结果的type)应为i1,
// 操作数的type可用getLHS()->getType()获得，暂不设basetype
// @attention ：默认op1和op2类型一致，均为i32
class ICMPInst : public Instruction {
private:
    friend class LoopUnrollPass;
    ICMPOP cond;

public:
    ICMPInst(NameRef name, ICMPOP cond, const pVal &lhs, const pVal &rhs);

    pVal getLHS() const;

    pVal getRHS() const;

    ICMPOP getCond() const;

    void condFlip();

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override { return std::make_shared<ICMPInst>(getName(), cond, getLHS(), getRHS()); }
};

// false: no comparison, always returns false
// oeq: ordered and equal
// ogt: ordered and greater than
// oge: ordered and greater than or equal
// olt: ordered and less than
// ole: ordered and less than or equal
// one: ordered and not equal
// ord: ordered (no nans)
// ueq: unordered or equal
// ugt: unordered or greater than
// uge: unordered or greater than or equal
// ult: unordered or less than
// ule: unordered or less than or equal
// une: unordered or not equal
// uno: unordered (either nans)
// true: no comparison, always returns true
enum class FCMPOP {
    oeq,
    ogt,
    oge,
    olt,
    ole,
    one,
    ord,
};

// <result> = fcmp [fast-math flags]* <cond> <ty> <op1>, <op2>
// type默认为float
class FCMPInst : public Instruction {
private:
    FCMPOP cond;

public:
    FCMPInst(NameRef name, FCMPOP cond, const pVal &lhs, const pVal &rhs);

    pVal getLHS() const;

    pVal getRHS() const;

    FCMPOP getCond() const;

    void condFlip();

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override { return std::make_shared<FCMPInst>(getName(), cond, getLHS(), getRHS()); }
};

// Utilities to flip/reverse a cond
// Flip
// a > b -> a <= b
// just like adding a `not` before the result.
ICMPOP flipCond(ICMPOP cond);
FCMPOP flipCond(FCMPOP cond);
// Reverse
// a > b -> a < b
ICMPOP reverseCond(ICMPOP cond);
FCMPOP reverseCond(FCMPOP cond);

bool isFalseWhenEqual(ICMPOP cond);
bool isTrueWhenEqual(ICMPOP cond);
bool isFalseWhenEqual(FCMPOP cond);
bool isTrueWhenEqual(FCMPOP cond);
} // namespace IR

#endif
