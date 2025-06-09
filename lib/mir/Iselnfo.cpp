#include "mir/MIR.hpp"
#include "mir/passes/transforms/isel.hpp"

using namespace MIR_new;

bool ISelInfo::isLegalGenericInst(MIRInst_p minst) const {
    Err::gassert(minst->isGeneric(), "isLegalGenericInst: minst is not a generic mir");

    switch (minst->opcode<OpC>()) {
    case OpC::InstCopy:
    case OpC::InstCopyFromReg:
    case OpC::InstCopyToReg:
    case OpC::InstLoadRegFromStack:
    case OpC::InstStoreRegToStack:
    case OpC::InstLoadStackObjectAddr:
        return true;
    default:
        return false;
    }
}

bool ISelInfo::match(MIRInst_p minst, ISelContext &ctx, bool allow) const {
    bool ret = legalizeInst(minst, ctx); // not impl yet
    return ret;
}

// for pass isel
bool ISelInfo::legalizeInst(MIRInst_p minst, ISelContext &ctx) const {
    bool modified = false;

    // LAMBDA BEGIN

    auto trySwapOps = [&](MIRInst_p minst) -> void {
        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);

        if (lhs->isImme() && !rhs->isImme()) {
            minst->setOperand<1>(rhs, ctx.codeGenCtx());
            minst->setOperand<2>(lhs, ctx.codeGenCtx());
            modified |= true;
        } else {
            modified |= false;
        }
    };

    auto loadImm = [&](const MIROperand_p &mop) -> MIROperand_p {
        auto mop_new = MIROperand::asVReg(ctx.codeGenCtx().nextId(), mop->type());

        if (inRange(mop->type(), OpT::Int, OpT::Int64)) {
            ctx.newInst(OpC::InstLoadImm)
                ->setOperand<0>(mop_new, ctx.codeGenCtx())
                ->setOperand<1>(mop, ctx.codeGenCtx());
            modified |= true;
        } else if (inRange(mop->type(), OpT::Float, OpT::Float32)) {
            ctx.newInst(OpC::InstLoadFPImm)
                ->setOperand<0>(mop_new, ctx.codeGenCtx())
                ->setOperand<1>(mop, ctx.codeGenCtx());
        } else {
            Err::todo("vector constant");
        }
        return mop_new; //  replace by yourself
    };

    // LADMBDA END

    if (!minst->isGeneric()) {
        return false; // modified
    }

    switch (minst->opcode<OpC>()) {
    case OpC::InstStore: {
        auto lhs = minst->getOp(1);
        if (lhs->isImme()) {
            minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());
        }
    }

    break;
    case OpC::InstICmp: {
        // trySwapOps(minst); // 这里交换之后尾随的cset也要变条件, 总之就是这个位置很难办(难办? 难办就别办了)
        auto rhs = minst->getOp(2);
        if (rhs->isImme() && !is12ImmeWithProbShift(rhs->imme())) {
            minst->setOperand<2>(loadImm(rhs), ctx.codeGenCtx());
        }

        auto lhs = minst->getOp(1);
        if (lhs->isImme()) {
            minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());
        }
    }
    case OpC::InstAdd: {
        trySwapOps(minst);
        auto rhs = minst->getOp(2);
        if (rhs->isImme() && !is12ImmeWithProbShift(rhs->imme())) {
            minst->setOperand<2>(loadImm(rhs), ctx.codeGenCtx());
        }

        auto lhs = minst->getOp(1);
        if (lhs->isImme()) {
            minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());
        }

    } break;
    case OpC::InstSub: {
        auto lhs = minst->getOp(1);
        if (lhs->isImme()) {
            minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());
        }

        auto rhs = minst->getOp(2);
        if (rhs->isImme() && !is12ImmeWithProbShift(rhs->imme())) {
            minst->setOperand<2>(loadImm(rhs), ctx.codeGenCtx());
        }
    } break;
    case OpC::InstFCmp: {
        ///@todo rhs can be a constant

        auto lhs = minst->getOp(1);
        if (lhs->isImme()) {
            minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());
        }

        auto rhs = minst->getOp(2);
        if (rhs->isImme()) {
            minst->setOperand<2>(loadImm(rhs), ctx.codeGenCtx());
        }
    } break;
    case OpC::InstMul: {
        trySwapOps(minst);
        auto rhs = minst->getOp(2);
        if (rhs->isImme()) {
            minst->setOperand<2>(loadImm(rhs), ctx.codeGenCtx());
        }

        auto lhs = minst->getOp(1);
        if (lhs->isImme()) {
            minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());
        }
    } break;
    case OpC::InstAnd:
    case OpC::InstOr:
    case OpC::InstXor:
        ///@note 目前的各种位运算只有在比较特殊的情况下使用, 并且能保证合法
        break;
    case OpC::InstShl:
    case OpC::InstLShr:
    case OpC::InstAShr: {
        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);

        if (rhs->isImme()) {
            Err::gassert(rhs->imme() < 32 && rhs->imme() >= 0,
                         "legalizeInst: shift imme out of range"); // though rhs == 0 is useless
        }

    } break;
    case OpC::InstSDiv: {
        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);
        if (lhs->isImme()) {
            minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());
        }
        if (rhs->isImme()) {
            minst->setOperand<2>(loadImm(rhs), ctx.codeGenCtx());
        }
    } break;
    case OpC::InstNeg: {
        auto lhs = minst->getOp(1);
        Err::gassert(!lhs->isImme(), "legalizeInst: can not neg a imme");
    } break;
    case OpC::InstFAdd:
    case OpC::InstFSub:
    case OpC::InstFMul:
    case OpC::InstFDiv: {
        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);
        if (lhs->isImme()) {
            minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());
        }
        if (rhs->isImme()) {
            minst->setOperand<2>(loadImm(rhs), ctx.codeGenCtx());
        }
    } break;
    case OpC::InstSRem: {

        ctx.delInst(minst); // add to list, handle later

        modified |= true;

        auto def = minst->getDef();
        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);

        ///@todo 需要范围分析
        // if (rhs->isImme() && popcounter_wrapper(rhs->imme()) == 1) {

        //     auto minst_and = ctx.newInst(OpC::InstAnd);

        //     minst_and->setOperand<0>(def, ctx.codeGenCtx())
        //         ->setOperand<1>(lhs, ctx.codeGenCtx())
        //         ->setOperand<2>(MIROperand::asImme(rhs->imme() - 1, OpT::Int32), ctx.codeGenCtx());
        //     break;
        // }

        auto minst_div = ctx.newInst(OpC::InstSDiv);
        auto minst_mul = ctx.newInst(OpC::InstMul);
        auto minst_sub = ctx.newInst(OpC::InstSub);

        auto result1 = MIROperand::asVReg(ctx.codeGenCtx().nextId(), OpT::Int32);
        auto result2 = MIROperand::asVReg(ctx.codeGenCtx().nextId(), OpT::Int32);
        minst_div->setOperand<0>(result1, ctx.codeGenCtx())
            ->setOperand<1>(lhs, ctx.codeGenCtx())
            ->setOperand<2>(rhs, ctx.codeGenCtx());
        minst_mul->setOperand<0>(result2, ctx.codeGenCtx())
            ->setOperand<1>(result1, ctx.codeGenCtx())
            ->setOperand<2>(rhs, ctx.codeGenCtx());
        minst_sub->setOperand<0>(def, ctx.codeGenCtx())
            ->setOperand<1>(lhs, ctx.codeGenCtx())
            ->setOperand<2>(result2, ctx.codeGenCtx());

    } break;
    case OpC::InstFRem: {
        auto def = minst->ensureDef();
        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);

        auto minst_fdiv = ctx.newInst(OpC::InstFDiv);
        auto minst_fmul = ctx.newInst(OpC::InstFMul);
        auto minst_fsub = ctx.newInst(OpC::InstFSub);

        auto result1 = MIROperand::asVReg(ctx.codeGenCtx().nextId(), OpT::Float32);
        auto result2 = MIROperand::asVReg(ctx.codeGenCtx().nextId(), OpT::Float32);
        minst_fdiv->setOperand<0>(result1, ctx.codeGenCtx())
            ->setOperand<1>(lhs, ctx.codeGenCtx())
            ->setOperand<2>(rhs, ctx.codeGenCtx());
        minst_fmul->setOperand<0>(result2, ctx.codeGenCtx())
            ->setOperand<1>(result1, ctx.codeGenCtx())
            ->setOperand<2>(rhs, ctx.codeGenCtx());
        minst_fsub->setOperand<0>(def, ctx.codeGenCtx())
            ->setOperand<1>(lhs, ctx.codeGenCtx())
            ->setOperand<2>(result2, ctx.codeGenCtx());

        ctx.delInst(minst); // add to list, handle later
        modified |= true;
    } break;
    case OpC::InstSelect: {
        auto def = minst->ensureDef();
        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);

        if (inRange(def->type(), OpT::Int, OpT::Int64) && lhs->isImme() && lhs->imme() == 1 && rhs->isImme() &&
            rhs->imme() == 0) {
            minst->resetOpcode(ARMOpC::CSET_SELECT);
            break;
        }

        if (inRange(def->type(), OpT::Int, OpT::Int64)) {
            minst->resetOpcode(ARMOpC::CSEL);
        } else {
            minst->resetOpcode(ARMOpC::FCSEL);
        }

        if (lhs->isImme()) {
            minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());
        }
        if (rhs->isImme()) {
            minst->setOperand<2>(loadImm(rhs), ctx.codeGenCtx());
        }

    } break;
    case OpC::InstF2S: {
        auto converted = minst->ensureDef();
        auto original = minst->getOp(1);

        if (original->isImme()) {
            minst->setOperand<1>(loadImm(original), ctx.codeGenCtx());
        }

    } break;
    case OpC::InstS2F: {
        auto converted = minst->ensureDef();
        auto original = minst->getOp(1);

        if (original->isImme()) {
            minst->setOperand<1>(loadImm(original), ctx.codeGenCtx());
        }

    } break;
    case OpC::InstLoadImmToReg: {
        // instloadImm
        // copy2reg
        auto def = minst->ensureDef();
        auto imme = minst->getOp(1);

        ctx.delInst(minst);

        auto loaded = loadImm(imme);
        ctx.newInst(OpC::InstCopyToReg)->setOperand<0>(def, ctx.codeGenCtx())->setOperand<1>(loaded, ctx.codeGenCtx());
    } break;
    case OpC::InstLoadFPImmToReg: {
        // instloadFPImm
        // copy2reg
        auto def = minst->ensureDef();
        auto imme = minst->getOp(1);

        ctx.delInst(minst);
        auto loaded = loadImm(imme);
        ctx.newInst(OpC::InstCopyToReg)->setOperand<0>(def, ctx.codeGenCtx())->setOperand<1>(loaded, ctx.codeGenCtx());
    } break;
    default:
        ///@note 各种copy, 内存访问没有合法化
        break;
    }
    return modified;
}

