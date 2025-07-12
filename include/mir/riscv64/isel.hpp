// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_RISCV64_ISEL_HPP
#define GNALC_MIR_RISCV64_ISEL_HPP

#include "mir/MIR.hpp"

namespace MIR {

class RVIselInfo : public ISelInfo {
public:
    bool isLegalGenericInst(MIRInst_p) const override;
    bool match(MIRInst_p, ISelContext &, bool allow) const override;
    bool legalizeInst(MIRInst_p minst, ISelContext &ctx) const override;
    void preLegalizeInst(InstLegalizeContext &) override;
    void legalizeWithPtrLoad(InstLegalizeContext &ctx, MIRInst_p minst) const override;
    void legalizeWithPtrStore(InstLegalizeContext &ctx, MIRInst_p minst) const override;
    void legalizeWithStkOp(InstLegalizeContext &ctx, MIROperand_p, const StkObj &obj) const override;
    void legalizeWithStkGep(InstLegalizeContext &ctx, MIROperand_p, const StkObj &obj) const override;
    void legalizeWithStkPtrCast(InstLegalizeContext &ctx, MIROperand_p, const StkObj &obj) const override;
    void legalizeCopy(InstLegalizeContext &ctx) const override;
    void legalizeAdrp(InstLegalizeContext &ctx) const override;

    ~RVIselInfo() override;
};

}
#endif
