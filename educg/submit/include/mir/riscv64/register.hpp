// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_RISCV64_REGISTER_HPP
#define GNALC_MIR_RISCV64_REGISTER_HPP

#include "../MIR.hpp"

namespace MIR {
class RVRegisterInfo : public RegisterInfo {

    static constexpr auto RVREG_CORE_ALLOCATION = {
        // x0, x1(ra), x2(sp), x3(gp), x4(tp)
        5, 6, 7, // x5 - x7
        // x8(fp)
        9, 10, 11, 12, 13, 14, 15, 16, 17, 18,             // x9 - x18
        19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 // x19 - x31
    };

    static constexpr auto RVREG_CORE_CALLER_SAVE = {
        5,  6,  7,              // x5 - x7
        10, 11,                 // x10 - x11
        12, 13, 14, 15, 16, 17, // x12 - x17
        28, 29, 30, 31          // x28 - x31
    };

    // f0 - f31
    static constexpr auto RVREG_FP_ALLOCATION = {32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
                                                 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63};

    static constexpr auto RVREG_FP_CALLER_SAVE = {
        32, 33, 34, 35, 36, 37, 38, 39, // f0 - f7
        42, 43,                         // f10 - f11
        44, 45, 46, 47, 48, 49,         // f12 - f17
        60, 61, 62, 63                  // f28 - f31
    };

public:
    ~RVRegisterInfo() override = default;
    unsigned getCoreRegisterNum() const override { return RVREG_CORE_ALLOCATION.size(); }
    unsigned getFpOrVecRegisterNum() const override { return RVREG_FP_ALLOCATION.size(); }
    std::set<int> getCoreRegisterAllocationList() const override { return RVREG_CORE_ALLOCATION; }
    std::set<int> getFpOrVecRegisterAllocationList() const override { return RVREG_FP_ALLOCATION; }
    std::set<int> getCallerSaveCRs() const override { return RVREG_CORE_CALLER_SAVE; }
    std::set<int> getCallerSaveFpVRs() const override { return RVREG_FP_CALLER_SAVE; }
    bool isCoreReg(unsigned int reg) const override { return reg == RVReg::X1 || inRange(reg, RVReg::X3, RVReg::X31); }
    bool isFpOrVecReg(unsigned int reg) const override { return inRange(reg, RVReg::F0, RVReg::F31); }

    bool isCallerSaved(unsigned int reg) const override {
        return reg == RVReg::X1 || inRange(reg, RVReg::X5, RVReg::X7) || inRange(reg, RVReg::X10, RVReg::X17) ||
               inRange(reg, RVReg::X28, RVReg::X31) || inRange(reg, RVReg::F0, RVReg::F7) ||
               inRange(reg, RVReg::F10, RVReg::F17) || inRange(reg, RVReg::F28, RVReg::F31);
    }

    bool isCalleeSaved(unsigned int reg) const override {
        if (reg == RVReg::X0 || reg == RVReg::X3 || reg == RVReg::X4)
            return false;
        return !isCallerSaved(reg);
    }

    unsigned int FpOrVecStart() const override { return static_cast<unsigned int>(RVReg::F0); }
    uint64_t initCalleeSaveBitmap() const override {
        return 0b0000000000000000000000100000010; // RA & FP (default)
    }
    void updateCalleeSaveBitmapForStackAlloc(uint64_t &bitmap, MIRFunction *mfunc) const override {
        static constexpr uint64_t rv_callee_save_mask =
            // ra
            (1ull << 1) |
            //  x8, x9, x18-x27
            (1ull << 8) | (1ull << 9) |
            (((1ull << 10) - 1) << 18)
            // f8, f9, f18-f27
            | (1ull << (32 + 8)) | (1ull << (32 + 9)) | (((1ull << 10) - 1) << (32 + 18));

        bitmap &= rv_callee_save_mask;

        if (mfunc->isLeafFunc())
            bitmap &= ~(1ull << 1); // no ra
    }
};

} // namespace MIR
#endif
