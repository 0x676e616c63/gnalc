#include "mir/SIMDinstruction/arithmetics.hpp"
#include "mir/SIMDinstruction/memory.hpp"
#include "mir/builder/lowering.hpp"
#include "mir/instructions/binary.hpp"
#include "mir/instructions/branch.hpp"
#include "mir/instructions/copy.hpp"
#include "mirtools/tool.hpp"

using namespace MIR;

std::list<std::shared_ptr<Instruction>> InstLowering::binaryLower(const std::shared_ptr<IR::BinaryInst> &binary,
                                                                  const std::shared_ptr<BasicBlock> &blk) {
    auto target = operlower.mkOP(*binary, RegisterBank::gpr);

    auto op = binary->getOpcode();

    std::list<std::shared_ptr<Instruction>> insts;

    std::shared_ptr<IR::Value> rval = binary->getRHS();
    std::shared_ptr<IR::Value> lval = binary->getLHS();

    auto rconst = rval->as<IR::ConstantInt>();
    auto lconst = lval->as<IR::ConstantInt>();

    // ====================
    // 1. 常量拦截
    // ====================
    // ... ...

    // ====================
    // 转化为 add
    // ====================
    if (op == IR::OP::ADD) {
        if (rconst && lconst) {
            int constVal = lconst->getVal() + rconst->getVal();

            auto result = operlower.LoadedFind(constVal, blk); // 预加载的字面量

            /// 一般认为 copy 很有机会消除
            auto copy = make<COPY>(target, result);
            insts.emplace_back(copy);

            return insts;
        }

        std::shared_ptr<MIR::binaryImmInst> add = nullptr;

        // 2. 某个操作数为常量
        if (rconst || lconst) {
            int constVal = rconst != nullptr ? rconst->getVal() : lconst->getVal();

            auto reg_1 = operlower.fastFind(rconst != nullptr ? lval : rval)->as<BindOnVirOP>();
            std::shared_ptr<Operand> reg_2;

            auto constOP = operlower.fastFind(constVal)->as<ConstantIDX>();

            if (constOP->getConst()->isEncoded())
                reg_2 = operlower.LoadedFind(constVal, blk);
            else
                reg_2 = constOP;

            add = make<binaryImmInst>(OpCode::ADD, (reg_2 == constOP ? SourceOperandType::ri : SourceOperandType::rr),
                                      target, reg_1, reg_2, nullptr);
        }
        // 3. 无常量
        else {
            auto reg_2 = operlower.fastFind(rval)->as<BindOnVirOP>();
            auto reg_1 = operlower.fastFind(lval)->as<BindOnVirOP>();

            add = make<binaryImmInst>(OpCode::ADD, SourceOperandType::rr, target, reg_1, reg_2, nullptr);
        }
        insts.emplace_back(add);

    }

    // ====================
    // 转化为 sub / rsb
    // ====================
    else if (op == IR::OP::SUB) {
        if (rconst && lconst) {
            int constVal = lconst->getVal() - rconst->getVal();

            auto result = operlower.LoadedFind(constVal, blk); // 预加载的字面量

            /// 一般认为 copy 很有机会消除
            auto copy = make<COPY>(target, result);
            insts.emplace_back(copy);

            return insts;
        }

        std::shared_ptr<MIR::binaryImmInst> sub; // sub or rsb

        // 2. 一个操作数为常量
        if (rconst || lconst) {
            int constVal = rconst != nullptr ? rconst->getVal() : lconst->getVal();

            auto reg_1 = operlower.fastFind(rconst != nullptr ? lval : rval)->as<BindOnVirOP>();
            std::shared_ptr<Operand> reg_2;

            auto constOP = operlower.fastFind(constVal)->as<ConstantIDX>();

            if (constOP->getConst()->isEncoded())
                reg_2 = operlower.LoadedFind(constVal, blk);
            else
                reg_2 = constOP;

            sub = make<binaryImmInst>((rconst != nullptr ? OpCode::SUB : OpCode::RSB),
                                      (constOP ? SourceOperandType::ri : SourceOperandType::rr), target, reg_1, reg_2,
                                      nullptr);
        }
        // 4. 无常量
        else {
            auto reg_2 = operlower.fastFind(rval)->as<BindOnVirOP>();
            auto reg_1 = operlower.fastFind(lval)->as<BindOnVirOP>();

            sub = make<binaryImmInst>(OpCode::SUB, SourceOperandType::rr, target, reg_1, reg_2, nullptr);
        }
        insts.emplace_back(sub);
    }

    // =================
    // 转化为 mul / mov + mul
    // ==================
    else if (op == IR::OP::MUL) {
        if (rconst && lconst) {
            int constVal = lconst->getVal() * rconst->getVal();

            auto result = operlower.LoadedFind(constVal, blk); // 预加载的字面量

            /// 一般认为 copy 很有机会消除
            auto copy = make<COPY>(target, result);
            insts.emplace_back(copy);

            return insts;
        }

        std::shared_ptr<MIR::binaryInst> mul;

        // 2. 第二操作数为常量, 选择优化
        if (rconst || lconst) {
            int constVal = rconst != nullptr ? rconst->getVal() : lconst->getVal();
            auto regVal = rconst != nullptr ? lval : rval;

            if (SplitTo2PowX(constVal).cul != splited::oper::none) {
                insts.splice(insts.end(), mulOpt(target, regVal, rconst != nullptr ? rconst : lconst, operlower, blk));
                return insts;
            }

            auto reg_1 = operlower.fastFind(regVal)->as<BindOnVirOP>();
            auto reg_2 = operlower.LoadedFind(constVal, blk);

            mul = make<binaryInst>(OpCode::MUL, SourceOperandType::rr, target, reg_1, reg_2);
        }
        // 4. 无常量
        else {
            auto reg_2 = operlower.fastFind(rval)->as<BindOnVirOP>();
            auto reg_1 = operlower.fastFind(lval)->as<BindOnVirOP>();

            mul = make<binaryInst>(OpCode::MUL, SourceOperandType::rr, target, reg_1, reg_2);
        }

        insts.emplace_back(mul);
    }

    // =================
    // 转化为 sdiv / mov + sdiv
    // =================
    else if (op == IR::OP::DIV) {
        if (rconst && lconst) {
            int constVal = lconst->getVal() / rconst->getVal();

            auto result = operlower.LoadedFind(constVal, blk); // 预加载的字面量

            /// 一般认为 copy 很有机会消除
            auto copy = make<COPY>(target, result);
            insts.emplace_back(copy);

            return insts;
        }

        std::shared_ptr<MIR::binaryInst> sdiv;
        // ===================
        // 2. 第二操作数为常量, 除常数优化
        // ===================
        if (rconst) {
            insts.splice(insts.end(), divOpt(target, lval, rconst, operlower, blk));
            return insts;
        }
        // ===================
        // 3. 第一操作数为常量
        // ===================
        else if (lconst) {
            int constVal = lconst->getVal();

            auto regOP = operlower.fastFind(rval)->as<BindOnVirOP>();

            auto relay = operlower.LoadedFind(constVal, blk);

            sdiv = make<binaryInst>(OpCode::SDIV, SourceOperandType::rr, target, relay, regOP);

        }
        // ===================
        // 4. 无常量
        // ===================
        else {
            auto reg_2 = operlower.fastFind(rval)->as<BindOnVirOP>();
            auto reg_1 = operlower.fastFind(lval)->as<BindOnVirOP>();

            sdiv = make<binaryInst>(OpCode::SDIV, SourceOperandType::rr, target, reg_1, reg_2);
        }
        insts.emplace_back(sdiv);

    }

    // ==================
    // 转换为 若干mov(如果需要) + sdiv + mls
    // ==================
    else if (op == IR::OP::REM) {
        if (rconst && lconst) {
            int constVal = lconst->getVal() % rconst->getVal();

            auto result = operlower.LoadedFind(constVal, blk); // 预加载的字面量

            /// 一般认为 copy 很有机会消除
            auto copy = make<COPY>(target, result);
            insts.emplace_back(copy);

            return insts;
        }

        std::shared_ptr<BindOnVirOP> dividend;
        std::shared_ptr<BindOnVirOP> divisor;

        if (rconst) {
            auto relay = operlower.LoadedFind(rconst->getVal(), blk);

            divisor = relay;
        } else
            divisor = operlower.fastFind(rval)->as<BindOnVirOP>();

        if (lconst) {
            auto relay = operlower.LoadedFind(lconst->getVal(), blk);

            dividend = relay;
        } else
            dividend = operlower.fastFind(lval)->as<BindOnVirOP>();

        // ====================
        // step2: sdiv + mls
        // ====================
        auto quotient = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);

        auto sdiv = make<binaryInst>(OpCode::SDIV, SourceOperandType::rr, quotient, dividend, divisor);

        auto mls = make<ternaryInst>(OpCode::MLS, SourceOperandType::rrr, target, quotient, divisor, dividend);
        insts.emplace_back(sdiv);
        insts.emplace_back(mls);
    } else {
        Err::unreachable("binary lowering: Unexpected IR::OP.");
    }

    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::binaryLower_v(const std::shared_ptr<IR::BinaryInst> &binary,
                                                                    const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto target = operlower.mkOP(*binary, RegisterBank::spr);

    if (target->getName() == "%104" || target->getName() == "%105") {
        int useless;
    }

    auto op = binary->getOpcode();

    std::shared_ptr<IR::Value> rval = binary->getRHS();
    std::shared_ptr<IR::Value> lval = binary->getLHS();

    std::shared_ptr<BindOnVirOP> oper1;
    std::shared_ptr<BindOnVirOP> oper2;

    auto lconst = lval->as<IR::ConstantFloat>();
    auto rconst = rval->as<IR::ConstantFloat>();

    if (lconst) {
        float const_float = lconst->getVal();

        auto relay = operlower.LoadedFind(const_float, blk);
        ///@note vmov ...
        auto relay_v = operlower.mkOP(IR::makeBType(IR::IRBTYPE::FLOAT), RegisterBank::spr);

        auto vmov =
            make<Vmov>(SourceOperandType::r, relay_v, relay, std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32));

        insts.emplace_back(vmov);

        oper1 = relay_v;
    } else {
        oper1 = operlower.fastFind(lval)->as<BindOnVirOP>();
    }

    if (rconst) {
        float const_float = rconst->getVal();

        auto relay = operlower.LoadedFind(const_float, blk);

        auto relay_v = operlower.mkOP(IR::makeBType(IR::IRBTYPE::FLOAT), RegisterBank::spr);

        auto vmov =
            make<Vmov>(SourceOperandType::r, relay_v, relay, std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32));

        insts.emplace_back(vmov);

        oper2 = relay_v;
    } else {
        oper2 = operlower.fastFind(rval)->as<BindOnVirOP>();
    }

    /// vxxx %target, %oper1, %oper2
    Err::gassert(oper1->getBank() == RegisterBank::spr && oper2->getBank() == RegisterBank::spr, "get wrong oper");

    auto datapair = std::make_pair(bitType::f32, bitType::DEFAULT32);
    switch (op) {
    case IR::OP::FADD: {
        auto vadd = make<Vbinary>(MIR::NeonOpCode::VADD, target, oper1, oper2, datapair);
        insts.emplace_back(vadd);
    } break;

    case IR::OP::FSUB: {
        auto vsub = make<Vbinary>(MIR::NeonOpCode::VSUB, target, oper1, oper2, datapair);
        insts.emplace_back(vsub);
    } break;

    case IR::OP::FMUL: {
        auto vmul = make<Vbinary>(MIR::NeonOpCode::VMUL, target, oper1, oper2, datapair);
        insts.emplace_back(vmul);
    } break;
    case IR::OP::FDIV: {
        auto vdiv = make<Vbinary>(MIR::NeonOpCode::VDIV, target, oper1, oper2, datapair);
        insts.emplace_back(vdiv);
    } break;
    case IR::OP::FNEG: {
        auto vneg = make<Vunary>(MIR::NeonOpCode::VNEG, target, oper1, datapair); // oper2 = nullptr
        insts.emplace_back(vneg);
    } break;
    case IR::OP::FREM: {
        // vdiv.f32	%tmp1, %oper1, %oper2
        // vmul.f32	%tmp2, %oper2, %tmp1
        // vsub.f32	%target, %oper1, %tmp2
        auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::FLOAT), RegisterBank::spr);
        auto relay2 = operlower.mkOP(IR::makeBType(IR::IRBTYPE::FLOAT), RegisterBank::spr);

        auto vdiv = make<Vbinary>(NeonOpCode::VDIV, relay, oper1, oper2, datapair);
        auto vmul = make<Vbinary>(NeonOpCode::VMUL, relay2, oper2, relay, datapair);
        auto vsub = make<Vbinary>(NeonOpCode::VSUB, target, oper1, relay2, datapair);
        insts.emplace_back(vdiv);
        insts.emplace_back(vmul);
        insts.emplace_back(vsub);
    } break;
    default:
        Err::unreachable("instLower: binarylower_v encountered unknown IR::OP");
    }

    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::fnegLower(const std::shared_ptr<IR::FNEGInst> &fneg,
                                                                const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto target = operlower.mkOP(*fneg, RegisterBank::spr);

    auto op = fneg->getOpcode();

    std::shared_ptr<IR::Value> lval = fneg->getVal();

    auto oper = operlower.fastFind(lval)->as<BindOnVirOP>();

    auto datapair = std::make_pair(bitType::f32, bitType::DEFAULT32);

    auto vneg = make<Vunary>(MIR::NeonOpCode::VNEG, target, oper, datapair); // oper2 = nullptr
    insts.emplace_back(vneg);

    return insts;
}