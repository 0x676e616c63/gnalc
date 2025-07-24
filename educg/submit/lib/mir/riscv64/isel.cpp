// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../include/mir/riscv64/isel.hpp"
#include "../../../include/mir/MIR.hpp"
#include "../../../include/mir/passes/transforms/isel.hpp"

using namespace MIR;

bool RVIselInfo::isLegalGenericInst(MIRInst_p minst) const {
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

bool RVIselInfo::match(MIRInst_p minst, ISelContext &ctx, bool allow) const {
    bool ret = legalizeInst(minst, ctx);
    return ret;
}

// for pass isel
bool RVIselInfo::legalizeInst(MIRInst_p minst, ISelContext &ctx) const {
    bool modified = false;

    // LAMBDA BEGIN

    auto trySwapOps = [&](MIRInst_p minst) -> void {
        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);

        if (lhs->isImme() && !rhs->isImme()) {
            minst->setOperand<1>(rhs, ctx.codeGenCtx());
            minst->setOperand<2>(lhs, ctx.codeGenCtx());
            modified |= true;
        }
    };

    auto loadImm = [&](const MIROperand_p &mop) -> MIROperand_p {
        modified |= true;
        auto mop_new = MIROperand::asVReg(ctx.codeGenCtx().nextId(), mop->type());

        if (mop->isExImme()) {
            ctx.newInst(OpC::InstLoadImmEx)
                ->setOperand<0>(mop_new, ctx.codeGenCtx())
                ->setOperand<1>(mop, ctx.codeGenCtx());
        } else if (inRange(mop->type(), OpT::Int, OpT::Int64)) {
            ctx.newInst(OpC::InstLoadImm)
                ->setOperand<0>(mop_new, ctx.codeGenCtx())
                ->setOperand<1>(mop, ctx.codeGenCtx());
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
    case OpC::InstICmp: {
        modified |= true;
        auto def = minst->getOp(0);

        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);

        auto cond = minst->getOp(3)->imme();
        // AL, EQ, NE, LT, GT, LE, GE
        switch (cond) {
        case Cond::EQ: {
            // tmp = lhs XOR rhs
            auto tmp = MIROperand::asVReg(ctx.codeGenCtx().nextId(), def->type());
            ctx.newInst(OpC::InstXor)
                ->setOperand<0>(tmp, ctx.codeGenCtx())
                ->setOperand<1>(lhs, ctx.codeGenCtx())
                ->setOperand<2>(rhs, ctx.codeGenCtx());
            // def = SEQZ tmp
            ctx.newInst(RVOpC::SEQZ)->setOperand<0>(def, ctx.codeGenCtx())->setOperand<1>(tmp, ctx.codeGenCtx());

            ctx.delInst(minst);
            break;
        }
        case Cond::NE: {
            // tmp = lhs XOR rhs
            auto tmp = MIROperand::asVReg(ctx.codeGenCtx().nextId(), def->type());
            ctx.newInst(OpC::InstXor)
                ->setOperand<0>(tmp, ctx.codeGenCtx())
                ->setOperand<1>(lhs, ctx.codeGenCtx())
                ->setOperand<2>(rhs, ctx.codeGenCtx());
            // def = SNEZ tmp
            ctx.newInst(RVOpC::SNEZ)->setOperand<0>(def, ctx.codeGenCtx())->setOperand<1>(tmp, ctx.codeGenCtx());

            ctx.delInst(minst);
            break;
        }
        case Cond::LT: {
            minst->resetOpcode(RVOpC::SLT);
            if (rhs->isImme()) {
                if (RV64::is12BitImm(rhs->imme(), rhs->isExImme()))
                    minst->resetOpcode(RVOpC::SLTI);
                else
                    minst->setOperand<2>(loadImm(rhs), ctx.codeGenCtx());
            }
            if (lhs->isImme())
                minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());
            break;
        }
        case Cond::LE: {
            // !(rhs < lhs)
            auto tmp = MIROperand::asVReg(ctx.codeGenCtx().nextId(), def->type());

            auto slt_opcode = RVOpC::SLT;
            if (rhs->isImme())
                rhs = loadImm(rhs);
            if (lhs->isImme()) {
                if (RV64::is12BitImm(lhs->imme(), lhs->isExImme()))
                    slt_opcode = RVOpC::SLTI;
                else
                    lhs = loadImm(lhs);
            }

            auto new_slt = ctx.newInst(slt_opcode)
                               ->setOperand<0>(tmp, ctx.codeGenCtx())
                               ->setOperand<1>(rhs, ctx.codeGenCtx())
                               ->setOperand<2>(lhs, ctx.codeGenCtx());

            ctx.newInst(RVOpC::SEQZ)->setOperand<0>(def, ctx.codeGenCtx())->setOperand<1>(tmp, ctx.codeGenCtx());
            ctx.delInst(minst);
            break;
        }
        case Cond::GT: {
            // rhs < lhs
            minst->resetOpcode(RVOpC::SLT);
            minst->setOperand<1>(rhs, ctx.codeGenCtx())->setOperand<2>(lhs, ctx.codeGenCtx());

            if (rhs->isImme())
                minst->setOperand<1>(loadImm(rhs), ctx.codeGenCtx());
            if (lhs->isImme()) {
                if (RV64::is12BitImm(lhs->imme(), lhs->isExImme()))
                    minst->resetOpcode(RVOpC::SLTI);
                else
                    minst->setOperand<2>(loadImm(lhs), ctx.codeGenCtx());
            }
            break;
        }
        case Cond::GE: {
            // !(lhs < rhs)
            auto tmp = MIROperand::asVReg(ctx.codeGenCtx().nextId(), def->type());

            auto slt_opcode = RVOpC::SLT;
            if (rhs->isImme()) {
                if (RV64::is12BitImm(rhs->imme(), rhs->isExImme()))
                    slt_opcode = RVOpC::SLTI;
                else
                    rhs = loadImm(rhs);
            }
            if (lhs->isImme())
                lhs = loadImm(lhs);

            auto new_slt = ctx.newInst(slt_opcode)
                               ->setOperand<0>(tmp, ctx.codeGenCtx())
                               ->setOperand<1>(lhs, ctx.codeGenCtx())
                               ->setOperand<2>(rhs, ctx.codeGenCtx());

            ctx.newInst(RVOpC::SEQZ)->setOperand<0>(def, ctx.codeGenCtx())->setOperand<1>(tmp, ctx.codeGenCtx());
            ctx.delInst(minst);
            break;
        }
        case Cond::AL:
            Err::unreachable("icmp can't be AL");
        default:
            Err::unreachable("unsupported ICMP predicate for RISCV64");
        }
    } break;
    case OpC::InstFCmp: {
        modified |= true;
        auto def = minst->getOp(0);
        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);

        if (lhs->isImme())
            lhs = loadImm(lhs);
        if (rhs->isImme())
            rhs = loadImm(rhs);

        minst->setOperand<1>(lhs, ctx.codeGenCtx());
        minst->setOperand<2>(rhs, ctx.codeGenCtx());

        auto cond = minst->getOp(3)->imme();
        switch (cond) {
        case Cond::EQ: {
            minst->resetOpcode(RVOpC::FEQ);
            break;
        }
        case Cond::NE: {
            // tmp = lhs XOR rhs
            auto tmp = MIROperand::asVReg(ctx.codeGenCtx().nextId(), def->type());
            ctx.newInst(RVOpC::FEQ)
                ->setOperand<0>(tmp, ctx.codeGenCtx())
                ->setOperand<1>(lhs, ctx.codeGenCtx())
                ->setOperand<2>(rhs, ctx.codeGenCtx());
            // def = SEQ tmp
            ctx.newInst(RVOpC::SEQZ)->setOperand<0>(def, ctx.codeGenCtx())->setOperand<1>(tmp, ctx.codeGenCtx());
            ctx.delInst(minst);
            break;
        }
        case Cond::LT: {
            minst->resetOpcode(RVOpC::FLT);
            break;
        }
        case Cond::LE: {
            // !(rhs < lhs)
            auto tmp = MIROperand::asVReg(ctx.codeGenCtx().nextId(), def->type());
            ctx.newInst(RVOpC::FLT)
                ->setOperand<0>(tmp, ctx.codeGenCtx())
                ->setOperand<1>(rhs, ctx.codeGenCtx())
                ->setOperand<2>(lhs, ctx.codeGenCtx());
            ctx.newInst(RVOpC::SEQZ)->setOperand<0>(def, ctx.codeGenCtx())->setOperand<1>(tmp, ctx.codeGenCtx());
            ctx.delInst(minst);
            break;
        }
        case Cond::GT: {
            // rhs < lhs
            minst->resetOpcode(RVOpC::FLT);
            minst->setOperand<1>(rhs, ctx.codeGenCtx())->setOperand<2>(lhs, ctx.codeGenCtx());
            break;
        }
        case Cond::GE: {
            // !(lhs < rhs)
            auto tmp = MIROperand::asVReg(ctx.codeGenCtx().nextId(), def->type());
            ctx.newInst(RVOpC::FLT)
                ->setOperand<0>(tmp, ctx.codeGenCtx())
                ->setOperand<1>(lhs, ctx.codeGenCtx())
                ->setOperand<2>(rhs, ctx.codeGenCtx());
            ctx.newInst(RVOpC::SEQZ)->setOperand<0>(def, ctx.codeGenCtx())->setOperand<1>(tmp, ctx.codeGenCtx());
            ctx.delInst(minst);
            break;
        }
        case Cond::AL:
            Err::unreachable("fcmp can't be AL");
        default:
            Err::unreachable("unsupported FCMP predicate for RISCV64");
        }
    } break;
    case OpC::InstStore: {
        auto val = minst->getOp(1);
        if (val->isImme())
            minst->setOperand<1>(loadImm(val), ctx.codeGenCtx());
    } break;
    case OpC::InstAdd:
    case OpC::InstSub: {
        if (minst->opcode<OpC>() == OpC::InstAdd)
            trySwapOps(minst);

        auto lhs = minst->getOp(1);
        if (lhs->isImme())
            minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());

        auto rhs = minst->getOp(2);
        if (rhs->isImme() && !RV64::is12BitImm(rhs->imme(), rhs->isExImme()))
            minst->setOperand<2>(loadImm(rhs), ctx.codeGenCtx());
    } break;
    case OpC::InstMul:
    case OpC::InstAnd:
    case OpC::InstOr:
    case OpC::InstXor: {
        trySwapOps(minst);

        auto lhs = minst->getOp(1);
        if (lhs->isImme())
            minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());

        auto rhs = minst->getOp(2);
        if (rhs->isImme())
            minst->setOperand<2>(loadImm(rhs), ctx.codeGenCtx());
        break;
    }
    case OpC::InstSDiv:
    case OpC::InstSRem:
    case OpC::InstUDiv:
    case OpC::InstURem: {
        auto lhs = minst->getOp(1);
        if (lhs->isImme())
            minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());

        auto rhs = minst->getOp(2);
        if (rhs->isImme())
            minst->setOperand<2>(loadImm(rhs), ctx.codeGenCtx());
        break;
    }
    case OpC::InstShl:
    case OpC::InstLShr:
    case OpC::InstAShr: {
        auto shift = minst->getOp(2);
        if (shift->isImme()) {
            unsigned s = static_cast<unsigned>(shift->imme());
            Err::gassert(s < 64, "shift immediate out of range");
        }
        break;
    }
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
    case OpC::InstFRem: {
        modified |= true;
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
    } break;
    case OpC::InstF2S: {
        auto converted = minst->ensureDef();
        auto original = minst->getOp(1);

        if (original->isImme())
            minst->setOperand<1>(loadImm(original), ctx.codeGenCtx());
    } break;
    case OpC::InstS2F: {
        auto converted = minst->ensureDef();
        auto original = minst->getOp(1);

        if (original->isImme())
            minst->setOperand<1>(loadImm(original), ctx.codeGenCtx());
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
    case OpC::InstICmpBranch: {
        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);
        if (lhs->isImme())
            minst->setOperand<1>(loadImm(lhs), ctx.codeGenCtx());
        if (rhs->isImme())
            minst->setOperand<2>(loadImm(rhs), ctx.codeGenCtx());
    } break;
    case OpC::InstSelect:
        Err::not_implemented("Select on RISCV64");
    default:
        ///@note 各种copy, 内存访问没有合法化
        break;
    }
    return modified;
}