// for pass preRaLeagalize
void ISelInfo::preLegalizeInst(InstLegalizeContext &_ctx) {
    ///@todo handle select inst if we really have one

    auto &[minst, minsts, iter, ctx] = _ctx;

    if (!minst->isGeneric()) {
        return;
    }

    switch (minst->opcode<OpC>()) {
    case OpC::InstSelect:
        Err::todo("preLegalizeInst: select inst not support yet");
    case OpC::InstLoadGlobalAddress:
        /// nothing
        break;
    case OpC::InstLoadImm: {
        auto &def = minst->ensureDef();
        auto &imme = minst->getOp(1);

        auto imm = static_cast<unsigned>(imme->imme()); ///@bug

        ///@note movz(lo) + movk(hi) + (fmov) + copy

        auto dst = MIROperand::asVReg(ctx.nextId(), OpT::Int32);

        auto movz = MIRInst::make(ARMOpC::MOVZ)
                        ->setOperand<0>(dst, ctx)
                        ->setOperand<1>(MIROperand::asImme(imm & 0XFFFF, OpT::Int32), ctx);

        minsts.insert(iter, movz);

        if (imm > 0XFFFF) {
            auto movk = MIRInst::make(ARMOpC::MOVK)
                            ->setOperand<0>(dst, ctx)
                            ->setOperand<1>(MIROperand::asImme(imm >> 16, OpT::Int32), ctx)
                            ->setOperand<2>(MIROperand::asImme(16 | 0x00000000, OpT::special), ctx); // lsl only

            minsts.insert(iter, movk);
        }

        if (def->type() == OpT::Float32) {
            auto fdst = MIROperand::asVReg(ctx.nextId(), OpT::Float32);

            auto movf = MIRInst::make(ARMOpC::MOVF)->setOperand<0>(fdst, ctx)->setOperand<1>(dst, ctx);

            minsts.insert(iter, movf);

            dst = fdst;
        }
        ///@todo vectorize

        ///@brief rewrite
        minst->resetOpcode(OpC::InstCopy);

        minst->setOperand<1>(dst, ctx);

    } break;
    case OpC::InstLoadFPImm: {
        auto def = minst->ensureDef();
        auto imme = minst->getOp(1);

        Err::gassert(imme->type() == OpT::Float32, "preLegalizeInst: instloadfpimm with wrong imme op");

        auto imm_us = imme->imme();
        auto imm = *reinterpret_cast<float *>(&imm_us);

        if (!isFloat8(imm) && imm != 0.0f) {
            ///@brief movz + movk + fmov + copy

            auto dst = MIROperand::asVReg(ctx.nextId(), OpT::Int32);

            auto movz = MIRInst::make(ARMOpC::MOVZ)
                            ->setOperand<0>(dst, ctx)
                            ->setOperand<1>(MIROperand::asImme(imm_us & 0XFFFF, OpT::Int32), ctx);

            minsts.insert(iter, movz);

            if (imm_us > 0XFFFF) {
                auto movk = MIRInst::make(ARMOpC::MOVK)
                                ->setOperand<0>(dst, ctx)
                                ->setOperand<1>(MIROperand::asImme(imm_us >> 16, OpT::Int32), ctx)
                                ->setOperand<2>(MIROperand::asImme(16 | 0x00000000, OpT::special), ctx); // lsl only

                minsts.insert(iter, movk);
            }

            auto fdst = MIROperand::asVReg(ctx.nextId(), OpT::Float32);

            auto movf = MIRInst::make(ARMOpC::MOVF)->setOperand<0>(fdst, ctx)->setOperand<1>(dst, ctx);

            minsts.insert(iter, movf);

            ///@brief rewrite
            minst->resetOpcode(OpC::InstCopy);

            minst->setOperand<1>(fdst, ctx);

        } else if (imm == 0.0f) {
            ///@brief movi + copy
            auto fdst = MIROperand::asVReg(ctx.nextId(), OpT::Floatvec);
            auto movi = MIRInst::make(ARMOpC::MOVI)->setOperand<0>(fdst, ctx)->setOperand<1>(imme, ctx);

            minsts.insert(iter, movi);

            minst->resetOpcode(OpC::InstCopy);

            minst->setOperand<1>(fdst, ctx);

        } else {
            ///@brief fmov + copy

            auto fdst = MIROperand::asVReg(ctx.nextId(), OpT::Float32);
            auto fmov = MIRInst::make(ARMOpC::MOVF)->setOperand<0>(fdst, ctx)->setOperand<1>(imme, ctx);

            minsts.insert(iter, fmov);

            minst->resetOpcode(OpC::InstCopy);

            minst->setOperand<1>(fdst, ctx);
        }
    } break;
    default:
        break;
    }

    return;
}
void ISelInfo::legalizeWithStkOp(InstLegalizeContext &_ctx, MIROperand_p mop, const StkObj &obj) const {

    ///@warning armv8的交叉装载ld1, ld2, ld3不支持变址寻址, 甚至不支持常量偏移
    ///@warning ld1 {V<>.4s} 又和 ldr q<> 作用一致, 而后者支持变址寻址, 只是不显式指示加载类型
    ///@warning ld2 ld3 除非专门的处理数字信号的样例, 不然根本用不上

    auto &[minst, minsts, iter, ctx] = _ctx;

    auto offset = obj.offset;

    Err::gassert(minst->getOp(5) != nullptr, "PostRAlegalizeImpl::runOnInst: InstLoad/InstStore info lack");

    if (isFitMemInst(offset, minst->getOp(5)->imme())) {
        if (minst->opcode<OpC>() == OpC::InstLoadRegFromStack || minst->opcode<OpC>() == OpC::InstLoad) {
            minst->setOperand<2>(MIROperand::asImme(offset, OpT::Int64), ctx);
            minst->resetOpcode(ARMOpC::LDR);
        } else {
            minst->setOperand<3>(MIROperand::asImme(offset, OpT::Int64), ctx);
            minst->resetOpcode(ARMOpC::STR);
        }
        return;
    }

    ///@note scratch 用于变址寻址
    auto scratch = MIROperand::asISAReg(ARMReg::FP, OpT::Int64);

    ///@note 将偏移加到scratch, 由于偏移可以是64位, 所以这里最多有4次movz/movk
    auto imme = offset;
    auto movz = MIRInst::make(ARMOpC::MOVZ)
                    ->setOperand<0>(scratch, ctx)
                    ->setOperand<1>(MIROperand::asImme(imme & 0XFFFF, OpT::Int16), ctx);

    minsts.insert(iter, movz);

    imme >>= 16;
    unsigned times = 1;
    while (imme != 0) {
        auto movk = MIRInst::make(ARMOpC::MOVK)
                        ->setOperand<0>(scratch, ctx)
                        ->setOperand<1>(MIROperand::asImme(imme & 0XFFFF, OpT::Int16), ctx)
                        ->setOperand<2>(MIROperand::asImme(16 | 0x00000000, OpT::special), ctx); // lsl only
        minsts.insert(iter, movk);

        ++times;
        imme >>= 16;
    }

    ///@todo ldur/stur
    if (minst->opcode<OpC>() == OpC::InstLoadRegFromStack || minst->opcode<OpC>() == OpC::InstLoad) {
        minst->setOperand<2>(scratch, ctx); // just a mark for codegen
        minst->resetOpcode(ARMOpC::LDR);
    } else if (minst->opcode<OpC>() == OpC::InstStoreRegToStack || minst->opcode<OpC>() == OpC::InstStore) {
        minst->setOperand<3>(scratch, ctx);
        minst->resetOpcode(ARMOpC::STR);
    }

    return;
}

