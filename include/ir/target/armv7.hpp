// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_TARGET_ARMv7_HPP
#define GNALC_IR_TARGET_ARMv7_HPP

#include "ir/base.hpp"
#include "ir/instruction.hpp"
#include "target.hpp"

namespace IR {
class ARMv7TargetInfo : public TargetInfo {
public:
    bool isInstSupported(OP op) const override {
        switch (op) {
        case OP::AND:
        case OP::OR:
        case OP::XOR:
        case OP::SHL:
        case OP::ASHR:
        case OP::LSHR:
        case OP::FREM:
        case OP::UREM:
        case OP::SEXT:
        case OP::SHUFFLE:
        case OP::INSERT:
        case OP::EXTRACT:
        case OP::SELECT:
            return false;
        default:
            return true;
        }
        return true;
    }
    bool isTypeSupported(const pType &type) const override {
        if (type->isI64())
            return false;
        return true;
    }
    bool isIntrinsicSupported(IntrinsicID id) const override { return false; }
    size_t getInternalizeSizeThreshold() const override {
        return 32;
    }
    size_t getGlobalizeSizeThreshold() const override {
        return 64;
    }


    const InlineThreshold& getInlineThreshold() const override {
        static const InlineThreshold ret = {
            .recursion_expand_max_inst = 100,
            .call_sites = 3,
            .inst_threshold = 200,
        };
        return ret;
    }
};
} // namespace IR
#endif //TARGET_HPP