// for pass preRaLeagalize
void RVIselInfo::preLegalizeInst(InstLegalizeContext &_ctx) {
    auto &[minst, minsts, iter, ctx, _] = _ctx;

    if (!minst->isGeneric())
        return;

    switch (minst->opcode<OpC>()) {
    case OpC::InstLoadAddress:
        minst->resetOpcode(RVOpC::LA);
        break;
    case OpC::InstLoadImm: {
    case OpC::InstLoadImmEx:
        minst->resetOpcode(RVOpC::LI);
    } break;
    case OpC::InstLoadFPImm: {
        auto def = minst->ensureDef();
        auto imme = minst->getOp(1);
        auto tmp = MIROperand::asVReg(ctx.nextId(), OpT::Int32);
        auto li = MIRInst::make(RVOpC::LI)->setOperand<0>(tmp, ctx)->setOperand<1>(imme, ctx);
        minsts.insert(iter, li);
        minst->resetOpcode(RVOpC::FMV_W_X);
        minst->setOperand<1>(tmp, ctx);
    } break;
    case OpC::InstSelect:
        Err::not_implemented("Select on RISCV64");
    default:
        break;
    }

    return;
}

void RVIselInfo::legalizeWithPtrLoad(MIRInst_p minst) const {
    auto memSize = minst->getOp(5)->imme();
    if (inRange(minst->getDef()->type(), OpT::Float, OpT::Float32)) {
        switch (memSize) {
        case 4:
            minst->resetOpcode(RVOpC::FLW);
            break;
        case 8:
            minst->resetOpcode(RVOpC::FLD);
            break;
        default:
            Err::not_implemented("Unsupported size.");
        }
    } else {
        switch (memSize) {
        case 1:
            minst->resetOpcode(RVOpC::LB);
            break;
        case 2:
            minst->resetOpcode(RVOpC::LH);
            break;
        case 4:
            minst->resetOpcode(RVOpC::LW);
            break;
        case 8:
            minst->resetOpcode(RVOpC::LD);
            break;
        default:
            Err::not_implemented("Unsupported size.");
        }
    }
}