void ISelInfo::legalizeWithStkGep(InstLegalizeContext &_ctx, MIROperand_p mop, const StkObj &obj) const {
    /// mop = def

    auto &[minst, minsts, iter, ctx] = _ctx;
    int offset = obj.offset;

    if (minst->getOp(2)->isImme()) {
        offset += static_cast<unsigned>(minst->getOp(2)->imme());

        if (is12ImmeWithProbShift(offset)) {
            minst->resetOpcode(OpC::InstAdd);
            minst->setOperand<1>(MIROperand::asISAReg(ARMReg::SP, OpT::Int64), ctx);
            minst->setOperand<2>(MIROperand::asImme(offset, OpT::Int64), ctx);
            return;
        }

        auto imme = offset;
        auto scratch = MIROperand::asISAReg(ARMReg::FP, OpT::Int64);

        auto movz = MIRInst::make(ARMOpC::MOVZ)
                        ->setOperand<0>(scratch, ctx)
                        ->setOperand<1>(MIROperand::asImme(imme & 0XFFFF, OpT::Int16), ctx);
        minsts.insert(iter, movz);

        imme >>= 16;
        unsigned times = 1;
        while (imme != 0) {
            auto movk = MIRInst::make(ARMOpC::MOVK)
                            ->setOperand<0>(scratch, ctx)
                            ->setOperand<1>(MIROperand::asImme(imme & 0XFFFF, OpT::Int16), ctx)
                            ->setOperand<2>(MIROperand::asImme(16 | 0x00000000, OpT::special), ctx);
            minsts.insert(iter, movk);

            ++times;
            imme >>= 16;
        }

        minst->resetOpcode(OpC::InstAdd);
        minst->setOperand<1>(MIROperand::asISAReg(ARMReg::SP, OpT::Int64), ctx);
        minst->setOperand<2>(scratch, ctx);
    } else {

        if (is12ImmeWithProbShift(offset)) {
            //ori: add %mop, %stk, %valoffset

            // mov %mop, %valoffset
            // add %mop, %mop, sp
            // add %mop, %mop, #stkobj_offset
            // somewhere : str/ldr ... [%mop]
            auto var_offset = minst->getOp(2);

            minsts.insert(iter, MIRInst::make(OpC::InstCopy)
                                    ->setOperand<0>(mop, ctx)
                                    ->setOperand<1>(var_offset, ctx)); // 两边都是地址Int64

            minsts.insert(iter, MIRInst::make(OpC::InstAdd)
                                    ->setOperand<0>(mop, ctx)
                                    ->setOperand<1>(MIROperand::asISAReg(ARMReg::SP, OpT::Int64), ctx)
                                    ->setOperand<2>(mop, ctx));

            minst->resetOpcode(OpC::InstAdd);
            minst->setOperand<1>(mop, ctx)->setOperand<2>(MIROperand::asImme(offset, OpT::Int64), ctx);

            ///@note 这里的模板可以做模式匹配
            return;
        }

        auto imme = offset;
        auto scratch = MIROperand::asISAReg(ARMReg::FP, OpT::Int64);

        auto movz = MIRInst::make(ARMOpC::MOVZ)
                        ->setOperand<0>(scratch, ctx)
                        ->setOperand<1>(MIROperand::asImme(imme & 0XFFFF, OpT::Int16), ctx);
        minsts.insert(iter, movz);

        imme >>= 16;
        unsigned times = 1;
        while (imme != 0) {
            auto movk = MIRInst::make(ARMOpC::MOVK)
                            ->setOperand<0>(scratch, ctx)
                            ->setOperand<1>(MIROperand::asImme(imme & 0XFFFF, OpT::Int16), ctx)
                            ->setOperand<2>(MIROperand::asImme(16 | 0x00000000, OpT::special), ctx);
            minsts.insert(iter, movk);

            ++times;
            imme >>= 16;
        }

        /// mov... fp, #large_const
        // mov %mop, %valoffset
        // add %mop, %mop, sp
        // add %mop, %mop, fp
        auto var_offset = minst->getOp(2);

        minsts.insert(iter, MIRInst::make(OpC::InstCopy)->setOperand<0>(mop, ctx)->setOperand<1>(var_offset, ctx));

        minsts.insert(iter, MIRInst::make(OpC::InstAdd)
                                ->setOperand<0>(mop, ctx)
                                ->setOperand<1>(MIROperand::asISAReg(ARMReg::SP, OpT::Int64), ctx)
                                ->setOperand<2>(mop, ctx));

        minst->resetOpcode(OpC::InstAdd);
        minst->setOperand<0>(mop, ctx);
        minst->setOperand<1>(mop, ctx);
        minst->setOperand<2>(scratch, ctx);
    }
    return;
}

