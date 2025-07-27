// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_TARGET_RISCV64_HPP
#define GNALC_IR_TARGET_RISCV64_HPP

#include "ir/base.hpp"
#include "ir/instruction.hpp"
#include "target.hpp"

namespace IR {
class RV64TargetInfo : public TargetInfo {
public:
    bool isInstSupported(OP op) const override {
        // vector todo
        switch (op) {
        case OP::SHUFFLE:
        case OP::INSERT:
        case OP::EXTRACT:
        case OP::SELECT:
        case OP::ASHR:
            return false;
        default:
            return true;
        }
        return true;
    }
    bool isTypeSupported(const pType &type) const override {
        return true;
    }

    // bare metal
    bool isIntrinsicSupported(const std::string &lib_fn_name) const override { return false; }

    size_t getInternalizeSizeThreshold() const override {
        // Aggressive internalization will cause stack overflow.
        return 32;
    }
    size_t getGlobalizeSizeThreshold() const override {
        return 64;
    }
    const InlineThreshold& getInlineThreshold() const override {
        static const InlineThreshold ret = {
            .recursion_expand_max_inst = 100,
            .call_points = 0,
            .inst_threshold = 100,
        };
        return ret;
    }
};
} // namespace IR
#endif //TARGET_HPP