void RVIselInfo::legalizeWithPtrStore(MIRInst_p minst) const {
    auto memSize = minst->getOp(5)->imme();
    if (inRange(minst->getOp(1)->type(), OpT::Float, OpT::Float32)) {
        switch (memSize) {
        case 4:
            minst->resetOpcode(RVOpC::FSW);
            break;
        case 8:
            minst->resetOpcode(RVOpC::FSD);
            break;
        default:
            Err::not_implemented("Unsupported size.");
        }
    } else {
        switch (memSize) {
        case 1:
            minst->resetOpcode(RVOpC::SB);
            break;
        case 2:
            minst->resetOpcode(RVOpC::SH);
            break;
        case 4:
            minst->resetOpcode(RVOpC::SW);
            break;
        case 8:
            minst->resetOpcode(RVOpC::SD);
            break;
        default:
            Err::not_implemented("Unsupported size.");
        }
    }
}

void RVIselInfo::legalizeWithStkOp(InstLegalizeContext &_ctx, MIROperand_p mop, const StkObj &obj) const {
    auto &[minst, minsts, iter, ctx, _] = _ctx;
    auto offset = obj.offset;

    if (RV64::is12BitImm(offset, 64)) {
        if (minst->opcode<OpC>() == OpC::InstLoadRegFromStack || minst->opcode<OpC>() == OpC::InstLoad) {
            minst->setOperand<1>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx)
                ->setOperand<2>(MIROperand::asImme(offset, OpT::Int64), ctx);
            legalizeWithPtrLoad(minst);
        } else {
            minst->setOperand<2>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx)
                ->setOperand<3>(MIROperand::asImme(offset, OpT::Int64), ctx);
            legalizeWithPtrStore(minst);
        }
        return;
    }

    // fp <- li
    // ld <- fp + sp
    auto scratch = MIROperand::asISAReg(RVReg::FP, OpT::Int64);
    auto li = MIRInst::make(RVOpC::LI)
                  ->setOperand<0>(scratch, ctx)
                  ->setOperand<1>(MIROperand::asImme(offset, OpT::Int64), ctx);
    minsts.insert(iter, li);

    auto add = MIRInst::make(OpC::InstAdd)
                   ->setOperand<0>(scratch, ctx)
                   ->setOperand<1>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx)
                   ->setOperand<2>(scratch, ctx);
    minsts.insert(iter, add);

    if (minst->opcode<OpC>() == OpC::InstLoadRegFromStack || minst->opcode<OpC>() == OpC::InstLoad) {
        minst->setOperand<1>(scratch, ctx);
        minst->setOperand<2>(MIROperand::asImme(0, OpT::Int64), ctx);
        legalizeWithPtrLoad(minst);
    } else {
        minst->setOperand<2>(scratch, ctx);
        minst->setOperand<3>(MIROperand::asImme(0, OpT::Int64), ctx);
        legalizeWithPtrStore(minst);
    }
}

