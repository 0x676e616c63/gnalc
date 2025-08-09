// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_TARGET_ARMv8_HPP
#define GNALC_IR_TARGET_ARMv8_HPP

#include "ir/base.hpp"
#include "ir/instruction.hpp"
#include "target.hpp"

namespace IR {
class ARMv8TargetInfo : public TargetInfo {
public:
    bool isInstSupported(OP op) const override { return true; }
    bool isTypeSupported(const pType &type) const override {
        return true;
    }
    bool isIntrinsicSupported(IntrinsicID id) const override {
        switch (id) {
        case IntrinsicID::Memset:
        case IntrinsicID::Memcpy:
        case IntrinsicID::AtomicAdd:
        case IntrinsicID::AtomicFAdd:
        case IntrinsicID::ParallelForEntry:
            return true;
        default:
                return false;
        }
        return false;
    }

    size_t getMaxVectorRegisterSize() const override { return 128; }
    size_t getMinVectorRegisterSize() const override { return 64; }

    size_t getInternalizeSizeThreshold() const override {
        return 32;
    }
    size_t getGlobalizeSizeThreshold() const override {
        return 1024;
    }
    const InlineThreshold& getInlineThreshold() const override {
        static const InlineThreshold ret = {
            .recursion_expand_max_inst = 100,
            .call_points = 3,
            .inst_threshold = 200,
        };
        return ret;
    }

    // FIXME: More precise
    int getVecInstCost(OP op, const pVecType &ty, size_t index) const override {
        Err::gassert(op == OP::INSERT || op == OP::EXTRACT);
        if (index == 0)
            return 0;
        return 3;
    }

    int getShuffleCost(const pVecType &ty, ShuffleKind kind) const override {
        if (kind == ShuffleKind::Broadcast || kind == ShuffleKind::Reverse)
            return 1;

        int cost = 0;
        // cost = extract + insert
        for (int i = 0; i < ty->getVectorSize(); ++i) {
            cost += getVecInstCost(OP::EXTRACT, ty, i);
            cost += getVecInstCost(OP::INSERT, ty, i);
        }
        return cost;
    }

    int getCastCost(OP op, const pType &src, const pType &dest) const override {
        if (src->is<VectorType>()) {
            if (op == OP::ZEXT)
                return 1;
            if (op == OP::SEXT)
                return 2;

            // FIXME
            return 1;
        }
        return op == OP::BITCAST ? 0 : 1;
    }

    int getCmpCost(OP op, const pType &val_ty) override { return 1; }

    int getSelectCost(const pType &val_ty) override { return 1; }

    int getBinaryCost(OP op, const pType &ty, OperandTrait lhs, OperandTrait rhs) override {
        bool is_fp = ty->isFloatingPoint() || ty->isFPVec();
        int cost = is_fp ? 2 : 1;

        // sdiv -> add + cmp + select + ashr
        if (op == OP::SDIV && rhs.kind == OperandKind::UniformConstant && rhs.prop == OperandProp::PowerOfTwo) {
            cost += getBinaryCost(OP::ADD, ty, OperandTrait::none(), OperandTrait::none());
            cost += getBinaryCost(OP::SUB, ty, OperandTrait::none(), OperandTrait::none());
            cost += getSelectCost(ty);
            cost += getBinaryCost(OP::ASHR, ty, OperandTrait::none(), OperandTrait::none());
            return cost;
        }

        switch (op) {
        case OP::ADD:
        case OP::MUL:
        case OP::XOR:
        case OP::OR:
        case OP::AND:
            return cost + 1;
        default:
            // FIXME
            return cost + 2;
        }
        Err::unreachable();
        return cost;
    }

    int getUnaryCost(OP op, const pType &ty, OperandTrait oper) override {
        switch (op) {
        case OP::FNEG:
            // FIXME: I'm not sure about this.
            return 2;
        default: return 2;
        }
        Err::unreachable();
        return 2;
    }

    int getMemCost(OP op, const pType &ty, int align) override {
        if (op == OP::STORE && ty->is128BitVec() && align < 16)
            return 12;

        return 2;
    }
    bool canVectorize(OP op) const override {
        switch (op) {
        case OP::SDIV:
        case OP::UDIV:
        case OP::LSHR:
        case OP::ASHR:
        case OP::SREM:
        case OP::UREM:
            return false;
        default: return true;
        }
        Err::unreachable();
        return true;
    }
};
} // namespace IR
#endif //TARGET_HPP
