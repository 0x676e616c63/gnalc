// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../include/mir/armv8/frame.hpp"
#include "../../../include/ir/base.hpp"
#include "../../../include/ir/type.hpp"
#include "../../../include/mir/MIR.hpp"
#include "../../../include/mir/info.hpp"
#include "../../../include/mir/passes/transforms/lowering.hpp"

using namespace MIR;

void ARMFrameInfo::handleCallEntry(IR::pCall callinst, LoweringContext &ctx) const {
    ///@todo TCO, TCR
    ctx.CurrentBlk()->getFunction()->affirmNotLeafFunc();

    auto callee = callinst->getFunc();

    using Attr = IR::FuncAttr;
    if (callee->hasAttr(Attr::isMemsetIntrinsic)) {
        handleMemset(callinst, ctx);
        return;
    } else if (callee->hasAttr(Attr::isMemcpyIntrinsic)) {
        handleMemcpy(callinst, ctx);
        return;
    } else if (callee->hasAttr(Attr::isSIMDIntrinsic)) {
        Err::todo("handleCallEntry: simd todo");
    }

    ///@brief callee->hasAttr(Attr::NotBuiltin)
    auto mcallee = callee->hasAttr(Attr::isSylib) || callee->hasAttr(Attr::ParallelEntry)
                       ? handleLib(callinst, ctx)
                       : ctx.mapGlobal(callee->getName());

    auto mcaller = ctx.CurrentBlk()->getFunction();

    unsigned stkOffset = 0U; // stk offset
    std::vector<int> offsets;

    int gprCnt = 0, sprCnt = 0;
    int passByRegBase = 0x10000000;
    int passBySprRegBase = 0x21; // 0 ~ 32

    for (auto &arg : callinst->getArgs()) {
        auto type = arg->getType();

        // ptr & func ptr
        if (type->getTrait() == IR::IRCTYPE::PTR || type->getTrait() == IR::IRCTYPE::FUNCTION) {
            if (gprCnt < 8) {
                offsets.push_back(passByRegBase + (gprCnt++));
                continue;
            }
        } else if (type->getTrait() == IR::IRCTYPE::BASIC) {
            if (type->as<IR::BType>()->getInner() == IR::IRBTYPE::FLOAT) {
                if (sprCnt < 16) {
                    offsets.push_back(passByRegBase + passBySprRegBase + (sprCnt++));
                    continue;
                }
            } else {
                if (gprCnt < 8) {
                    offsets.push_back(passByRegBase + (gprCnt++));
                    continue;
                }
            }
        } else {
            Err::unreachable("handleCallEntry: unknown arg type");
        }

        const auto align = static_cast<unsigned>(arg->getType()->getBytes());
        auto minisize = 4U; // avoid clang-tidy warning
        unsigned size = std::max(minisize, align);

        stkOffset = ((stkOffset + align - 1) / align) * align;
        offsets.emplace_back(stkOffset);
        stkOffset += size;
    }

    auto args = callinst->getArgs();

    // FIXME: Immediate issue. Currently all immediate are treated as 64-bit. But the function arguments
    //        must be handled with care, since caller may use stack to pass arguments.
    auto getType = [](const IR::pVal &arg) -> OpT {
        if (inSet(arg->getType()->getTrait(), IR::IRCTYPE::PTR, IR::IRCTYPE::FUNCTION))
            return OpT::Int64;

        auto btype = arg->getType()->as<IR::BType>();
        if (btype->getInner() == IR::IRBTYPE::FLOAT)
            return OpT::Float32;

        // TODO: add consistency check
        return OpT::Int32;
    };

    ///@note arg on stk
    for (int i = 0; i < args.size(); ++i) {
        const auto offset = offsets[i];
        const auto &arg = args[i];
        MIROperand_p mval = ctx.mapOperand(arg);
        const auto size =
            arg->getType()->getTrait() == IR::IRCTYPE::FUNCTION ? 8 : static_cast<unsigned>(arg->getType()->getBytes());

        const auto align = 8U;

        if (offset >= passByRegBase) {
            continue; // arg in regs
        }

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

    // LAMBDA BEGIN

    auto isSpr = [&passByRegBase, &passBySprRegBase](int offset) -> bool {
        return offset >= passBySprRegBase + passByRegBase;
    };
    // LAMBDA END

    ///@note arg in ISAreg

    for (int i = 0; i < args.size(); ++i) {
        const auto offset = offsets[i];
        const auto arg = args[i];
        auto mval = ctx.mapOperand(arg);

        if (offset < passByRegBase) {
            continue; // arg on stk
        }

        auto isa = isSpr(offset) ? Util::to_underlying(ARMReg::V0) +
                                       static_cast<uint32_t>(offset - passByRegBase - passBySprRegBase)
                                 : Util::to_underlying(ARMReg::X0) + static_cast<uint32_t>(offset - passByRegBase);

        auto mtype = getType(arg);

        MIROperand_p marg = MIROperand::asISAReg(isa, mtype);

        ctx.addCopy(marg, mval); // choose copy code auto
    }

    ///@note emit call(bl)
    auto mval = callinst->isVoid() ? nullptr : ctx.newVReg(getType(callinst));

    ///@todo emit tcp
    ctx.newInst(
        MIRInst::make(ARMOpC::BL)
            ->setOperand<0>(nullptr, ctx.CodeGenCtx())
            ->setOperand<1>(MIROperand::asReloc(mcallee->reloc()), ctx.CodeGenCtx())
            ->setOperand<2>(MIROperand::asImme(callinst->isTailCall() ? 1 : 0, OpT::special), ctx.CodeGenCtx()));

    if (mval) {
        ///@brief return not a void
        auto mtype = getType(callinst); // todo: ret val vectorize

        ctx.newInst(MIRInst::make(OpC::InstCopyFromReg)
                        ->setOperand<0>(mval, ctx.CodeGenCtx())
                        ->setOperand<1>(MIROperand::asISAReg(mtype == OpT::Float32 ? ARMReg::V0 : ARMReg::X0, mtype),
                                        ctx.CodeGenCtx()));
        ///@todo vectorize

        ctx.addOperand(callinst, mval);
    }
}

MIRGlobal_p ARMFrameInfo::handleLib(IR::pCall callinst, LoweringContext &ctx) const {
    const auto &layout = ctx.CodeGenCtx().infos.dataLayout;

    auto callee = callinst->getFunc();
    auto mfunc_declare = make<MIRFunction>(callee->getName().substr(1), ctx.CodeGenCtx());
    auto mcallee = make<MIRGlobal>(layout.codeAlignment, mfunc_declare);

    return mcallee;
}

void ARMFrameInfo::handleMemset(IR::pCall callinst, LoweringContext &ctx) const {
    const auto &layout = ctx.CodeGenCtx().infos.dataLayout;

    auto callee = callinst->getFunc();
    // turn LLVM builtin into Glibc stdlib
    auto mfunc_declare = make<MIRFunction>("memset", ctx.CodeGenCtx());
    auto mcallee = make<MIRGlobal>(layout.codeAlignment, mfunc_declare);

    ///@note arg in ISAreg
    auto args = callinst->getArgs();

    ctx.addCopy(MIROperand::asISAReg(ARMReg::X0, OpT::Int64), ctx.mapOperand(args[0]));
    ctx.addCopy(MIROperand::asISAReg(ARMReg::X1, OpT::Int32), ctx.mapOperand(args[1]));
    ctx.addCopy(MIROperand::asISAReg(ARMReg::X2, OpT::Int32), ctx.mapOperand(args[2]));

    ///@note emit call(bl)
    ///@todo emit tcp
    ctx.newInst(
        MIRInst::make(ARMOpC::BL)
            ->setOperand<0>(nullptr, ctx.CodeGenCtx())
            ->setOperand<1>(MIROperand::asReloc(mcallee->reloc()), ctx.CodeGenCtx())
            ->setOperand<2>(MIROperand::asImme(callinst->isTailCall() ? 1 : 0, OpT::special), ctx.CodeGenCtx()));

    // non-return;
}

void ARMFrameInfo::handleMemcpy(IR::pCall callinst, LoweringContext &ctx) const {
    const auto &layout = ctx.CodeGenCtx().infos.dataLayout;

    auto callee = callinst->getFunc();
    // turn LLVM builtin into Glibc stdlib
    auto mfunc_declare = make<MIRFunction>("memcpy", ctx.CodeGenCtx());
    auto mcallee = make<MIRGlobal>(layout.codeAlignment, mfunc_declare);

    ///@note arg in ISAreg
    auto args = callinst->getArgs();

    ctx.addCopy(MIROperand::asISAReg(ARMReg::X0, OpT::Int64), ctx.mapOperand(args[0]));
    ctx.addCopy(MIROperand::asISAReg(ARMReg::X1, OpT::Int64), ctx.mapOperand(args[1]));
    ctx.addCopy(MIROperand::asISAReg(ARMReg::X2, OpT::Int32), ctx.mapOperand(args[2]));

    ///@note emit call(bl)
    ///@todo emit tcp
    ctx.newInst(
        MIRInst::make(ARMOpC::BL)
            ->setOperand<0>(nullptr, ctx.CodeGenCtx())
            ->setOperand<1>(MIROperand::asReloc(mcallee->reloc()), ctx.CodeGenCtx())
            ->setOperand<2>(MIROperand::asImme(callinst->isTailCall() ? 1 : 0, OpT::special), ctx.CodeGenCtx()));

    // non-return;
}

/// @note load args from reg or stk
void ARMFrameInfo::makePrologue(MIRFunction_p mfunc, LoweringContext &ctx) const {
    const auto &args = mfunc->Args();
    unsigned stkoffset = 0L;

    std::vector<unsigned> offsets;

    int gprCnt = 0, sprCnt = 0;

    int passByRegBase = 0x10000000;
    int passBySprRegBase = 0x20; // x<0 - 31> + XZR

    // LAMBDA BEGIN

    auto getBytes = [](const OpT &type) -> unsigned {
        switch (type) {
        case OpT::Int32:
            return 4;
        case OpT::Int64:
            return 8;
        case OpT::Float32:
            return 4;
        case OpT::Floatvec4:
            return 16;
        default:
            Err::unreachable("makePrologue: unknown type");
        }
        return 4; // just to make clang happy
    };

    // LAMBDA END

    for (auto &arg : args) {
        auto type = arg->type();

        if (type == OpT::Int32 || type == OpT::Int64) {
            if (gprCnt < 8) {
                offsets.push_back(passByRegBase + gprCnt++);
                continue;
            }
        } else if (type == OpT::Float32) {

            if (sprCnt < 16) {
                offsets.push_back(passByRegBase + passBySprRegBase + sprCnt++);
                continue;
            }
        }
        ///@todo vectorize

        unsigned size = getBytes(arg->type()); // avoid clang-tidy warning
        unsigned align = size;

        stkoffset = (stkoffset + align - 1) / align * align; // 强制对齐
        offsets.emplace_back(stkoffset);
        stkoffset += size;
    }

    for (int i = 0; i < args.size(); ++i) {
        auto offset = offsets[i];
        auto &arg = args[i];

        if (offset < passByRegBase) {
            continue;
        }

        auto isa =
            (offset >= passBySprRegBase + passByRegBase)
                ? Util::to_underlying(ARMReg::V0) + static_cast<uint32_t>(offset - passByRegBase - passBySprRegBase)
                : Util::to_underlying(ARMReg::X0) + static_cast<uint32_t>(offset - passByRegBase);

        auto mtype = arg->type();

        MIROperand_p msrc = MIROperand::asISAReg(isa, mtype);

        ctx.addCopy(arg, msrc);
    }

    for (int i = 0; i < args.size(); ++i) {
        const auto offset = static_cast<int>(offsets[i]); // just to avoid clang-tidy warning
        auto &arg = args[i];
        auto size = getBytes(arg->type());
        auto align = size;

        if (offset >= passByRegBase) {
            continue;
        }

        auto stkobj = mfunc->addStkObj(ctx.CodeGenCtx(), size, align, offset, StkObjUsage::Arg);

        ctx.newInst(MIRInst::make(OpC::InstLoadRegFromStack)
                        ->setOperand<0>(arg, ctx.CodeGenCtx())
                        ->setOperand<1>(stkobj, ctx.CodeGenCtx())
                        ->setOperand<5>(MIROperand::asImme(getBitWide(arg->type()), OpT::special), ctx.CodeGenCtx()));
        // addOperand already
    }
}

void ARMFrameInfo::makeReturn(IR::pRet retinst, LoweringContext &ctx) const {

    // if (retinst->getType()->as<IR::BType>()->getInner() == IR::IRBTYPE::VOID) {
    //     ctx.newInst(MIRInst::make(ARMOpC::RET));
    // }
    if (retinst->getRetBType() == IR::IRBTYPE::VOID) {
        ctx.newInst(MIRInst::make(ARMOpC::RET));
    } else {
        auto mval = ctx.mapOperand(retinst->getRetVal());
        auto type = retinst->getRetVal()->getType();
        unsigned isa = -1;
        OpT mtype;

        if (auto btype = type->as<IR::BType>()) {
            if (btype->getInner() == IR::IRBTYPE::FLOAT) {
                isa = Util::to_underlying(ARMReg::V0);
                mtype = OpT::Float32;
            } else {
                isa = Util::to_underlying(ARMReg::X0);
                mtype = OpT::Int32;
            }
        }
        ///@todo vectorize

        auto mret = MIROperand::asISAReg(isa, mtype);

        ctx.addCopy(mret, mval);
        ctx.newInst(MIRInst::make(ARMOpC::RET)); // just use ret
    }
}

void ARMFrameInfo::appendCalleeSaveStackSize(uint64_t &allocationBase, uint64_t calleesaves) const {
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
}

bool ARMFrameInfo::isFuncCall(const MIRInst_p &inst) const {
    return inst->isARM() && inst->opcode<ARMOpC>() == ARMOpC::BL;
}

void ARMFrameInfo::makePostSAPrologue(MIRBlk_p entry, CodeGenContext &ctx, unsigned stkSize) const {

    auto &insts = entry->Insts();

    auto iter = insts.end();
    for (auto it = insts.begin(); it != insts.end(); ++it) {
        if (!it->get()->isGeneric() && it->get()->opcode<ARMOpC>() == ARMOpC::PUSH) {
            iter = it;
            break;
        }
    }

    Err::gassert(iter != insts.end(), "makePostSAPrologue: cant find reg save insts");

    ARMInstTemplate::registerDec(insts, iter, ARMReg::SP, stkSize, ctx);
}

void ARMFrameInfo::makePostSAEpilogue(MIRBlk_p entry, CodeGenContext &ctx, unsigned stkSize) const {

    auto &insts = entry->Insts();
    bool find = false;

    auto iter = insts.end();
    for (auto it = insts.begin(); it != insts.end(); ++it) {
        if (!it->get()->isGeneric() && it->get()->opcode<ARMOpC>() == ARMOpC::POP) {
            iter = std::next(it);
            find = true;
            break;
        }
    }

    Err::gassert(find, "makePostSAEpilogue: cant find reg recover insts");

    // stk space gen
    ARMInstTemplate::registerInc(insts, iter, ARMReg::SP, stkSize, ctx);
}

void ARMFrameInfo::insertPrologueEpilogue(MIRFunction *mfunc, CodeGenContext &ctx) const {

    // 30 + 1 + 1 + 32 = 64
    // X<>: 0 ~ 30, SP: 31, PC: 32, V<>: 33~64
    const uint64_t &bitmap = mfunc->calleeSaveRegs();

    // insert prologue
    auto &mblk_entry = mfunc->EntryBlk();

    auto &insts = mblk_entry->Insts();

    insts.emplace_front(
        MIRInst::make(ARMOpC::PUSH)->setOperand<1>(MIROperand::asImme(bitmap, OpT::special), ctx)); // immeEx

    // insert epilogue
    for (auto &mblk_exit : mfunc->ExitBlks()) {
        auto &insts = mblk_exit->Insts();

        auto &mret = insts.back();
        Err::gassert(mret->opcode<ARMOpC>() == ARMOpC::RET, "insertPrologueEpilogue: exit blk not ends with ret inst");

        auto it = std::prev(insts.end());

        insts.insert(it, MIRInst::make(ARMOpC::POP)->setOperand<1>(MIROperand::asImme(bitmap, OpT::special), ctx));
    }
}
