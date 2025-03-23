#include "../../../include/mir/SIMDinstruction/arithmetics.hpp"
#include "../../../include/mir/builder/lowering.hpp"
#include "../../../include/mir/instructions/binary.hpp"
#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mir/instructions/copy.hpp"
#include "../../../include/mir/instructions/memory.hpp"
#include "../../../include/mirtools/tool.hpp"
#include <cassert>

using namespace MIR;

struct splited {
    unsigned int exp1;
    unsigned int exp2;
    enum class oper { singlePos, singleNeg, addPos, addNeg, sub, none } cul;
};

splited SplitTo2PowX(int);

std::list<std::shared_ptr<Instruction>> mulOpt(const std::shared_ptr<BindOnVirOP> &target,
                                               const std::shared_ptr<IR::Value> &virRegVal,
                                               const std::shared_ptr<IR::ConstantInt> &constVal,
                                               OperandLowering &operlower);

struct multiplication {
    int mul;
    int shift;
};

multiplication ChooseMultipler(int);

std::list<std::shared_ptr<Instruction>> divOpt(const std::shared_ptr<BindOnVirOP> &target,
                                               const std::shared_ptr<IR::Value> &virRegVal,
                                               const std::shared_ptr<IR::ConstantInt> &constVal,
                                               OperandLowering &operlower);
//仅在除数为常数时使用, 参考资料https://thysrael.github.io/posts/4848be12, Division by Invariant Integers using Multiplication(论文)

