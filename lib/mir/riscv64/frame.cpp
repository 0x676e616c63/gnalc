// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/riscv64/frame.hpp"
#include "mir/MIR.hpp"
#include "mir/info.hpp"
#include "mir/passes/transforms/lowering.hpp"

using namespace MIR;

void RVFrameInfo::handleCallEntry(IR::pCall callinst, LoweringContext &ctx) const {
    auto callee = callinst->getFunc();

    using Attr = IR::FuncAttr;
    if (callee->hasFnAttr(Attr::isMemsetIntrinsic) || callee->hasFnAttr(Attr::isMemcpyIntrinsic))
        Err::not_implemented("This should be handled by LowerIntrinsicsPass in IR");
    if (callee->hasFnAttr(Attr::isSIMDIntrinsic))
        Err::todo("handleCallEntry: simd todo");

    // parallel/atomic here ...

    auto mcallee = callee->hasFnAttr(Attr::isSylib) || callee->hasFnAttr(Attr::ParallelEntry)
                       ? handleLib(callinst, ctx)
                       : ctx.mapGlobal(callee->getName());
    auto mcaller = ctx.CurrentBlk()->getFunction();

    // Since we've found a call here, the caller can't be a leaf function.
    mcaller->affirmNotLeafFunc();

    unsigned stkOffset = 0U;
    std::vector<int> offsets;

    int gprCnt = 0, fprCnt = 0;
    constexpr int passByRegBase = 0x10000000;
    constexpr int passByFprRegBase = 0x10000;
    constexpr auto isFpr = [](int offset) -> bool { return offset >= passByFprRegBase + passByRegBase; };

    for (auto &arg : callinst->getArgs()) {
        auto type = arg->getType();

        if (type->getTrait() == IR::IRCTYPE::PTR) {
            if (gprCnt < 8) {
                offsets.push_back(passByRegBase + (gprCnt++));
                continue;
            }
        } else if (type->getTrait() == IR::IRCTYPE::BASIC) {
            if (type->as<IR::BType>()->getInner() == IR::IRBTYPE::FLOAT) {
                if (fprCnt < 8) {
                    offsets.push_back(passByRegBase + passByFprRegBase + (fprCnt++));
                    continue;
                }
            } else {
                if (gprCnt < 8) {
                    offsets.push_back(passByRegBase + (gprCnt++));
                    continue;
                }
            }
        } else
            Err::unreachable("handleCallEntry: unknown arg type");

        const auto align = static_cast<unsigned>(arg->getType()->getBytes());
        auto minisize = 4U;
        unsigned size = (std::max)(minisize, align);

        stkOffset = ((stkOffset + align - 1) / align) * align;
        offsets.emplace_back(stkOffset);
        stkOffset += size;
    }

    // FIXME: Immediate issue. Currently all immediate are treated as 64-bit. But the function arguments
    //        must be handled with care, since caller may use stack to pass arguments.
    auto getType = [](const IR::pVal &arg) -> OpT {
        if (arg->getType()->getTrait() == IR::IRCTYPE::PTR)
            return OpT::Int64;

        auto btype = arg->getType()->as<IR::BType>();
        if (btype->getInner() == IR::IRBTYPE::FLOAT)
            return OpT::Float32;

        // TODO: add consistency check
        return OpT::Int32;
    };

    auto args = callinst->getArgs();

    // For arguments passed by stack
    for (int i = 0; i < args.size(); ++i) {
        auto offset = offsets[i];
        const auto &arg = args[i];

        if (offset >= passByRegBase)
            continue;

        auto mval = ctx.mapOperand(arg); // vreg or imme
        const auto size = static_cast<unsigned>(arg->getType()->getBytes());
        const auto align = 8U;
        const auto obj = mcaller->addStkObj(ctx.CodeGenCtx(), size, align, offset, StkObjUsage::CalleeArg);

        if (!mval->isVRegOrISAReg()) { // constant
            auto reg = ctx.newVReg(mval->type());
            ctx.addCopy(reg, mval);
            mval = reg;
        }

        ctx.newInst(MIRInst::make(OpC::InstStoreRegToStack)
                        ->setOperand<1>(mval, ctx.CodeGenCtx())
                        ->setOperand<2>(obj, ctx.CodeGenCtx())
                        ->setOperand<5>(MIROperand::asImme(getBitWide(getType(arg)), OpT::special), ctx.CodeGenCtx()));
    }

    // For arguments passed by register
    for (int i = 0; i < args.size(); ++i) {
        auto offset = offsets[i];
        const auto &arg = args[i];
        auto mval = ctx.mapOperand(arg);

        if (offset < passByRegBase)
            continue;

        auto isa = isFpr(offset) ? Util::to_underlying(RVReg::F10) +
                                       static_cast<uint32_t>(offset - passByRegBase - passByFprRegBase)
                                 : Util::to_underlying(RVReg::X10) + static_cast<uint32_t>(offset - passByRegBase);

        auto mtype = getType(arg);
        MIROperand_p marg = MIROperand::asISAReg(isa, mtype);
        ctx.addCopy(marg, mval); // choose copy code auto
    }

    auto mval = callinst->isVoid() ? nullptr : ctx.newVReg(getType(callinst));

    ctx.newInst(
        MIRInst::make(RVOpC::CALL)
            ->setOperand<1>(MIROperand::asReloc(mcallee->reloc()), ctx.CodeGenCtx())
            ->setOperand<2>(MIROperand::asImme(callinst->isTailCall() ? 1 : 0, OpT::special), ctx.CodeGenCtx()));

    if (mval) {
        auto mtype = getType(callinst);

        ctx.newInst(MIRInst::make(OpC::InstCopyFromReg)
                        ->setOperand<0>(mval, ctx.CodeGenCtx())
                        ->setOperand<1>(MIROperand::asISAReg(mtype == OpT::Float32 ? RVReg::F10 : RVReg::X10, mtype),
                                        ctx.CodeGenCtx()));
        ctx.addOperand(callinst, mval);
    }
}

