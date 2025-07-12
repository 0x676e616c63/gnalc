// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_ARMv8_FRAME_HPP
#define GNALC_MIR_ARMv8_FRAME_HPP

#include "mir/MIR.hpp"

namespace MIR {
class ARMFrameInfo : public FrameInfo {
public:
    ~ARMFrameInfo() = default;

    void handleCallEntry(IR::pCall, LoweringContext &) const override;
    MIRGlobal_p handleLib(IR::pCall, LoweringContext &) const override;
    void handleMemset(IR::pCall, LoweringContext &) const override;
    void handleMemcpy(IR::pCall, LoweringContext &) const override;

    void makePrologue(MIRFunction_p, LoweringContext &) const override;
    void makeReturn(IR::pRet, LoweringContext &) const override;

    void makePostSAPrologue(MIRBlk_p, CodeGenContext &, unsigned) const override;
    void makePostSAEpilogue(MIRBlk_p, CodeGenContext &, unsigned) const override;
    void insertPrologueEpilogue(MIRFunction *, CodeGenContext &) const override;

    void appendCalleeSaveStackSize(uint64_t& allocationBase, uint64_t bitmap) const override;

    bool isCallerSaved(const MIROperand &op) const override;
    bool isCalleeSaved(const MIROperand &op) const override;
};
}

#endif
