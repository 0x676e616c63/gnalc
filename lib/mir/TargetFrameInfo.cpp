#include "mir/MIR.hpp"
#include "mir/Target.hpp"
#include "mir/passes/transforms/lowering.hpp"

using namespace MIR_new;

void TargetFrameInfo::emitCall(IR::pCall callinst, LoweringContext &ctx) const {
    ///@note TCO, TCR
    ctx.CurrentBlk()->getFunction()->affirmNotLeafFunc();

    auto callee = callinst->getFunc();
    auto mcallee = ctx.mapGlobal(callee->getName());
    auto mcaller = ctx.CurrentBlk()->getFunction();

    const auto &layOut = ctx.CodeGenCtx().target.dataLayOut;

    unsigned stkOffset = 0U; // stk offset
    std::vector<int> offsets;

    int gprCnt = 0, sprCnt = 0;
    int passByRegBase = 0x10000000;
    int passBySprRegBase = 0x21; // 0 ~ 32

    ///@note ptr和int类共享gpr, 但是ptr需要x<>, 但int只需要w<>
    for (auto &arg : callinst->getArgs()) {
        auto type = arg->getType();

        ///@todo 由于Armv8的s<>和v<>是同一个寄存器组的不同视图, 所以这里理论上可以实现用寄存器传递向量参数
        if (type->getTrait() == IR::IRCTYPE::PTR) {
            if (gprCnt < 8) {
                offsets.push_back(passByRegBase + gprCnt++);
                continue;
            }
        } else if (type->getTrait() == IR::IRCTYPE::BASIC) {
            if (type->as<IR::BType>()->getInner() == IR::IRBTYPE::FLOAT) {
                if (sprCnt < 16) {
                    offsets.push_back(passByRegBase + passBySprRegBase + sprCnt++);
                    continue;
                }
            } else {
                if (gprCnt < 8) {
                    offsets.push_back(passByRegBase + gprCnt++);
                    continue;
                }
            }
        }
        ///@todo vectorize

        ///@note 可能的size为4, 8, 16(vector)
        const auto align = static_cast<unsigned>(arg->getType()->getBytes());
        auto minisize = 4U; // avoid clang-tidy warning
        unsigned size = std::max(size, align);

        stkOffset = (stkOffset + align - 1) / align * align; // 强制对齐
        offsets.emplace_back(stkOffset);
        stkOffset += size;
    }

    auto args = callinst->getArgs();

    ///@note arg on stk
    for (int i = 0; i < args.size(); ++i) {
        const auto offset = offsets[i];
        const auto arg = args[i];
        auto mval = ctx.mapOperand(arg); // vreg or imme
        const auto size = static_cast<unsigned>(arg->getType()->getBytes());
        const auto align = 8U;

        if (offset > passByRegBase) {
            continue;
        }

        const auto obj = mcaller->addStkObj(ctx.CodeGenCtx(), size, align, offset, StkObjUsage::CalleeArg);

        if (!mval->isVRegOrISAReg()) { // constant
            auto reg = ctx.newVReg(mval->type());
            ctx.emitCopy(reg, mval);
            mval = reg;
        }

        ctx.emitInst(MIRInst::make(OpC::InstStoreRegToStack)->setOperand<0>(mval)->setOperand<1>(obj));
    }

    // LAMBDA BEGIN

    auto isSpr = [&passByRegBase, &passBySprRegBase](int offset) -> bool {
        return offset >= passBySprRegBase + passByRegBase;
    };
    auto getType = [](const IR::pVal &arg) -> OpT {
        if (arg->getType()->getTrait() == IR::IRCTYPE::PTR) {
            return OpT::Int64;
        } else {
            auto btype = arg->getType()->as<IR::BType>();
            if (btype->getInner() == IR::IRBTYPE::FLOAT) {
                return OpT::Float32;
            } else {
                return OpT::Int32;
            }
        }

        ///@todo vectorize
    };

    // LAMBDA END

    ///@note arg in ISAreg

    for (int i = 0; i < args.size(); ++i) {
        const auto offset = offsets[i];
        const auto arg = args[i];
        auto mval = ctx.mapOperand(arg);

        if (offset < passByRegBase) {
            continue;
        }

        auto isa = isSpr(offset) ? ARMReg::V0 + static_cast<uint32_t>(offset - passByRegBase - passBySprRegBase)
                                 : ARMReg::X0 + static_cast<uint32_t>(offset - passByRegBase);

        auto mtype = getType(arg);

        MIROperand_p marg = MIROperand::asISAReg(isa, mtype);

        ctx.emitCopy(marg, mval); // choose copy code auto
    }

    ///@note emit call(bl)
    auto mval = callinst->isVoid() ? nullptr : ctx.newVReg(getType(callinst));

    ///@todo emit tcp
    ctx.emitInst(MIRInst::make(ARMOpC::BL)
                     ->setOperand<0>(nullptr)
                     ->setOperand<1>(MIROperand::asReloc(mcallee->reloc()))
                     ->setOperand<2>(MIROperand::asImme(callinst->isTailCall() ? 1 : 0, OpT::special)));

    auto mtype = getType(callinst);

    ctx.emitInst(MIRInst::make(OpC::InstCopyFromReg)
                     ->setOperand<0>(mval)
                     ->setOperand<1>(MIROperand::asISAReg(mtype == OpT::Float32 ? ARMReg::V0 : ARMReg::X0, mtype)));
    ///@todo vectorize

    ctx.addOperand(callinst, mval);
}