MIRGlobal_p RVFrameInfo::handleLib(IR::pCall callinst, LoweringContext &ctx) const {
    const auto &layout = ctx.CodeGenCtx().infos.dataLayout;

    auto callee = callinst->getFunc();
    auto mfunc_declare = make<MIRFunction>(callee->getName().substr(1), ctx.CodeGenCtx());
    auto mcallee = make<MIRGlobal>(layout.codeAlignment, mfunc_declare);

    return mcallee;
}

void RVFrameInfo::handleMemset(IR::pCall callinst, LoweringContext &ctx) const {
    Err::not_implemented("This should be handled by LowerIntrinsicsPass in IR");
}

void RVFrameInfo::handleMemcpy(IR::pCall callinst, LoweringContext &ctx) const {
    Err::not_implemented("This should be handled by LowerIntrinsicsPass in IR");
}

void RVFrameInfo::makePrologue(MIRFunction_p mfunc, LoweringContext &ctx) const {
    const auto &args = mfunc->Args();
    unsigned stkoffset = 0L;

    std::vector<int> offsets;

    int gprCnt = 0, fprCnt = 0;

    auto getBytes = [](const OpT &type) -> unsigned {
        switch (type) {
        case OpT::Int32:
            return 4;
        case OpT::Int64:
            return 8;
        case OpT::Float32:
            return 4;
        default:
            Err::unreachable("makePrologue: unexpected type");
        }
        return 0;
    };

    // Divide an int into three ranges
    constexpr int passByRegBase = 0x10000000;
    constexpr int passByFprRegBase = 0x10000;
    constexpr auto isFpr = [](int offset) -> bool { return offset >= passByFprRegBase + passByRegBase; };

    for (const auto &arg : args) {
        auto type = arg->type();

        if (type == OpT::Int32 || type == OpT::Int64) {
            // a0 – a7
            if (gprCnt < 8) {
                offsets.push_back(passByRegBase + gprCnt++);
                continue;
            }
        } else if (type == OpT::Float32) {
            // fa0 - fa7
            if (fprCnt < 8) {
                offsets.push_back(passByFprRegBase + passByRegBase + fprCnt++);
                continue;
            }
        } else
            Err::unreachable();

        unsigned size = getBytes(arg->type());
        unsigned align = size;

        stkoffset = (stkoffset + align - 1) / align * align;
        offsets.emplace_back(stkoffset);
        stkoffset += size;
    }

    // For arguments passed by register
    for (int i = 0; i < args.size(); ++i) {
        auto offset = offsets[i];
        auto &arg = args[i];

        if (offset < passByRegBase)
            continue;

        auto isa = isFpr(offset) ? Util::to_underlying(RVReg::F10) +
                                       static_cast<uint32_t>(offset - passByRegBase - passByFprRegBase)
                                 : Util::to_underlying(RVReg::X10) + static_cast<uint32_t>(offset - passByRegBase);

        auto mtype = arg->type();
        MIROperand_p msrc = MIROperand::asISAReg(isa, mtype);
        ctx.addCopy(arg, msrc);
    }

    // For arguments passed by stack
    for (int i = 0; i < args.size(); ++i) {
        auto offset = offsets[i];
        const auto &arg = args[i];
        auto size = getBytes(arg->type());
        auto align = size;

        if (offset >= passByRegBase)
            continue;

        auto stkobj = mfunc->addStkObj(ctx.CodeGenCtx(), size, align, offset, StkObjUsage::Arg);

        ctx.newInst(MIRInst::make(OpC::InstLoadRegFromStack)
                        ->setOperand<0>(arg, ctx.CodeGenCtx())
                        ->setOperand<1>(stkobj, ctx.CodeGenCtx())
                        ->setOperand<5>(MIROperand::asImme(getBitWide(arg->type()), OpT::special), ctx.CodeGenCtx()));
    }
}

