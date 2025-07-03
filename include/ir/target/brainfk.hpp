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
    bool isInstSupported(OP op) override {
        return true;
    }
    bool isTypeSupported(const pType& type) override {
        return true;
    }
    bool isLibCallSupported(const std::string &lib_fn_name) override {
        return true;
    }
};
}
#endif //TARGET_HPP