void ISelInfo::legalizeWithStkPtrCast(InstLegalizeContext &_ctx, MIROperand_p mop, const StkObj &obj) const {
    auto &[minst, minsts, iter, ctx] = _ctx;
    int offset = obj.offset;

    if (offset) {

        if (is12ImmeWithProbShift(offset)) {

            minst->setOperand<2>(MIROperand::asImme(offset, OpT::Int64), ctx);
            minst->setOperand<1>(MIROperand::asISAReg(ARMReg::SP, OpT::Int64), ctx);
            minst->resetOpcode(OpC::InstAdd);
            return;
        }

        auto imme = offset;
        auto scratch = MIROperand::asISAReg(ARMReg::FP, OpT::Int64);

        auto movz = MIRInst::make(ARMOpC::MOVZ)
                        ->setOperand<0>(scratch, ctx)
                        ->setOperand<1>(MIROperand::asImme(imme & 0XFFFF, OpT::Int16), ctx);
        minsts.insert(iter, movz);

        imme >>= 16;
        unsigned times = 1;
        while (imme != 0) {
            auto movk = MIRInst::make(ARMOpC::MOVK)
                            ->setOperand<0>(scratch, ctx)
                            ->setOperand<1>(MIROperand::asImme(imme & 0XFFFF, OpT::Int16), ctx)
                            ->setOperand<2>(MIROperand::asImme(16 | 0x00000000, OpT::special), ctx);
            minsts.insert(iter, movk);

            ++times;
            imme >>= 16;
        }

        minst->resetOpcode(OpC::InstAdd);
        minst->setOperand<1>(MIROperand::asISAReg(ARMReg::SP, OpT::Int64), ctx);
        minst->setOperand<2>(scratch, ctx);
    } else {

        minst->setOperand<1>(MIROperand::asISAReg(ARMReg::SP, OpT::Int64), ctx);

        minst->resetOpcode(ARMOpC::MOV);
    }
}

