// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_TARGET_TARGET_HPP
#define GNALC_IR_TARGET_TARGET_HPP

#include "ir/base.hpp"
#include "ir/instruction.hpp"

namespace IR {
enum class ShuffleKind {
    Broadcast, // splat of a value
    Reverse,   // Revere the order
    Other      // Other
};

enum class OperandKind {
    Any,               // Any
    Uniform,           // uniform (splat of a value)
    UniformConstant,   // uniform constant (splat of a constant)
    NonUniformConstant // non-uniform constant
};
enum class OperandProp { None, PowerOfTwo };
struct OperandTrait {
    OperandKind kind = OperandKind::Any;
    OperandProp prop = OperandProp::None;

    static OperandTrait none() { return OperandTrait{OperandKind::Any, OperandProp::None}; }
};
class TargetInfo {
public:
    virtual ~TargetInfo() = default;
    virtual bool isInstSupported(OP op) const = 0;
    virtual bool isTypeSupported(const pType &type) const = 0;
    virtual bool isIntrinsicSupported(const std::string &lib_fn_name) const = 0;

    // Convenient wrappers
    bool isVectorSupported() {
        return isInstSupported(OP::INSERT) && isInstSupported(OP::EXTRACT) && isInstSupported(OP::SHUFFLE);
    }
    bool isBitwiseOpSupported() {
        return isInstSupported(OP::AND) && isInstSupported(OP::OR) && isInstSupported(OP::XOR) &&
               isInstSupported(OP::SHL) && isInstSupported(OP::LSHR) && isInstSupported(OP::ASHR);
    }
    bool isSelectSupported() { return isInstSupported(OP::SELECT); }
    bool isTypeSupported(IRBTYPE btype) { return isTypeSupported(makeBType(btype)); }

    // Vector is not required
    virtual size_t getMaxVectorRegisterSize() const { Err::not_implemented(); }
    virtual size_t getMinVectorRegisterSize() const { Err::not_implemented(); }

    // Below is required iff `isVectorSupported() == true`
    virtual bool canVectorize(OP op) const { Err::not_implemented(); }
    virtual int getVecInstCost(OP op, const pVecType &ty, size_t index) const { Err::not_implemented(); }
    virtual int getShuffleCost(const pVecType &ty, ShuffleKind kind) const { Err::not_implemented(); }
    virtual int getCastCost(OP op, const pType &src, const pType &dest) const { Err::not_implemented(); }
    virtual int getCmpCost(OP op, const pType &val_ty) { Err::not_implemented(); }
    virtual int getSelectCost(const pType &val_ty) { Err::not_implemented(); }
    virtual int getBinaryCost(OP op, const pType &ty, OperandTrait lhs, OperandTrait rhs) { Err::not_implemented(); }
    virtual int getMemCost(OP op, const pType &ty, int align) { Err::not_implemented(); }
};
} // namespace IR
#endif //TARGET_HPP
