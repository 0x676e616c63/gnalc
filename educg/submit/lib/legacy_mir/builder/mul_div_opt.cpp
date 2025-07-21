// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#include "../../../include/legacy_mir/tool.hpp"
#include "../../../include/legacy_mir/builder/lowering.hpp"
#include "../../../include/legacy_mir/instructions/binary.hpp"

namespace LegacyMIR {

splited SplitTo2PowX(int multiplier) {
    bool reverse = false;
    splited twin{};
    if (multiplier == 0) {
        // 乘0? 这真能有吗?
        Err::unreachable("mulopt: try mul with zero");
    } else if (multiplier < 0) {
        reverse = true;
        multiplier = std::abs(multiplier);
    }

    unsigned int cnt = popcount_wrapper((unsigned int)multiplier);

    switch (cnt) {
    case 0:
        /// @brief 乘0
        break;
    case 1:
        twin.exp1 = ctz_wrapper(multiplier);
        if (reverse)
            twin.cul = splited::oper::singleNeg;
        else
            twin.cul = splited::oper::singlePos;
        break;
    case 2:
        twin.exp1 = ctz_wrapper(multiplier);
        multiplier = multiplier >> (twin.exp1 + 1);
        twin.exp2 = ctz_wrapper(multiplier) + twin.exp1 + 1;
        if (reverse)
            twin.cul = splited::oper::addNeg;
        else
            twin.cul = splited::oper::addPos;
        break;
    default:
        unsigned int leading = clz_wrapper(multiplier);
        unsigned int tailing = ctz_wrapper(multiplier);

        if (leading + tailing + cnt != 32) {
            twin.cul = splited::oper::none;
        } else {
            twin.exp2 = tailing;
            twin.exp1 = tailing + cnt;
            twin.cul = splited::oper::sub;
            if (reverse)
                std::swap(twin.exp1, twin.exp2);
        }
        break;
    }

    return twin;
}

std::list<std::shared_ptr<Instruction>> mulOpt(const std::shared_ptr<BindOnVirOP> &target,
                                               const std::shared_ptr<IR::Value> &virRegVal,
                                               const std::shared_ptr<IR::ConstantInt> &constVal,
                                               OperandLowering &operlower, const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    int multipler = constVal->getVal();
    auto split = SplitTo2PowX(multipler);

    auto mulval = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(virRegVal));

    if (split.cul == splited::oper::singlePos) {
        // lsl Rd, Rm, #imme
        auto shitfimme = operlower.fastFind((int)split.exp1);

        auto lsl =
            std::make_shared<binaryImmInst>(OpCode::LSL, SourceOperandType::ri, target, mulval, shitfimme, nullptr);
        insts.emplace_back(lsl);
    } else if (split.cul == splited::oper::singleNeg) {
        // neg Rd, Rm
        // lsl Rd, Rm, #imme
        auto shitfimme = operlower.fastFind((int)split.exp1);
        auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);

        auto neg = std::make_shared<unaryInst>(OpCode::NEG, SourceOperandType::r, relay, mulval);
        auto lsl =
            std::make_shared<binaryImmInst>(OpCode::LSL, SourceOperandType::ri, target, relay, shitfimme, nullptr);
        insts.emplace_back(neg);
        insts.emplace_back(lsl);
    } else if (split.cul == splited::oper::addPos) {
        // lsl Rd, Rm, #imme1
        // add Rd, Rm, Rn, LSL #imme2
        auto shiftimme1 = operlower.fastFind((int)split.exp1);
        auto shiftimme2 = operlower.fastFind((int)split.exp2);
        auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);

        auto lsl =
            std::make_shared<binaryImmInst>(OpCode::LSL, SourceOperandType::ri, relay, mulval, shiftimme1, nullptr);
        auto add = std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::rsi, target, relay, mulval,
                                                   std::make_shared<ShiftOP>(split.exp2, ShiftOP::inlineShift::lsl));
        insts.emplace_back(lsl);
        insts.emplace_back(add);

    } else if (split.cul == splited::oper::addNeg) {
        // neg Rd, Rm
        // lsl Rd, Rm, #imme1
        // add Rd, Rm, Rn, LSL #imme2
        auto shiftimme1 = operlower.fastFind((int)split.exp1);
        auto shiftimme2 = operlower.fastFind((int)split.exp2);
        auto neg_relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);

        auto neg = std::make_shared<unaryInst>(OpCode::NEG, SourceOperandType::r, neg_relay, mulval);
        auto lsl =
            std::make_shared<binaryImmInst>(OpCode::LSL, SourceOperandType::ri, relay, neg_relay, shiftimme1, nullptr);
        auto add = std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::rsi, target, relay, neg_relay,
                                                   std::make_shared<ShiftOP>(split.exp2, ShiftOP::inlineShift::lsl));
        insts.emplace_back(neg);
        insts.emplace_back(lsl);
        insts.emplace_back(add);
    } else if (split.cul == splited::oper::sub) {
        auto shiftimme1 = operlower.fastFind((int)split.exp1);
        auto shiftimme2 = operlower.fastFind((int)split.exp2);

        if (split.exp2 > split.exp1) {
            // neg Rd, Rm
            auto neg_relay = std::dynamic_pointer_cast<BindOnVirOP>(
                operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr));
            auto neg = std::make_shared<unaryInst>(OpCode::NEG, SourceOperandType::r, neg_relay, mulval);

            insts.emplace_back(neg);
            std::swap(shiftimme1, shiftimme2);
            mulval = neg_relay;
        }

        if (split.exp1 == 1 || split.exp2 == 1) { // 这里可以保证1一定是减数
            // rsb Rd Rm Rn LSL #shiftimme1
            auto rsb = std::make_shared<binaryImmInst>(
                OpCode::RSB, SourceOperandType::rsi, target, mulval, mulval,
                std::make_shared<ShiftOP>(std::max(split.exp1, split.exp2), ShiftOP::inlineShift::lsl));

            insts.emplace_back(rsb);
        } else {
            // lsl Rd, Rm #shiftimme1
            // sub Rd Rm Rn LSL #shiftimme2
            auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
            auto lsl =
                std::make_shared<binaryImmInst>(OpCode::LSL, SourceOperandType::ri, relay, mulval, shiftimme1, nullptr);
            auto sub = std::make_shared<binaryImmInst>(
                OpCode::SUB, SourceOperandType::rsi, target, relay, mulval,
                std::make_shared<ShiftOP>(std::min(split.exp1, split.exp2), ShiftOP::inlineShift::lsl));

            insts.emplace_back(lsl);
            insts.emplace_back(sub);
        }
    } else if (split.cul == splited::oper::none) {
        // 做回自己
        auto multipler_op = operlower.LoadedFind(multipler, blk);

        auto mul = std::make_shared<binaryInst>(OpCode::MUL, SourceOperandType::rr, target, mulval, multipler_op);
        insts.emplace_back(mul);

    } else {
        Err::unreachable("unknown mul-split culculate mode");
    }

    return insts;
}

