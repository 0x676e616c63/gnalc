// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_RISCV64_REGISTER_HPP
#define GNALC_MIR_RISCV64_REGISTER_HPP

#include "mir/MIR.hpp"

namespace MIR {
class RVRegisterInfo : public RegisterInfo {

    static constexpr auto RVREG_CORE_ALLOCATION = {
        // x0, x1(ra), x2(sp), x3(gp), x4(tp)
        5, 6, 7, // x5 - x7
        // x8(fp)
        9, 10, 11, 12, 13, 14, 15, 16, 17, 18,             // x9 - x18
        19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 // x19 - x31
    };

    // f0 - f31
    static constexpr auto RVREG_FP_ALLOCATION = {32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
                                                 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63};

public:
    ~RVRegisterInfo() override = default;
    unsigned getCoreRegisterNum() const override { return RVREG_CORE_ALLOCATION.size(); }
    unsigned getFpOrVecRegisterNum() const override { return RVREG_FP_ALLOCATION.size(); }
    std::set<int> getCoreRegisterAllocationList() const override { return RVREG_CORE_ALLOCATION; }
    std::set<int> getFpOrVecRegisterAllocationList() const override { return RVREG_FP_ALLOCATION; }
    bool isCoreReg(unsigned int reg) const override { return reg == RVReg::X1 || inRange(reg, RVReg::X3, RVReg::X31); }
    bool isFpOrVecReg(unsigned int reg) const override { return inRange(reg, RVReg::F0, RVReg::F31); }
    unsigned int FpOrVecStart() const override { return static_cast<unsigned int>(RVReg::F0); }
    uint64_t initCalleeSaveBitmap() const override {
        return 0b0000000000000000000000100000010; // RA & FP (default)
    }
    void updateCalleeSaveBitmapForStackAlloc(uint64_t &bitmap, MIRFunction *mfunc) const override {
        static constexpr uint64_t rv_callee_save_mask =
            // ra
            (1ull << 1) |
            //  x8, x9, x18-x27
            (1ull << 8) |
            (1ull << 9) |
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
