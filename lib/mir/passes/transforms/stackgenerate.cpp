// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/passes/transforms/stackgenerate.hpp"
#include <algorithm>

using namespace MIR;

PM::PreservedAnalyses StackGenerate::run(MIRFunction &mfunc, FAM &fam) {
    StackGenerateImpl stackgenerate;

    stackgenerate.impl(mfunc, fam);

    return PM::PreservedAnalyses::all();
}

void StackGenerateImpl::impl(MIRFunction &_mfunc, FAM &fam) {
    mfunc = &_mfunc;

    auto allocationBase = 0UL;
    auto mkQWordAlign = [&allocationBase]() {
        unsigned align = 16;
        allocationBase = ((allocationBase + align - 1) / align) * align;
    }; // QWord in arm arch, I guess...

    // callee args
    for (auto &[mop, obj] : mfunc->StkObjs()) {

        if (obj.usage != StkObjUsage::CalleeArg) {
            continue;
        }

        /// handling multiple call args
        allocationBase = std::max(allocationBase, static_cast<size_t>(obj.offset) + static_cast<size_t>(obj.size));
    }

    mkQWordAlign();

    // callee-save
    mfunc->modifyBegCalleeSave(allocationBase);

    auto &bitmap = mfunc->calleeSaveRegs();
    bitmap &= 0x0000ff007ff80000;

    if (mfunc->isProgramEntry()) {
        bitmap &= 0x60000000;
    }

    if (mfunc->isLeafFunc()) {
        bitmap &= ~0x20000000; // no lr
    }

    auto calleesaves = bitmap;

    for (auto i = 0; i < 64; ++i, calleesaves >>= 1) {
        if (static_cast<ARMReg>(i) == ARMReg::V0) {
            ///@note start to stage V<>, make it ailgn
            allocationBase += allocationBase % 16 ? 8 : 0;
        }

        if (static_cast<ARMReg>(i) < ARMReg::V0 && calleesaves % 2) {
            allocationBase += 8; // X<>
        } else if (static_cast<ARMReg>(i) >= ARMReg::V0 && calleesaves % 2) {
            allocationBase += 16;
        }
    }

    mkQWordAlign();

    // spilled / local
    for (auto &[mop, obj] : mfunc->StkObjs()) {
        if (obj.usage != StkObjUsage::Local && obj.usage != StkObjUsage::Spill) {
            continue;
        }
        obj.offset = static_cast<int>(allocationBase);
        allocationBase += ((obj.size + obj.maxAlignment - 1) / obj.maxAlignment) * obj.maxAlignment;
    }

    mkQWordAlign();
    mfunc->modifyStkSize(allocationBase);

    // args
    for (auto &[mop, obj] : mfunc->StkObjs()) {
        if (obj.usage != StkObjUsage::Arg) {
            continue;
        }

        obj.offset += static_cast<int>(allocationBase);
    }

    // insert prologue/epilogue
    auto &ctx = mfunc->Context();

    ctx.frameInfo->insertPrologueEpilogue(mfunc, ctx);

    ctx.frameInfo->makePostSAPrologue(mfunc->blks().front(), ctx, allocationBase);

    for (auto &mblk : mfunc->ExitBlks()) {
        ctx.frameInfo->makePostSAEpilogue(mblk, ctx, allocationBase);
    }
}