/// @note load args from reg or stk
void TargetFrameInfo::emitPrologue(MIRFunction_p mfunc, LoweringContext &ctx) const {
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
        case OpT::Floatvec:
            return 16;
        default:
            Err::unreachable("emitPrologue: unknown type");
        }
        return 4; // just to make gnalc happy
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
        const auto &offset = offsets[i];
        auto &arg = args[i];

        if (offset < passByRegBase) {
            continue;
        }

        auto isa = (offset >= passBySprRegBase + passByRegBase)
                       ? ARMReg::V0 + static_cast<uint32_t>(offset - passByRegBase - passBySprRegBase)
                       : ARMReg::X0 + static_cast<uint32_t>(offset - passByRegBase);

        auto mtype = arg->type();

        MIROperand_p msrc = MIROperand::asISAReg(isa, mtype);

        ctx.emitCopy(arg, msrc);
    }

    for (int i = 0; i < args.size(); ++i) {
        const auto offset = static_cast<int>(offsets[i]); // just to avoid clang-tidy warning
        auto &arg = args[i];
        auto size = getBytes(arg->type());
        auto align = size;

        if (offset > passByRegBase) {
            continue;
        }

        auto stkobj = mfunc->addStkObj(ctx.CodeGenCtx(), size, align, offset, StkObjUsage::Arg);

        ctx.emitInst(MIRInst::make(OpC::InstLoadRegFromStack)->setOperand<0>(arg)->setOperand<1>(stkobj));
        // addOperand already
    }
}

void TargetFrameInfo::emitReturn(IR::pRet retinst, LoweringContext &ctx) const {

    if (retinst->getType()->as<IR::BType>()->getInner() == IR::IRBTYPE::VOID) {
        ctx.emitInst(MIRInst::make(ARMOpC::RET));
    } else {
        auto mval = ctx.mapOperand(retinst->getRetVal());
        auto type = retinst->getRetVal()->getType();
        unsigned isa = -1;
        OpT mtype;

        if (auto btype = type->as<IR::BType>()) {
            if (btype->getInner() == IR::IRBTYPE::FLOAT) {
                isa = ARMReg::V0;
                mtype = OpT::Float32;
            } else {
                isa = ARMReg::X0;
                mtype = OpT::Int32;
            }
        }
        ///@todo vectorize

        auto mret = MIROperand::asISAReg(isa, mtype);

        ctx.emitCopy(mret, mval);
    }
    ctx.emitInst(MIRInst::make(ARMOpC::RET)); // just use ret
}

bool TargetFrameInfo::isCallerSaved(const MIROperand &op) const {
    const auto reg = op.reg();
    return inRange(static_cast<ARMReg>(reg), ARMReg::X0, ARMReg::X18) ||
           inRange(static_cast<ARMReg>(reg), ARMReg::V0, ARMReg::V15);
}

bool TargetFrameInfo::isCalleeSaved(const MIROperand &op) const {
    return !isCallerSaved(op); //
}

void TargetFrameInfo::emitPostSAPrologue(MIRBlk_p entry, CodeGenContext &ctx, unsigned stkSize) const {
    ///@note 在callleesave保存前插入开栈指令
    ///@note stksize需要把寄存器保存的空间也计算在内
    ///@note 如果栈内没有局部变量, 可以考虑去掉sub, 给stp加pre-indexing
    ///@note 类似于 stp x29, x30 [sp, -16]!
    //  +++ sub sp, sp, #stksize
    //      stp .., .., [sp, ...]
    //      stp .., .., [sp, ...]

    auto &insts = entry->Insts();

    auto iter = insts.end();
    for (auto it = insts.begin(); it != insts.end(); ++it) {
        if (it->get()->opcode<ARMOpC>() == ARMOpC::PUSH) {
            iter = it;
            break;
        }
    }

    Err::gassert(iter != insts.end(), "emitPostSAPrologue: cant find reg save insts");

    ARMInstTemplate::registerDec(insts, iter, ARMReg::SP, stkSize);
}

void TargetFrameInfo::emitPostSAEpilogue(MIRBlk_p entry, CodeGenContext &ctx, unsigned stkSize) const {
    ///@note 恢复寄存器后插入栈回收指令
    ///@note 同上, 可以优化为 ldp x29, x30, [sp], 16

    auto &insts = entry->Insts();
    bool find = false;

    auto iter = insts.end();
    for (auto it = insts.begin(); it != insts.end(); ++it) {
        if (it->get()->opcode<ARMOpC>() == ARMOpC::POP) {
            iter = std::next(it);
            find = true;
            break;
        }
    }

    Err::gassert(find, "emitPostSAEpilogue: cant find reg recover insts");

    ARMInstTemplate::registerInc(insts, iter, ARMReg::SP, stkSize);
}

void TargetFrameInfo::insertPrologueEpilogue(MIRFunction *mfunc, CodeGenContext &ctx) const {

    // 30 + 1 + 1 + 31 = 63 < 64
    // X<>: 0 ~ 30, SP: 31, PC: 32, V<>: 33~64
    const uint64_t &bitmap = mfunc->calleeSaveRegs();

    // insert prologue
    auto &mblk_entry = mfunc->EntryBlk();

    auto &insts = mblk_entry->Insts();

    insts.emplace_front(MIRInst::make(ARMOpC::PUSH)->setOperand<1>(MIROperand::asImme(bitmap, OpT::special))); // immeEx

    // insert epilogue
    for (auto &mblk_exit : mfunc->ExitBlks()) {
        auto &insts = mblk_exit->Insts();

        auto &mret = insts.back();
        Err::gassert(mret->opcode<ARMOpC>() == ARMOpC::RET, "insertPrologueEpilogue: exit blk not ends with ret inst");

        auto it = std::prev(insts.end());

        insts.insert(it, MIRInst::make(ARMOpC::POP)->setOperand<1>(MIROperand::asImme(bitmap, OpT::special)));
    }
}
