#include "mir/passes/transforms/peephole.hpp"
#include <optional>

using namespace MIR_new;

PM::PreservedAnalyses GenericPeephole::run(MIRFunction &mfunc, FAM &fam) {

    class GenericPeepholeImpl peephole {};

    peephole.impl(mfunc, fam, stage);

    return PM::PreservedAnalyses::all();
}

void GenericPeepholeImpl::impl(MIRFunction &_mfunc, FAM &_fam, Stage _stage) {
    mfunc = &_mfunc;
    fam = &_fam;
    stage = _stage;

    bool modified = true;

    ///@brief run this until no blk is modified
    while (modified) {
        modified = false;
        for (auto &mblk : mfunc->blks()) {
            modified |= runOnBlk(mblk);
        }
    }
}

bool GenericPeepholeImpl::runOnBlk(MIRBlk_p &mblk) {

    bool atLeastOneModfied = false;
    bool modified = true;

    ///@brief run this until no inst is modified in a blk
    while (modified) {
        modified = false;

        // MATCHES BEGIN
        auto &minsts = mblk->Insts();
        for (auto iter = minsts.begin(); iter != minsts.end(); /* forword iter in matches */) {

            auto recovery = iter;
            MatchInfo info(*iter, minsts, iter);

            if (matchNop(info) || matchArithmetic(info) || matchFusedAdr(info)) {
                modified = true;
            }

            recovery == iter ? (++iter, nop) : nop;
        }
        // MATCHES END

        atLeastOneModfied |= modified;
    }

    return atLeastOneModfied;
}

// matches impl

bool GenericPeepholeImpl::matchNop(MatchInfo &info) {
    if (stage != Stage::AfterRa) {
        return false;
    }

    ///@note delete nop inst such as : mov w0, w0

    // LAMBDA BEGIN
    auto isCpy = [](const MIRInst_p &inst) -> bool {
        if (inst->isGeneric()) {
            if (inRange(inst->opcode<OpC>(), OpC::InstCopy, OpC::InstCopyToReg)) {
                return true;
            }
        } else {
            if (inst->opcode<ARMOpC>() == ARMOpC::MOV) {
                return true;
            }
        }

        return false;
    };

    auto sameReg = [](const MIROperand_p &def, const MIROperand_p &use) -> bool {
        if (def->isISA() && use->isISA()) {
            if (def->isa() == use->isa()) {
                return true;
            }
        }
        return false;
    };

    // LAMBDA END

    auto &[minst, minsts, iter] = info;

    if (isCpy(minst) && sameReg(minst->ensureDef(), minst->getOp(1))) {
        auto diter = iter;
        ++iter;
        minsts.erase(diter);
        return true;
    } else {
        ++iter;
        return false;
    }
}

