// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_ARMV8_REGISTER_HPP
#define GNALC_MIR_ARMV8_REGISTER_HPP

#include "mir/MIR.hpp"

namespace MIR {

class ARMRegisterInfo : public RegisterInfo {
public:
    ~ARMRegisterInfo() override = default;

    unsigned getCoreRegisterNum() const override {
        return 30; // X0 ~ X29
    }
    unsigned getFpOrVecRegisterNum() const override {
        return 32; // V0 ~ V31
    }
    std::set<int> getCoreRegisterAllocationList() const override {
        return {
            0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14,
            15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, // no fp
        };
    }
    std::set<int> getFpOrVecRegisterAllocationList() const override {
        // FIXME: Is there a bug??
        static_assert(static_cast<uint32_t>(ARMReg::V0) == 32);
        return {
            33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
            49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
        }; // ARMReg::V0 = 33U
    }
};

}
#endif