std::list<std::shared_ptr<Instruction>> InstLowering::binaryLower(const std::shared_ptr<IR::BinaryInst> &binary) {
    auto target = operlower.mkOP(*binary, RegisterBank::gpr);

    auto op = binary->getOpcode();

    std::list<std::shared_ptr<Instruction>> insts;

    std::shared_ptr<IR::Value> rval = binary->getRHS();
    std::shared_ptr<IR::Value> lval = binary->getLHS();

    // ====================
    // 转化为 add / mov + add
    // ====================
    if (op == IR::OP::ADD) {
        auto rconst = std::dynamic_pointer_cast<IR::ConstantInt>(rval);
        auto lconst = std::dynamic_pointer_cast<IR::ConstantInt>(lval);

        // ====================
        // 1. 常量拦截
        // ====================
        if (rconst && lconst) {
            int constVal = rconst->getVal() + lconst->getVal();

            auto constOP = operlower.fastFind(constVal);

            auto mov = std::make_shared<movInst>(SourceOperandType::i32, target, constOP);
            insts.emplace_back(mov);
        }
        // ===================
        // 2. 第二操作数为常量
        // ===================
        else if (rconst) {
            int constVal = rconst->getVal();

            auto regOP = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));
            auto constOP = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(constVal));

            ///@brief 判断是否超出范围, 加一条movInst, 此时需要一个新的中继操作数
            if (constOP->getConst()->isEncoded()) {

                auto pair = operlower.LoadedFind(constVal);
                auto relay = pair.second;

                if (!pair.first) {
                    auto mov = std::make_shared<movInst>(SourceOperandType::i32, relay, constOP);
                    insts.emplace_back(mov);
                }

                auto add =
                    std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::rr, target, regOP, relay, nullptr);

                insts.emplace_back(add);
            } else {
                auto add = std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, target, regOP, constOP,
                                                           nullptr);
                insts.emplace_back(add);
            }
        }
        // ===================
        // 3. 第一操作数为常量
        // ===================
        else if (lconst) {
            int constVal = lconst->getVal();

            auto regOP = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));
            auto constOP = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(constVal));

            ///@brief 判断是否超出范围, 加一条movInst, 此时需要一个新的中继操作数
            if (constOP->getConst()->isEncoded()) {

                auto pair = operlower.LoadedFind(constVal);
                auto relay = pair.second;

                if (!pair.first) {
                    auto mov = std::make_shared<movInst>(SourceOperandType::i32, relay, constOP);
                    insts.emplace_back(mov);
                }

                auto add =
                    std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::rr, target, regOP, relay, nullptr);
                insts.emplace_back(add);
            } else {
                auto add = std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, target, regOP, constOP,
                                                           nullptr);
                insts.emplace_back(add);
            }
        }
        // ===================
        // 4. 无常量
        // ===================
        else {
            auto rop = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));
            auto lop = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));

            auto add = std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::rr, target, rop, lop, nullptr);
            insts.emplace_back(add);
        }

    }

    // ====================
    // 转化为 sub / rsb / mov + sub
    // ====================
    else if (op == IR::OP::SUB) {
        auto rconst = std::dynamic_pointer_cast<IR::ConstantInt>(rval);
        auto lconst = std::dynamic_pointer_cast<IR::ConstantInt>(lval);

        // ====================
        // 1. 常量拦截
        // ====================
        if (rconst && lconst) {
            int constVal = lconst->getVal() - rconst->getVal();
            auto constOP = operlower.fastFind(constVal);

            auto mov = std::make_shared<movInst>(SourceOperandType::i32, target, constOP);
            insts.emplace_back(mov);
        }
        // ===================
        // 2. 第二操作数为常量
        // ===================
        else if (rconst) {
            int constVal = rconst->getVal();

            auto regOP = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));
            auto constOP = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(constVal));

            ///@brief 判断是否超出范围, 加一条movInst, 此时需要一个新的中继操作数
            if (constOP->getConst()->isEncoded()) {
                auto pair = operlower.LoadedFind(constVal);
                auto relay = pair.second;

                if (!pair.first) {
                    auto mov = std::make_shared<movInst>(SourceOperandType::i32, relay, constOP);
                    insts.emplace_back(mov);
                }

                auto sub =
                    std::make_shared<binaryImmInst>(OpCode::SUB, SourceOperandType::rr, target, regOP, relay, nullptr);

                insts.emplace_back(sub);
            } else {
                auto sub = std::make_shared<binaryImmInst>(OpCode::SUB, SourceOperandType::ri, target, regOP, constOP,
                                                           nullptr);
                insts.emplace_back(sub);
            }
        }
        // ===================
        // 3. 第一操作数为常量
        // ===================
        else if (lconst) {
            int constVal = lconst->getVal();

            auto regOP = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));
            auto constOP = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(constVal));

            ///@brief 判断是否超出范围, 加一条movInst, 此时需要一个新的中继操作数
            if (constOP->getConst()->isEncoded()) {
                auto pair = operlower.LoadedFind(constVal);

                auto relay = pair.second;

                if (!pair.first) {
                    auto mov = std::make_shared<movInst>(SourceOperandType::i32, relay, constOP);
                    insts.emplace_back(mov);
                }

                auto rsb =
                    std::make_shared<binaryImmInst>(OpCode::RSB, SourceOperandType::rr, target, regOP, relay, nullptr);
                insts.emplace_back(rsb);
            } else {
                auto rsb = std::make_shared<binaryImmInst>(OpCode::RSB, SourceOperandType::ri, target, regOP, constOP,
                                                           nullptr);
                insts.emplace_back(rsb);
            }
        }
        // ===================
        // 4. 无常量
        // ===================
        else {
            auto rop = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));
            auto lop = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));

            auto sub = std::make_shared<binaryImmInst>(OpCode::SUB, SourceOperandType::rr, target, rop, lop, nullptr);
            insts.emplace_back(sub);
        }
    }

    // =================
    // 转化为 mul / mov + mul
    // ==================
    else if (op == IR::OP::MUL) {
        auto rconst = std::dynamic_pointer_cast<IR::ConstantInt>(rval);
        auto lconst = std::dynamic_pointer_cast<IR::ConstantInt>(lval);

        // ====================
        // 1. 常量拦截
        // ====================
        if (rconst && lconst) {
            int constVal = lconst->getVal() * rconst->getVal();
            auto constOP = operlower.fastFind(constVal);

            auto mov = std::make_shared<movInst>(SourceOperandType::i32, target, constOP);
            insts.emplace_back(mov);
        }
        // ===================
        // 2. 第二操作数为常量, 选择优化
        // ===================
        else if (rconst) {
            int constVal = rconst->getVal();

            if (SplitTo2PowX(constVal).cul != splited::oper::none) {
                insts.splice(insts.end(), mulOpt(target, lval, rconst, operlower));

            } else {
                auto regOP = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));
                auto constOP = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(constVal));

                auto pair = operlower.LoadedFind(constVal);
                auto relay = pair.second;
                if (!pair.first) {
                    auto mov = std::make_shared<movInst>(SourceOperandType::i32, relay, constOP);
                    insts.emplace_back(mov);
                }

                auto mul = std::make_shared<binaryInst>(OpCode::MUL, SourceOperandType::rr, target, regOP, relay);

                insts.emplace_back(mul);
            }
        }
        // ===================
        // 3. 第一操作数为常量, 同样的优化
        // ===================
        else if (lconst) {
            int constVal = lconst->getVal();

            if (SplitTo2PowX(constVal).cul != splited::oper::none) {
                insts.splice(insts.end(), mulOpt(target, rval, lconst, operlower));
            } else {
                auto regOP = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));
                auto constOP = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(constVal));

                auto pair = operlower.LoadedFind(constVal);
                auto relay = pair.second;
                if (!pair.first) {
                    auto mov = std::make_shared<movInst>(SourceOperandType::i32, relay, constOP);
                    insts.emplace_back(mov);
                }

                auto mul = std::make_shared<binaryInst>(OpCode::MUL, SourceOperandType::rr, target, regOP, relay);

                insts.emplace_back(mul);
            }
        }
        // ===================
        // 4. 无常量
        // ===================
        else {
            auto rop = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));
            auto lop = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));

            auto mul = std::make_shared<binaryInst>(OpCode::MUL, SourceOperandType::rr, target, rop, lop);
            insts.emplace_back(mul);
        }
    }

    // =================
    // 转化为 sdiv / mov + sdiv
    // =================
    else if (op == IR::OP::DIV) {
        auto rconst = std::dynamic_pointer_cast<IR::ConstantInt>(rval);
        auto lconst = std::dynamic_pointer_cast<IR::ConstantInt>(lval);

        // ====================
        // 1. 常量拦截
        // ====================
        if (rconst && lconst) {
            int constVal = lconst->getVal() / rconst->getVal();
            auto constOP = operlower.fastFind(constVal);

            auto mov = std::make_shared<movInst>(SourceOperandType::i32, target, constOP);
            insts.emplace_back(mov);
        }
        // ===================
        // 2. 第二操作数为常量, 除常数优化
        // ===================
        else if (rconst) {
            // int constVal = rconst->getVal();

            insts.splice(insts.end(), divOpt(target, lval, rconst, operlower));
        }
        // ===================
        // 3. 第一操作数为常量
        // ===================
        else if (lconst) {
            int constVal = lconst->getVal();

            auto regOP = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));
            auto constOP = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(constVal));

            auto pair = operlower.LoadedFind(constVal);
            auto relay = pair.second;
            if (!pair.first) {
                auto mov = std::make_shared<movInst>(SourceOperandType::i32, relay, constOP);
                insts.emplace_back(mov);
            }

            auto sdiv = std::make_shared<binaryInst>(OpCode::SDIV, SourceOperandType::rr, target, relay, regOP);

            insts.emplace_back(sdiv);
        }
        // ===================
        // 4. 无常量
        // ===================
        else {
            auto rop = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));
            auto lop = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));

            auto sdiv = std::make_shared<binaryInst>(OpCode::SDIV, SourceOperandType::rr, target, rop, lop);
            insts.emplace_back(sdiv);
        }
    }

    // ==================
    // 转换为 若干mov(如果需要) + sdiv + mls
    // ==================
    else if (op == IR::OP::REM) {
        auto rconst = std::dynamic_pointer_cast<IR::ConstantInt>(rval);
        auto lconst = std::dynamic_pointer_cast<IR::ConstantInt>(lval);
        // ===================
        // step1: 使用mov加载到寄存器
        // ===================
        std::shared_ptr<BindOnVirOP> dividend;
        std::shared_ptr<BindOnVirOP> divisor;

        if (rconst) {
            auto constOP = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(rconst->getVal()));

            auto pair = operlower.LoadedFind(rconst->getVal());
            auto relay = pair.second;
            if (!pair.first) {
                auto mov = std::make_shared<movInst>(SourceOperandType::i32, relay, constOP);
                insts.emplace_back(mov);
            }

            divisor = relay;
        } else {
            divisor = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));
        }

        if (lconst) {
            auto constOP = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(lconst->getVal()));

            auto pair = operlower.LoadedFind(lconst->getVal());
            auto relay = pair.second;
            if (!pair.first) {
                auto mov = std::make_shared<movInst>(SourceOperandType::i32, relay, constOP);
                insts.emplace_back(mov);
            }
            dividend = relay;
        } else {
            dividend = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));
        }

        // ====================
        // step2: sdiv + mls
        // ====================
        auto quotient = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);

        auto sdiv = std::make_shared<binaryInst>(OpCode::SDIV, SourceOperandType::rr, quotient, dividend, divisor);

        auto mls =
            std::make_shared<ternaryInst>(OpCode::MLS, SourceOperandType::rrr, target, quotient, divisor, dividend);
        insts.emplace_back(sdiv);
        insts.emplace_back(mls);

    } else {
        Err::unreachable("binary lowering: Unexpected IR::OP.");
    }

    return insts;
}