void RVFrameInfo::makeReturn(IR::pRet retinst, LoweringContext &ctx) const {
    if (retinst->getRetBType() == IR::IRBTYPE::VOID) {
        ctx.newInst(MIRInst::make(RVOpC::RET));
        return;
    }

    auto mval = ctx.mapOperand(retinst->getRetVal());
    auto type = retinst->getRetVal()->getType();
    unsigned isa = -1;
    OpT mtype;

    if (auto btype = type->as<IR::BType>()) {
        if (btype->getInner() == IR::IRBTYPE::I32) {
            isa = Util::to_underlying(RVReg::X10);
            mtype = OpT::Int32;
        } else if (btype->getInner() == IR::IRBTYPE::FLOAT) {
            isa = Util::to_underlying(RVReg::F10);
            mtype = OpT::Float32;
        } else
            Err::not_implemented();
    } else
        Err::not_implemented();

    auto mret = MIROperand::asISAReg(isa, mtype);
    ctx.addCopy(mret, mval);
    ctx.newInst(MIRInst::make(RVOpC::RET));
}

void RVFrameInfo::appendCalleeSaveStackSize(uint64_t &allocationBase, uint64_t calleesaves) const {
    for (int i = 0; i < 64; ++i, calleesaves >>= 1) {
        if (!(calleesaves & 1))
            continue;

        allocationBase += 8;
    }
}

bool RVFrameInfo::isFuncCall(const MIRInst_p &inst) const {
    return inst->isRV() &&(inst->opcode<RVOpC>() == RVOpC::CALL || inst->opcode<RVOpC>() == RVOpC::JAL);
}