void ISelInfo::legalizeCopy(InstLegalizeContext &_ctx) const {
    auto &[minst, minsts, iter, ctx] = _ctx;

    auto &def = minst->ensureDef();
    auto &use = minst->getOp(1);

    auto defType = def->type();
    auto useType = use->type();

    ARMOpC movType;

    if (inRange(defType, OpT::Int, OpT::Int64) && inRange(useType, OpT::Int, OpT::Int64)) {
        movType = ARMOpC::MOV; // orr
    } else if (defType == OpT::Float && useType == OpT::Float) {
        movType = ARMOpC::MOV_V; // .16b
    } else if (inRange(defType, OpT::Intvec, OpT::Floatvec) && inRange(useType, OpT::Intvec, OpT::Floatvec)) {
        movType = ARMOpC::MOV_V;
    } else {
        movType = ARMOpC::MOVF;
    }

    minst->resetOpcode(movType);
}

void ISelInfo::legalizeAdrp(InstLegalizeContext &_ctx) const {
    auto &[minst, minsts, iter, ctx] = _ctx;

    auto def = minst->ensureDef();

    minsts.insert(iter, MIRInst::make(ARMOpC::ADRP)->setOperand<0>(def, ctx)->setOperand<1>(minst->getOp(1), ctx));
    minst->resetOpcode(ARMOpC::LDR);
    minst->setOperand<5>(MIROperand::asImme(5, OpT::special), ctx);
}