multiplication ChooseMultipler(int divisor) {
    int log_2 = 32 - clz_wrapper(divisor - 1);
    int shift = log_2;

    size_t low = (std::size_t(1) << (32 + shift)) / divisor;
    size_t high = ((std::size_t(1) << (32 + shift)) + (std::size_t(1) << (shift + 1))) / divisor;

    while ((low >> 1) < (high >> 1) && shift > 0) {
        low >>= 1;
        high >>= 1;
        shift--;
    }

    // 尝试了几个极大极小的值, 发现这里强制转为int应该是可行的
    return multiplication{(int)high, shift};
}

std::list<std::shared_ptr<Instruction>> divOpt(const std::shared_ptr<BindOnVirOP> &target,
                                               const std::shared_ptr<IR::Value> &virRegVal,
                                               const std::shared_ptr<IR::ConstantInt> &constVal,
                                               OperandLowering &operlower, const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    int divisor_const = constVal->getVal();
    auto dividend = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(virRegVal));

    // neg Rd, Rm
    if (divisor_const < 0) {
        auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);

        auto neg = std::make_shared<unaryInst>(OpCode::NEG, SourceOperandType::r, relay, dividend);

        dividend = relay;
        divisor_const = std::abs(divisor_const);
        insts.emplace_back(neg);
    }

    if (popcount_wrapper(divisor_const) == 1) {
        // asr	temp1, dividend, #31                ; temp1是一个掩码(0xFFFFFFFF)
        // lsr	temp2, temp1, #32 - log2(divisor)   ; dividend为正时, temp2 = 0; 反之 temp2 = divisor - 1;
        // add	temp3, divident, temp2              ; 当dividend为负数, 修正为向0取整, dividend + divisor - 1
        // asr	target, temp3, #log2(divisor)
        ///@note 一条变4条, 很蠢, 但有用, 建议搭配指令重排食用
        auto exp = ctz_wrapper(divisor_const);

        auto relay1 = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto relay2 = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto relay3 = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);

        auto const_31 = operlower.fastFind(31);
        auto const_lsr_shift = operlower.fastFind(32 - exp);
        auto const_asr_shift = operlower.fastFind(exp);

        auto asr1 =
            std::make_shared<binaryImmInst>(OpCode::ASR, SourceOperandType::ri, relay1, dividend, const_31, nullptr);
        auto lsr = std::make_shared<binaryImmInst>(OpCode::LSR, SourceOperandType::ri, relay2, relay1, const_lsr_shift,
                                                   nullptr);
        auto add =
            std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::rr, relay3, dividend, relay2, nullptr);
        auto asr2 = std::make_shared<binaryImmInst>(OpCode::ASR, SourceOperandType::ri, target, relay3, const_asr_shift,
                                                    nullptr);
        insts.emplace_back(asr1);
        insts.emplace_back(lsr);
        insts.emplace_back(add);
        insts.emplace_back(asr2);
    } else {
        multiplication multipler = ChooseMultipler(divisor_const); // 默认精度31

        int multipler_const = (multipler.mul > 0x80000000) ? int(multipler.mul - 0x80000000) : multipler.mul;

        auto shift = operlower.fastFind(multipler.shift);

        auto relay = operlower.LoadedFind(multipler_const, blk);

        auto relay2 = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        if (multipler.mul > 0x80000000) {
            // smmla temp2, dividend, temp1, dividend
            auto smmla =
                std::make_shared<ternaryInst>(OpCode::SMMLA, SourceOperandType::rrr, relay2, dividend, relay, dividend);
            insts.emplace_back(smmla);
        } else {
            // smmul temp2, dividend, temp1
            auto smmul = std::make_shared<binaryInst>(OpCode::SMMUL, SourceOperandType::rr, relay2, dividend, relay);
            insts.emplace_back(smmul);
        }

        // asr temp3, temp2, #shift (shift为0时, 此条省略)
        // add target, temp3, dividend, LSR #31
        if (multipler.shift) {
            auto relay3 = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
            auto asr = std::make_shared<binaryImmInst>(OpCode::ASR, SourceOperandType::ri, relay3, relay2, shift,
                                                       nullptr); // relay2
            insts.emplace_back(asr);
            relay2 = relay3;
        }

        auto add = std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::rsi, target, relay2, dividend,
                                                   std::make_shared<ShiftOP>(31, ShiftOP::inlineShift::lsr));
        insts.emplace_back(add);
    }

    return insts;
}

} // namespace MIR
#endif