splited SplitTo2PowX(int multiplier) {
    bool reverse = false;
    splited twin{};
    if (multiplier == 0) {
        // 乘0? 这真能有吗?
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
                                               OperandLowering &operlower) {
    std::list<std::shared_ptr<Instruction>> insts;

    int multipler = constVal->getVal();
    auto split = SplitTo2PowX(multipler);

    if (split.cul == splited::oper::singlePos) {
        // lsl Rd, Rm, #imme
        auto shitfimme = operlower.fastFind((int)split.exp1);
        auto mulval = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(virRegVal));

        auto lsl =
            std::make_shared<binaryImmInst>(OpCode::LSL, SourceOperandType::ri, target, mulval, shitfimme, nullptr);
        insts.emplace_back(lsl);
    } else if (split.cul == splited::oper::singleNeg) {
        // neg Rd, Rm
        // lsl Rd, Rm, #imme
        auto shitfimme = operlower.fastFind((int)split.exp1);
        auto mulval = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(virRegVal));
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
        auto mulval = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(virRegVal));
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
        auto mulval = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(virRegVal));
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
        if (split.exp1 > split.exp2) {
            // lsl Rd, Rm, #imme1
            // sub Rd, Rm, Rn, LSL #imme2
            auto shiftimme1 = operlower.fastFind((int)split.exp1);
            auto shiftimme2 = operlower.fastFind((int)split.exp2);
            auto mulvir = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(virRegVal));
            auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);

            auto lsl =
                std::make_shared<binaryImmInst>(OpCode::LSL, SourceOperandType::r, relay, mulvir, shiftimme1, nullptr);
            auto sub =
                std::make_shared<binaryImmInst>(OpCode::SUB, SourceOperandType::rsi, target, relay, mulvir,
                                                std::make_shared<ShiftOP>(split.exp2, ShiftOP::inlineShift::lsl));
            insts.emplace_back(lsl);
            insts.emplace_back(sub);
        } else {
            // neg Rd, Rm
            // lsl Rd, Rm, #imme2
            // sub Rd, Rm, Rn, LSL #imme1
            auto shiftimme1 = operlower.fastFind((int)split.exp1);
            auto shiftimme2 = operlower.fastFind((int)split.exp2);
            auto mulvir = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(virRegVal));
            auto neg_relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
            auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);

            auto neg = std::make_shared<unaryInst>(OpCode::NEG, SourceOperandType::r, neg_relay, mulvir);

            auto lsl = std::make_shared<binaryImmInst>(OpCode::LSL, SourceOperandType::r, relay, neg_relay, shiftimme2,
                                                       nullptr);
            auto sub =
                std::make_shared<binaryImmInst>(OpCode::SUB, SourceOperandType::rsi, target, relay, neg_relay,
                                                std::make_shared<ShiftOP>(split.exp1, ShiftOP::inlineShift::lsl));
            insts.emplace_back(neg);
            insts.emplace_back(lsl);
            insts.emplace_back(sub);
        }
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
                                               OperandLowering &operlower) {
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

        std::shared_ptr<Operand> const_mul;
        if (multipler.mul > 0x80000000)
            const_mul = operlower.fastFind(int(multipler.mul - 0x80000000));
        else
            const_mul = operlower.fastFind(multipler.mul);
        auto shift = operlower.fastFind(multipler.shift);

        auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto mov = std::make_shared<movInst>(SourceOperandType::i, relay, const_mul);
        insts.emplace_back(mov);

        auto relay2 = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        if (multipler.mul > 0x80000000) {
            // smmla temp2, dividend, temp1, dividend
            auto smmla =
                std::make_shared<ternaryInst>(OpCode::SMMLA, SourceOperandType::rrr, relay2, dividend, relay, dividend);
            insts.emplace_back(smmla);
        } else {
            // smmul temp2, dividend, temp1
            auto smmul = std::make_shared<binaryInst>(OpCode::SMMUL, SourceOperandType::rr, relay2, dividend, relay);
        }

        // asr temp3, temp2, #shift (shift为0时, 此条省略)
        // add target, temp3, dividend, LSR #31
        if (multipler.shift) {
            auto relay3 = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
            auto asr =
                std::make_shared<binaryImmInst>(OpCode::ASR, SourceOperandType::ri, relay3, relay2, shift, nullptr);
            insts.emplace_back(asr);
            relay2 = relay3;
        }

        auto add = std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::rsi, target, relay2, dividend,
                                                   std::make_shared<ShiftOP>(31, ShiftOP::inlineShift::lsr));
        insts.emplace_back(add);
    }

    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::binaryLower_v(const std::shared_ptr<IR::BinaryInst> &binary) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto target = operlower.mkOP(*binary, RegisterBank::spr);

    auto op = binary->getOpcode();

    std::shared_ptr<IR::Value> rval = binary->getRHS();
    std::shared_ptr<IR::Value> lval = binary->getLHS();

    std::shared_ptr<BindOnVirOP> oper1;
    std::shared_ptr<BindOnVirOP> oper2;

    auto lconst = std::dynamic_pointer_cast<IR::ConstantFloat>(rval);
    auto rconst = std::dynamic_pointer_cast<IR::ConstantFloat>(lval);

    if (lconst) {
        float const_float = lconst->getVal();

        auto pair = operlower.LoadedFind(const_float);
        oper1 = pair.second;
        if (!pair.first) {
            // mov %oper1, #imme
            auto mov = std::make_shared<movInst>(SourceOperandType::ri, oper1, operlower.fastFind(const_float));
            insts.emplace_back(mov);
        }
    } else {
        oper1 = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));
    }

    if (rconst) {
        float const_float = rconst->getVal();

        auto pair = operlower.LoadedFind(const_float);
        oper2 = pair.second;
        if (!pair.first) {
            // mov %oper2, #imme
            auto mov = std::make_shared<movInst>(SourceOperandType::ri, oper2, operlower.fastFind(const_float));
            insts.emplace_back(mov);
        }
    } else {
        if (rval)
            oper2 = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));
        else
            oper2 = nullptr;
    }

    /// vxxx %target, %oper1, %oper2

    auto datapair = std::make_pair(bitType::f32, bitType::DEFAULT32);
    switch (op) {
    case IR::OP::FADD: {
        auto vadd = std::make_shared<Vbinary>(MIR::NeonOpCode::VADD, target, oper1, oper2, datapair);
        insts.emplace_back(vadd);
    } break;

    case IR::OP::FSUB: {
        auto vsub = std::make_shared<Vbinary>(MIR::NeonOpCode::VSUB, target, oper1, oper2, datapair);
        insts.emplace_back(vsub);
    } break;

    case IR::OP::FMUL: {
        auto vmul = std::make_shared<Vbinary>(MIR::NeonOpCode::VMUL, target, oper1, oper2, datapair);
        insts.emplace_back(vmul);
    } break;
    case IR::OP::FDIV: {
        auto vdiv = std::make_shared<Vbinary>(MIR::NeonOpCode::VMUL, target, oper1, oper2, datapair);
        insts.emplace_back(vdiv);
    } break;
    case IR::OP::FNEG: {
        auto vneg = std::make_shared<Vunary>(MIR::NeonOpCode::VNEG, target, oper1, datapair);
        insts.emplace_back(vneg);
    } break;
    case IR::OP::FREM: {
        // vdiv.f32	%tmp1, %oper1, %oper2
        // vmul.f32	%tmp2, %oper2, %tmp1
        // vsub.f32	%target, %oper1, %tmp2
        auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::FLOAT), RegisterBank::spr);
        auto relay2 = operlower.mkOP(IR::makeBType(IR::IRBTYPE::FLOAT), RegisterBank::spr);

        auto vdiv = std::make_shared<Vbinary>(NeonOpCode::VDIV, relay, oper1, oper2, datapair);
        auto vmul = std::make_shared<Vbinary>(NeonOpCode::VMUL, relay2, oper2, relay, datapair);
        auto vsub = std::make_shared<Vbinary>(NeonOpCode::VSUB, target, oper1, relay2, datapair);
        insts.emplace_back(vdiv);
        insts.emplace_back(vmul);
        insts.emplace_back(vsub);
    } break;
    default:
        Err::unreachable("instLower: binarylower_v encountered unknown IR::OP");
    }

    return insts;
}