void RVIselInfo::legalizeWithStkGep(InstLegalizeContext &_ctx, MIROperand_p mop, const StkObj &obj) const {
    auto &[minst, minsts, iter, ctx, _] = _ctx;
    unsigned offset = static_cast<unsigned>(obj.offset);

    if (minst->getOp(2)->isImme()) {
        offset += static_cast<unsigned>(minst->getOp(2)->imme());

        if (RV64::is12BitImm(offset, 64)) {
            minst->resetOpcode(OpC::InstAdd);
            minst->setOperand<1>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx);
            minst->setOperand<2>(MIROperand::asImme(offset, OpT::Int64), ctx);
            return;
        }

        auto scratch = MIROperand::asISAReg(RVReg::FP, OpT::Int64);
        auto li = MIRInst::make(RVOpC::LI)
                      ->setOperand<0>(scratch, ctx)
                      ->setOperand<1>(MIROperand::asImme(offset, OpT::Int64), ctx);
        minsts.insert(iter, li);

        minst->resetOpcode(OpC::InstAdd);
        minst->setOperand<1>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx);
        minst->setOperand<2>(scratch, ctx);
    } else {
        auto var_offset = minst->getOp(2);
        if (RV64::is12BitImm(offset, 64)) {
            minsts.insert(iter, MIRInst::make(OpC::InstCopy)->setOperand<0>(mop, ctx)->setOperand<1>(var_offset, ctx));

            minsts.insert(iter, MIRInst::make(OpC::InstAdd)
                                    ->setOperand<0>(mop, ctx)
                                    ->setOperand<1>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx)
                                    ->setOperand<2>(mop, ctx));

            minst->resetOpcode(OpC::InstAdd);
            minst->setOperand<1>(mop, ctx)->setOperand<2>(MIROperand::asImme(offset, OpT::Int64), ctx);
            return;
        }

        auto scratch = MIROperand::asISAReg(RVReg::FP, OpT::Int64);
        auto li = MIRInst::make(RVOpC::LI)
                      ->setOperand<0>(scratch, ctx)
                      ->setOperand<1>(MIROperand::asImme(offset, OpT::Int64), ctx);
        minsts.insert(iter, li);

        minsts.insert(iter, MIRInst::make(OpC::InstCopy)->setOperand<0>(mop, ctx)->setOperand<1>(var_offset, ctx));

        minsts.insert(iter, MIRInst::make(OpC::InstAdd)
                                ->setOperand<0>(mop, ctx)
                                ->setOperand<1>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx)
                                ->setOperand<2>(mop, ctx));

        minst->resetOpcode(OpC::InstAdd);
        minst->setOperand<0>(mop, ctx);
        minst->setOperand<1>(mop, ctx);
        minst->setOperand<2>(scratch, ctx);
    }
}

