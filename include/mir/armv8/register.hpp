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
        return {
            32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
            49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
        }; // ARMReg::V0 = 32U
    }
    bool isCoreReg(unsigned int reg) const override {
        return reg < ARMReg::FP;
    }
    bool isFpOrVecReg(unsigned int reg) const override {
        return reg >= ARMReg::V0;
    }

    bool isCallerSaved(unsigned int reg) const override {
        return inRange(static_cast<ARMReg>(reg), ARMReg::X0, ARMReg::X18) ||
               inRange(static_cast<ARMReg>(reg), ARMReg::V0, ARMReg::V7)  ||
               inRange(static_cast<ARMReg>(reg), ARMReg::V16, ARMReg::V31);
    }

    bool isCalleeSaved(unsigned int reg) const override {
        return !isCallerSaved(reg); //
    }

    unsigned int FpOrVecStart() const override {
        return static_cast<unsigned int>(ARMReg::V0);
    }
    uint64_t initCalleeSaveBitmap() const override {
        return 0x60000000ULL; // fp & lr (default);
    }
    void updateCalleeSaveBitmapForStackAlloc(uint64_t& bitmap, MIRFunction* mfunc) const override {
        bitmap &= 0x0000ff007ff80000;

        if (mfunc->isProgramEntry()) {
            bitmap &= 0x60000000;
        }

        if (mfunc->isLeafFunc()) {
            bitmap &= ~0x20000000; // no lr
        }
    }
};

}
#endif
