// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/passes/transforms/PreRAlegalize.hpp"
#include "mir/tools.hpp"

using namespace MIR;

PM::PreservedAnalyses PreRAlegalize::run(MIRFunction &mfunc, FAM &fam) {
    preLegalizeFuncImpl(mfunc, mfunc.Context());

    return PM::PreservedAnalyses::all();
}

void MIR::preLegalizeFuncImpl(MIRFunction &mfunc, CodeGenContext &ctx) {

    for (auto &mblk : mfunc.blks()) {

        auto &minsts = mblk->Insts();
        for (auto iter = minsts.begin(); iter != minsts.end();) {
            auto recovery = iter;

            InstLegalizeContext _ctx{*iter, minsts, iter, ctx, mblk};
            ctx.iselInfo->preLegalizeInst(_ctx);

            recovery == iter ? void(iter = ++recovery) : nop;
        }
    }
}