void RVFrameInfo::makePostSAPrologue(MIRBlk_p entry, CodeGenContext &ctx, unsigned stkSize) const {
    if (RV64::is12BitImm(stkSize, 64)) {
        entry->Insts().emplace_front(
            MIRInst::make(OpC::InstSub)
                ->setOperand<0>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx)
                ->setOperand<1>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx)
                ->setOperand<2>(MIROperand::asImme(static_cast<int>(stkSize), OpT::Int64), ctx));
    } else {
        // 注意 emplace_front 顺序
        auto scratch = MIROperand::asISAReg(RVReg::FP, OpT::Int64);
        entry->Insts().emplace_front(MIRInst::make(OpC::InstSub)
                                         ->setOperand<0>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx)
                                         ->setOperand<1>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx)
                                         ->setOperand<2>(scratch, ctx));
        entry->Insts().emplace_front(MIRInst::make(RVOpC::LI)
                                         ->setOperand<0>(scratch, ctx)
                                         ->setOperand<1>(MIROperand::asImme(stkSize, OpT::Int64), ctx));
    }
}

void RVFrameInfo::makePostSAEpilogue(MIRBlk_p entry, CodeGenContext &ctx, unsigned stkSize) const {
    auto iter = std::prev(entry->Insts().end());
    Err::gassert((*iter)->opcode<RVOpC>() == RVOpC::RET, "ret not found");
    if (RV64::is12BitImm(stkSize, 64)) {
        entry->Insts().emplace(iter,
                               MIRInst::make(OpC::InstAdd)
                                   ->setOperand<0>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx)
                                   ->setOperand<1>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx)
                                   ->setOperand<2>(MIROperand::asImme(static_cast<int>(stkSize), OpT::Int64), ctx));
    } else {
        auto scratch = MIROperand::asISAReg(RVReg::FP, OpT::Int64);
        // 注意 emplace 顺序
        entry->Insts().emplace(iter, MIRInst::make(RVOpC::LI)
                                         ->setOperand<0>(scratch, ctx)
                                         ->setOperand<1>(MIROperand::asImme(stkSize, OpT::Int64), ctx));
        entry->Insts().emplace(iter, MIRInst::make(OpC::InstAdd)
                                         ->setOperand<0>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx)
                                         ->setOperand<1>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx)
                                         ->setOperand<2>(scratch, ctx));
    }
}

void RVFrameInfo::insertPrologueEpilogue(MIRFunction *mfunc, CodeGenContext &ctx) const {
    // insert prologue
    auto &mblk_entry = mfunc->EntryBlk();
    auto &entry_insts = mblk_entry->Insts();

    uint64_t bitmap = mfunc->calleeSaveRegs();
    auto offset = mfunc->begCalleeSave();
    for (int i = 0; i < 64; ++i, bitmap >>= 1) {
        if (bitmap & 1) {
            auto obj = mfunc->addStkObj(mfunc->Context(), 8, 8, offset, StkObjUsage::CalleeSave);
            entry_insts.emplace_front(
                MIRInst::make(OpC::InstStoreRegToStack)
                    ->setOperand<1>(MIROperand::asISAReg(static_cast<RVReg>(i), i < 32 ? OpT::Int : OpT::Float), ctx)
                    ->setOperand<2>(obj, ctx)
                    ->setOperand<5>(MIROperand::asImme(8, OpT::Int64), ctx));
            offset += 8;
        }
    }

    // insert epilogue
    for (auto &mblk_exit : mfunc->ExitBlks()) {
        offset = mfunc->begCalleeSave();
        bitmap = mfunc->calleeSaveRegs();

        auto &insts = mblk_exit->Insts();
        auto it = std::prev(insts.end());
        Err::gassert((*it)->opcode<RVOpC>() == RVOpC::RET, "ret not found");
        for (int i = 0; i < 64; ++i, bitmap >>= 1) {
            if (bitmap & 1) {
                const auto obj = mfunc->addStkObj(mfunc->Context(), 8, 8, offset, StkObjUsage::CalleeSave);
                insts.emplace(
                    it, MIRInst::make(OpC::InstLoadRegFromStack)
                            ->setOperand<0>(MIROperand::asISAReg(static_cast<RVReg>(i), i < 32 ? OpT::Int : OpT::Float),
                                            ctx)
                            ->setOperand<1>(obj, ctx)
                            ->setOperand<5>(MIROperand::asImme(8, OpT::Int64), ctx));
                offset += 8;
            }
        }
    }
}
