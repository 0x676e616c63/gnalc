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
    // insert prologue/epilogue
    auto &ctx = mfunc->Context();
    auto& registerInfo = ctx.registerInfo;
    auto& frameInfo = ctx.frameInfo;

    auto allocationBase = 0UL;
    auto mkQWordAlign = [&allocationBase]() {
        unsigned align = 16;
        allocationBase = ((allocationBase + align - 1) / align) * align;
    }; // QWord in arm arch, I guess...

    // callee args
    for (auto &[mop, obj] : mfunc->StkObjs()) {
        if (obj.usage != StkObjUsage::CalleeArg)
            continue;

        /// handling multiple call args
        allocationBase = std::max(allocationBase, static_cast<size_t>(obj.offset) + static_cast<size_t>(obj.size));
    }

    mkQWordAlign();

    // callee-save
    mfunc->modifyBegCalleeSave(allocationBase);

    auto &bitmap = mfunc->calleeSaveRegs();
    registerInfo->updateCalleeSaveBitmapForStackAlloc(bitmap, mfunc);
    frameInfo->appendCalleeSaveStackSize(allocationBase, bitmap);

    mkQWordAlign();

    // We update Stack Offset of Local/Spill/Arg here.
    // For callee saved registers, ARMv8 use PUSH/POP, and
    // calculate the offset in ARMA64Printer::memoryPrinter.
    // While RISCV64 update the offset in insertPrologueEpilogue.
    // FIXME: Refactor this to make it more clear.

    // spilled / local
    for (auto &[mop, obj] : mfunc->StkObjs()) {
        if (obj.usage != StkObjUsage::Local && obj.usage != StkObjUsage::Spill)
            continue;

        obj.offset = static_cast<int>(allocationBase);
        allocationBase += ((obj.size + obj.maxAlignment - 1) / obj.maxAlignment) * obj.maxAlignment;
    }

    mkQWordAlign();
    mfunc->modifyStkSize(allocationBase);

    // Update argument offsets of current function since we've updated sp when entering prologue
    for (auto &[mop, obj] : mfunc->StkObjs()) {
        if (obj.usage != StkObjUsage::Arg)
            continue;

        obj.offset += static_cast<int>(allocationBase);
    }

    frameInfo->insertPrologueEpilogue(mfunc, ctx);

    frameInfo->makePostSAPrologue(mfunc->blks().front(), ctx, allocationBase);

    for (auto &mblk : mfunc->ExitBlks()) {
        frameInfo->makePostSAEpilogue(mblk, ctx, allocationBase);
    }
}