// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_TARGET_TARGET_HPP
#define GNALC_IR_TARGET_TARGET_HPP

#include "ir/base.hpp"
#include "ir/instruction.hpp"

namespace IR {
class TargetInfo {
public:
    virtual ~TargetInfo() = default;
    virtual bool isInstSupported(OP op) = 0;
    virtual bool isTypeSupported(const pType &type) = 0;
    virtual bool isLibCallSupported(const std::string &lib_fn_name) = 0;

    bool isVectorSupported() {
        return isInstSupported(OP::INSERT) && isInstSupported(OP::EXTRACT) && isInstSupported(OP::SHUFFLE);
    }
    bool isBitwiseOpSupported() {
        return isInstSupported(OP::AND) && isInstSupported(OP::OR) && isInstSupported(OP::XOR) &&
               isInstSupported(OP::SHL) && isInstSupported(OP::LSHR) && isInstSupported(OP::ASHR);
    }
    bool isSelectSupported() {
        return isInstSupported(OP::SELECT);
    }
    bool isTypeSupported(IRBTYPE btype) {
        return isTypeSupported(makeBType(btype));
    }
};
} // namespace IR
#endif //TARGET_HPP