void RVIselInfo::legalizeWithStkPtrCast(InstLegalizeContext &_ctx, MIROperand_p mop, const StkObj &obj) const {
    auto &[minst, minsts, iter, ctx, _] = _ctx;
    unsigned offset = static_cast<unsigned>(obj.offset);

    if (offset) {
        if (RV64::is12BitImm(offset, 64)) {
            minst->setOperand<1>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx);
            minst->setOperand<2>(MIROperand::asImme(offset, OpT::Int64), ctx);
            minst->resetOpcode(OpC::InstAdd);
            return;
        }

        auto scratch = MIROperand::asISAReg(RVReg::FP, OpT::Int64);
        auto li = MIRInst::make(RVOpC::LI)
                      ->setOperand<0>(scratch, ctx)
                      ->setOperand<1>(MIROperand::asImme(offset, OpT::Int64), ctx);
        minsts.insert(iter, li);

        minst->resetOpcode(OpC::InstAdd);
        minst->setOperand<1>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx);
        minst->setOperand<2>(scratch, ctx);
    } else {
        minst->setOperand<1>(MIROperand::asISAReg(RVReg::SP, OpT::Int64), ctx);
        minst->resetOpcode(RVOpC::MV);
    }
}

void RVIselInfo::legalizeCopy(InstLegalizeContext &_ctx) const {
    auto &[minst, minsts, iter, ctx, _] = _ctx;

    auto &def = minst->ensureDef();
    auto &use = minst->getOp(1);

    auto defType = def->type();
    auto useType = use->type();

    RVOpC movType;

    bool to_int = inRange(defType, OpT::Int, OpT::Int64);
    bool from_int = inRange(useType, OpT::Int, OpT::Int64);
    bool to_float = inRange(defType, OpT::Float, OpT::Float32);
    bool from_float = inRange(useType, OpT::Float, OpT::Float32);

    if (from_int && to_int)
        movType = RVOpC::MV;
    else if (from_float && to_float)
        movType = RVOpC::FMV_S;
    else if (from_int && to_float)
        movType = RVOpC::FMV_W_X;
    else if (from_float && to_int)
        movType = RVOpC::FMV_X_W;
    else
        Err::unreachable("Unsupported type conversion");

    minst->resetOpcode(movType);
}

void RVIselInfo::legalizeAdrp(InstLegalizeContext &_ctx) const { Err::unreachable("No adrp on RISCV64"); }

RVIselInfo::~RVIselInfo() = default;
