#include "../../../include/mir/SIMDinstruction/arithmetics.hpp"
#include "../../../include/mir/builder/lowering.hpp"
#include "../../../include/mir/instructions/binary.hpp"
#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mir/instructions/copy.hpp"
#include "../../../include/mir/instructions/memory.hpp"
#include "../../../include/mirtools/tool.hpp"
#include <cassert>

using namespace MIR;

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

            auto pair = operlower.LoadedFind(constVal);

            if (!pair.first) {
                // mov

                auto constOP = operlower.fastFind(constVal);
                auto mov = std::make_shared<movInst>(SourceOperandType::i32, pair.second, constOP);
                insts.emplace_back(mov);
            }

            /// copy 很有机会消除
            auto copy = std::make_shared<COPY>(target, pair.second);
            insts.emplace_back(copy);
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

            auto pair = operlower.LoadedFind(constVal);

            if (!pair.first) {
                // mov

                auto constOP = operlower.fastFind(constVal);
                auto mov = std::make_shared<movInst>(SourceOperandType::i32, pair.second, constOP);
                insts.emplace_back(mov);
            }

            /// copy 很有机会消除
            auto copy = std::make_shared<COPY>(target, pair.second);
            insts.emplace_back(copy);
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
            int constVal = rconst->getVal() * lconst->getVal();

            auto pair = operlower.LoadedFind(constVal);

            if (!pair.first) {
                // mov

                auto constOP = operlower.fastFind(constVal);
                auto mov = std::make_shared<movInst>(SourceOperandType::i32, pair.second, constOP);
                insts.emplace_back(mov);
            }

            /// copy 很有机会消除
            auto copy = std::make_shared<COPY>(target, pair.second);
            insts.emplace_back(copy);
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

            auto pair = operlower.LoadedFind(constVal);

            if (!pair.first) {
                // mov

                auto constOP = operlower.fastFind(constVal);
                auto mov = std::make_shared<movInst>(SourceOperandType::i32, pair.second, constOP);
                insts.emplace_back(mov);
            }

            /// copy 很有机会消除
            auto copy = std::make_shared<COPY>(target, pair.second);
            insts.emplace_back(copy);
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