bool GenericPeepholeImpl::matchArithmetic(MatchInfo &info) {
    if (stage != Stage::AfterIsel) {
        return false;
    }

    auto &minst = info.minst;
    auto &minsts = info.minsts;
    auto &iter = info.iter;

    // LAMBDA BEGIN
    auto isDIV = [&minst]() {
        if (minst->isGeneric() && minst->opcode<OpC>() == OpC::InstSDiv) {
            return true;
        }
        return false;
    };

    auto isMUL = [&minst]() {
        if (minst->isGeneric() && minst->opcode<OpC>() == OpC::InstMul) {
            return true;
        }
        return false;
    };

    auto findLoadImmtoOp2 = [&minst, &minsts, &iter]() {
        // 对于mul, isle中已经将可能的常数转移到op2, 并load
        // 对于div, op1为常数很难优化

        auto mop2 = minst->getOp(2);

        if (!mop2->isVReg()) {   // Loadimme 应该不会使用isa reg
            return minsts.end(); // nullopt
        }

        // 这个阶段应该还是InstLoadImme
        auto backiter = iter;
        do {
            --backiter;

            if (backiter == minsts.end()) { // iter = .begin()
                break;
            }

            auto minst_back = *backiter;
            if (minst_back->isGeneric() && minst_back->opcode<OpC>() == OpC::InstLoadImm &&
                mop2 == minst_back->ensureDef()) {
                return backiter;
            }

        } while (backiter != minsts.begin());

        return minsts.end();
    };
    // LAMBDA END
    auto &ctx = mfunc->CodeGenContext();

    if (isMUL()) {
        auto loadIter = findLoadImmtoOp2();

        if (loadIter == minsts.end()) {
            return false;
        }

        auto multipiler = static_cast<int>((*loadIter)->getOp(1)->imme());

        splited twin = SplitTo2PowX(multipiler);

        auto mdef = minst->ensureDef();
        auto mop1 = minst->getOp(1);

        using oper = splited::oper;
        if (twin.cul == oper::none) {
            // give up opt
            return false;
        } else if (twin.cul == oper::singlePos) {
            auto shiftimme = MIROperand::asImme(twin.exp1, OpT::Int32);

            auto lsl =
                MIRInst::make<OpC>(OpC::InstShl)->setOperand<0>(mdef)->setOperand<1>(mop1)->setOperand<2>(shiftimme);

            *iter = lsl;

            minsts.erase(loadIter);

            return true;
        } else if (twin.cul == oper::singleNeg) {
            auto shiftimme = MIROperand::asImme(twin.exp1, OpT::Int32);

            auto mop1_neg = MIROperand::asVReg(ctx.nextId(), OpT::Int32);

            auto neg = MIRInst::make<OpC>(OpC::InstNeg)->setOperand<0>(mop1_neg)->setOperand<1>(mop1);
            auto lsl = MIRInst::make<OpC>(OpC::InstShl)
                           ->setOperand<0>(mdef)
                           ->setOperand<1>(mop1_neg)
                           ->setOperand<2>(shiftimme);

            minsts.insert(iter, neg);
            *iter = lsl;

            minsts.erase(loadIter);

            return true;
        } else if (twin.cul == oper::addPos) {
            auto middle_result = MIROperand::asVReg(ctx.nextId(), OpT::Int32);
            auto shiftimme1 = MIROperand::asImme(twin.exp1, OpT::Int32);
            // auto shiftimme2 = MIROperand::asImme(twin.exp2, OpT::Int32);

            auto lsl = MIRInst::make<OpC>(OpC::InstShl)
                           ->setOperand<0>(middle_result)
                           ->setOperand<1>(mop1)
                           ->setOperand<2>(shiftimme1);

            auto add = MIRInst::make<OpC>(OpC::InstAdd)
                           ->setOperand<0>(mdef)
                           ->setOperand<1>(middle_result)
                           ->setOperand<2>(mop1)
                           ->setOperand<3>(MIROperand::asImme(twin.exp2 | 0x00000000, OpT::special)); // lsl

            minsts.insert(iter, lsl);
            *iter = add;

            minsts.erase(loadIter);

            return true;
        } else if (twin.cul == oper::addNeg) {
            auto middle_result = MIROperand::asVReg(ctx.nextId(), OpT::Int32);
            auto mop1_neg = MIROperand::asVReg(ctx.nextId(), OpT::Int32);
            auto shiftimme1 = MIROperand::asImme(twin.exp1, OpT::Int32);

            auto neg = MIRInst::make<OpC>(OpC::InstNeg)->setOperand<0>(mop1_neg)->setOperand<1>(mop1);
            auto lsl = MIRInst::make<OpC>(OpC::InstShl)
                           ->setOperand<0>(middle_result)
                           ->setOperand<1>(mop1_neg)
                           ->setOperand<2>(shiftimme1);

            auto add = MIRInst::make<OpC>(OpC::InstAdd)
                           ->setOperand<0>(mdef)
                           ->setOperand<1>(middle_result)
                           ->setOperand<2>(mop1_neg)
                           ->setOperand<3>(MIROperand::asImme(twin.exp2 | 0x00000000, OpT::special)); // lsl

            minsts.insert(iter, neg);
            minsts.insert(iter, lsl);

            *iter = add;

            minsts.erase(loadIter);

            return true;
        } else if (twin.cul == oper::sub) {

            auto middle_result = MIROperand::asVReg(ctx.nextId(), OpT::Int32);
            auto shiftimme1 = MIROperand::asImme(twin.exp1, OpT::Int32);
            auto shiftimme2 = MIROperand::asImme(twin.exp2, OpT::Int32);

            if (twin.exp2 > twin.exp1) {
                auto mop1_neg = MIROperand::asVReg(ctx.nextId(), OpT::Int32);

                auto neg = MIRInst::make<OpC>(OpC::InstNeg)->setOperand<0>(mop1_neg)->setOperand<1>(mop1);

                minsts.insert(iter, neg);
                std::swap(shiftimme1, shiftimme2);
                std::swap(mop1, mop1_neg);
            }

            auto lsl = MIRInst::make<OpC>(OpC::InstShl)
                           ->setOperand<0>(middle_result)
                           ->setOperand<1>(mop1) // maybe negative
                           ->setOperand<2>(shiftimme1);

            auto sub =
                MIRInst::make<OpC>(OpC::InstSub)
                    ->setOperand<0>(mdef)
                    ->setOperand<1>(middle_result)
                    ->setOperand<2>(mop1) // maybe negative
                    ->setOperand<3>(MIROperand::asImme(std::min(twin.exp1, twin.exp2) | 0x00000000, OpT::special));

            minsts.insert(iter, lsl);
            *iter = sub;

            minsts.erase(loadIter);

            return true;
        }
    }

    if (isDIV()) { // 实际上这个优化能有多大的效果很存疑
        auto loadIter = findLoadImmtoOp2();

        if (loadIter == minsts.end()) {
            return false;
        }

        auto divisor_const = static_cast<int>((*loadIter)->getOp(1)->imme());
        auto mdef = minst->ensureDef();
        auto dividend = minst->getOp(1);

        if (divisor_const < 0) {
            auto middle_result = MIROperand::asVReg(ctx.nextId(), OpT::Int32);

            auto neg = MIRInst::make<OpC>(OpC::InstNeg)->setOperand<0>(middle_result)->setOperand<1>(dividend);

            minsts.insert(iter, neg);
        }

        ///@brief 简单位移
        if (popcounter_wrapper(divisor_const) == 1) {
            ///@note 如果能预测到被除数范围, 对于正数则不必修正结果
            // asr1 获取补码符号
            // lsr 生成修正量
            // add 修正计算结果(虽然还没算)
            // asr2 除法计算

            auto exp = ctz_wrapper(divisor_const);

            auto mask = MIROperand::asVReg(ctx.nextId(), OpT::Int32);
            auto middle_result_1 = MIROperand::asVReg(ctx.nextId(), OpT::Int32);
            auto middle_result_2 = MIROperand::asVReg(ctx.nextId(), OpT::Int32);

            auto const_31 = MIROperand::asImme(31, OpT::Int32);
            auto const_lsr_shift = MIROperand::asImme(32 - exp, OpT::Int32);
            auto const_asr_shift = MIROperand::asImme(exp, OpT::Int32);

            auto asr1 =
                MIRInst::make(OpC::InstAShr)->setOperand<0>(mask)->setOperand<1>(dividend)->setOperand<2>(const_31);

            auto lsr = MIRInst::make(OpC::InstLShr)
                           ->setOperand<0>(middle_result_1)
                           ->setOperand<1>(mask)
                           ->setOperand<2>(const_lsr_shift);

            auto add = MIRInst::make(OpC::InstAdd)
                           ->setOperand<0>(middle_result_2)
                           ->setOperand<1>(dividend)
                           ->setOperand<2>(middle_result_1); // 修正取舍方向

            auto asr2 = MIRInst::make(OpC::InstAShr)
                            ->setOperand<0>(mdef)
                            ->setOperand<1>(middle_result_2)
                            ->setOperand<2>(const_asr_shift);

            minsts.insert(iter, asr1);
            minsts.insert(iter, lsr);
            minsts.insert(iter, add);
            *iter = asr2;

        }
        // div -> smull
        else {
            ///@note 情况有些复杂, 因为没了smmla和smmul, 优化为乘法 + 位移会导致语句极大的膨胀
            ///@note 如果能预测被除数一定是正数, 那么这个地方可以考虑优化

            return false;
        }

        minsts.erase(loadIter);
        return true;
    }

    return false;
}

bool GenericPeepholeImpl::matchFusedAdr(MatchInfo &info) {
    if (stage != Stage::AfterStackGenerate) {
        return false;
    }

    return false;
}
