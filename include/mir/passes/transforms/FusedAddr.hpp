// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#include "mir/MIR.hpp"
#include "mir/info.hpp"
#include "pass_manager/pass_manager.hpp"
#include <map>
#ifndef GNALC_MIR_TRANSFORMS_FUSEDADDR_HPP
#define GNALC_MIR_TRANSFORMS_FUSEDADDR_HPP

#include "mir/passes/pass_manager.hpp"

namespace MIR {

class FusedAddr : public PM::PassManager<FusedAddr> {

public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class FusedAddrImpl : public FusedAddr {
private:
    MIRFunction &mfunc;
    FAM &fam;
    CodeGenContext &ctx;

    std::map<MIRInst_p, MIROperand_p> ptrUse{};
    std::map<MIRInst_p, bool> withConstOff{};
    std::map<MIROperand_p, MIRInst_p> ptrDef{};

    struct gep {
        MIROperand_p baseptr = nullptr;
        MIROperand_p offset = nullptr;
        MIROperand_p shift = nullptr; // for A64, only lsl #3 is permitted
        bool if_giveup = false;
    };

    std::map<MIROperand_p, gep> ptrDetail;

    unsigned fusedtimes = 0;

public:
    FusedAddrImpl() = delete;
    FusedAddrImpl(MIRFunction &_mfunc, FAM &_fam, CodeGenContext &_ctx) : mfunc(_mfunc), fam(_fam), ctx(_ctx) {}
    void impl();
    ~FusedAddrImpl() = default;

private:
    void clear();
    void ptr_use_record();
    void ptr_def_record();
    bool fused_apply();
};
} // namespace MIR

#endif