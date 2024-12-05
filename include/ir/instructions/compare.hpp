/**
 * @brief compare instruction
 * @brief icmp fcmp
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_COMPARE_HPP
#define GNALC_IR_INSTRUCTIONS_COMPARE_HPP

#include "../instruction.hpp"

namespace IR {

// eq: equal
// ne: not equal
// sgt: signed greater than
// sge: signed greater or equal
// slt: signed less than
// sle: signed less or equal
// NO UNSIGNED
enum class ICMPOP {
    eq,
    ne,
    sgt,
    sge,
    slt,
    sle
};

// <result> = icmp <cond> <ty> <op1>, <op2>
// 若无特殊情况，ty = i32，考虑bool值？
class ICMPInst : public Instruction {
private:
    ICMPOP cond;

public:
    ICMPInst(NameRef name, ICMPOP cond, Value* lhs, Value* rhs);

    auto& GetLHS() const;
    auto& GetRHS() const;
    ICMPOP GetCond() const;
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
    FCMPInst(NameRef name, FCMPOP cond, Value* lhs, Value* rhs);

    auto& GetLHS() const;
    auto& GetRHS() const;
    FCMPOP GetCond() const;
};

}

#endif