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
    bool isInstSupported(OP op) override {
        if (op == OP::SELECT)
            return false;
        return true;
    }
    bool isTypeSupported(const pType& type) override {
        if (type->isI128())
            return false;
        return true;
    }

    // bare metal
    bool isLibCallSupported(const std::string &lib_fn_name) override {
        return false;
    }
};
}
#endif //TARGET_HPP
