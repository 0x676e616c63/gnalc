// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_TARGET_BRAINFK_HPP
#define GNALC_IR_TARGET_BRAINFK_HPP

#include "ir/base.hpp"
#include "ir/instruction.hpp"
#include "target.hpp"

namespace IR {
// TODO
class BFTargetInfo : public TargetInfo {
public:
    bool isInstSupported(OP op) const override { return true; }
    bool isTypeSupported(const pType &type) const override { return true; }
    bool isIntrinsicSupported(IntrinsicID id) const override {
        return false;
    }
    size_t getInternalizeSizeThreshold() const override {
        return 0;
    }
    size_t getGlobalizeSizeThreshold() const override {
        return 0;
    }
    const InlineThreshold& getInlineThreshold() const override {
        static const InlineThreshold ret = {
            .recursion_expand_max_inst = 0,
            .call_points = 0,
            .inst_threshold = 0,
        };
        return ret;
    }
};
} // namespace IR
#endif //TARGET_HPP
