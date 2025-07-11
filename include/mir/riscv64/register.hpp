// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_RISCV64_REGISTER_HPP
#define GNALC_MIR_RISCV64_REGISTER_HPP

#include "mir/MIR.hpp"

namespace MIR {

class RVRegisterInfo : public RegisterInfo {
public:
    ~RVRegisterInfo() override = default;
    unsigned getCoreRegisterNum() const override {
        return 30; // X1, X3-X31
    }
    unsigned getFpOrVecRegisterNum() const override {
        return 32; // F0-F31
    }
    std::set<int> getCoreRegisterAllocationList() const override {
        return {
            1,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14,
            15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28,
            29, 30, 31
        };
    }
    std::set<int> getFpOrVecRegisterAllocationList() const override {
        return {
            32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
            49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63
        };
    }
};

}
#endif
