// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_TARGET_BRAINFK_HPP
#define GNALC_IR_TARGET_BRAINFK_HPP

#include "../base.hpp"
#include "../instruction.hpp"
#include "target.hpp"

namespace IR {
// TODO
class BFTargetInfo : public TargetInfo {
public:
    bool isInstSupported(OP op) const override { return true; }
    bool isTypeSupported(const pType &type) const override { return true; }
    bool isIntrinsicSupported(const std::string &lib_fn_name) const override { return true; }
};
} // namespace IR
#endif //TARGET_HPP
