#include "mir-old/SIMDinstruction/arithmetics.hpp"
#include "mir-old/SIMDinstruction/memory.hpp"
#include "mir-old/builder/lowering.hpp"
#include "mir-old/instructions/binary.hpp"
#include "mir-old/instructions/branch.hpp"
#include "mir-old/instructions/memory.hpp"
#include "mirtools-old/tool.hpp"
#include <algorithm>

using namespace MIR;

IR::ICMPOP getReverse(IR::ICMPOP _cond) {
    switch (_cond) {
    case IR::ICMPOP::eq:
        return IR::ICMPOP::eq;
    case IR::ICMPOP::ne:
        return IR::ICMPOP::ne;
    case IR::ICMPOP::sge:
        return IR::ICMPOP::sle;
    case IR::ICMPOP::sgt:
        return IR::ICMPOP::slt;
    case IR::ICMPOP::sle:
        return IR::ICMPOP::sge;
    case IR::ICMPOP::slt:
        return IR::ICMPOP::sgt;
    }
    Err::unreachable("getReverse(): Unknown ICMPOP");
    return IR::ICMPOP::eq;
}

void setMovCond(const std::shared_ptr<movInst> &mov_true, const std::shared_ptr<movInst> &mov_false, IR::ICMPOP cond) {
    switch (cond) {
    case IR::ICMPOP::eq:
        mov_true->setCondCodeFlag(CondCodeFlag::eq);
        mov_false->setCondCodeFlag(CondCodeFlag::ne);
        break;
    case IR::ICMPOP::ne:
        mov_true->setCondCodeFlag(CondCodeFlag::ne);
        mov_false->setCondCodeFlag(CondCodeFlag::eq);
        break;
    case IR::ICMPOP::sge:
        mov_true->setCondCodeFlag(CondCodeFlag::ge);
        mov_false->setCondCodeFlag(CondCodeFlag::lt);
        break;
    case IR::ICMPOP::sgt:
        mov_true->setCondCodeFlag(CondCodeFlag::gt);
        mov_false->setCondCodeFlag(CondCodeFlag::le);
        break;
    case IR::ICMPOP::sle:
        mov_true->setCondCodeFlag(CondCodeFlag::le);
        mov_false->setCondCodeFlag(CondCodeFlag::gt);
        break;
    case IR::ICMPOP::slt:
        mov_true->setCondCodeFlag(CondCodeFlag::lt);
        mov_false->setCondCodeFlag(CondCodeFlag::ge);
        break;
    }
}

void setMovCond(const std::shared_ptr<movInst> &mov_true, const std::shared_ptr<movInst> &mov_false, IR::FCMPOP cond) {
    switch (cond) {
    case IR::FCMPOP::oeq:
        mov_true->setCondCodeFlag(CondCodeFlag::eq);
        mov_false->setCondCodeFlag(CondCodeFlag::ne);
        break;
    case IR::FCMPOP::one:
        mov_true->setCondCodeFlag(CondCodeFlag::ne);
        mov_false->setCondCodeFlag(CondCodeFlag::eq);
        break;
    case IR::FCMPOP::oge:
        mov_true->setCondCodeFlag(CondCodeFlag::ge);
        mov_false->setCondCodeFlag(CondCodeFlag::lt);
        break;
    case IR::FCMPOP::ogt:
        mov_true->setCondCodeFlag(CondCodeFlag::gt);
        mov_false->setCondCodeFlag(CondCodeFlag::le);
        break;
    case IR::FCMPOP::ole:
        mov_true->setCondCodeFlag(CondCodeFlag::le);
        mov_false->setCondCodeFlag(CondCodeFlag::gt);
        break;
    case IR::FCMPOP::olt:
        mov_true->setCondCodeFlag(CondCodeFlag::lt);
        mov_false->setCondCodeFlag(CondCodeFlag::ge);
        break;
    case IR::FCMPOP::ord:
        Err::todo("fcmp with FCMPOP ord");
    }
}

std::list<std::shared_ptr<Instruction>> InstLowering::icmpLower(const std::shared_ptr<IR::ICMPInst> &icmp,
                                                                const std::shared_ptr<BasicBlock> &blk) {
    ///@note 原始的LLVM IR的 icmp/fcmp 之后就是对应跳转指令
    ///@note 然而在优化之后就不一定, 比较和跳转之间可能存在刷新符号位的指令
    ///@note 所以使用带条件的mov保证所有情况下都正常执行, 后续数据流窥孔中再考虑合并为常见情况
    std::list<std::shared_ptr<Instruction>> insts;

    auto boolVal = operlower.mkOP(*icmp, RegisterBank::gpr);
    std::shared_ptr<IR::Value> rval = icmp->getRHS();
    std::shared_ptr<IR::Value> lval = icmp->getLHS();
    auto cond = icmp->getCond();

    auto rconst = std::dynamic_pointer_cast<IR::ConstantInt>(rval);
    auto lconst = std::dynamic_pointer_cast<IR::ConstantInt>(lval);

    // =========================
    //  step1: cmp指令
    // =========================

    // =================
    // 1. 都是常数, 虽然大概率不会有这种情况, 所以简单处理
    // =================
    if (rconst && lconst) {
        auto constlval = operlower.fastFind(lconst->getVal());
        auto constrval = operlower.fastFind(rconst->getVal());

        auto relaylval = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto mov_lval = std::make_shared<movInst>(SourceOperandType::ri, relaylval, constlval);
        auto relayrval = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto mov_rval = std::make_shared<movInst>(SourceOperandType::ri, relayrval, constrval);

        auto cmp = std::make_shared<compareInst>(OpCode::CMP, SourceOperandType::rr, relaylval, relayrval);

        insts.emplace_back(mov_lval);
        insts.emplace_back(mov_rval);
        insts.emplace_back(cmp);
    }

    // =================
    // 2. lval为常数, 考虑加movt/w或者变换比较逻辑
    // =================
    else if (lconst) {
        auto constlval = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(lconst->getVal()));
        auto virrval = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));

        if (!constlval->getConst()->isEncoded()) {
            // 变换逻辑, 交换顺序
            cond = getReverse(cond);
            std::swap(lval, rval);

            auto virlval = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));
            auto constrval = operlower.fastFind(rval);

            auto cmp = std::make_shared<compareInst>(OpCode::CMP, SourceOperandType::ri, virlval, constrval);

            insts.emplace_back(cmp);
        } else {
            // 加 mov
            auto relaylval = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
            auto mov_lval = std::make_shared<movInst>(SourceOperandType::ri, relaylval, constlval);
            auto cmp = std::make_shared<compareInst>(OpCode::CMP, SourceOperandType::rr, relaylval, virrval);

            insts.emplace_back(mov_lval);
            insts.emplace_back(cmp);
        }
    }

    // =================
    // 3. rval为常数, 考虑可能添加movt/w
    // =================
    else if (rconst) {
        auto constrval = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(rconst->getVal()));
        auto virlval = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));

        if (constrval->getConst()->isEncoded()) {
            // 加 mov
            auto relayrval = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
            auto mov_rval = std::make_shared<movInst>(SourceOperandType::ri, relayrval, constrval);
            auto cmp = std::make_shared<compareInst>(OpCode::CMP, SourceOperandType::rr, virlval, relayrval);

            insts.emplace_back(mov_rval);
            insts.emplace_back(cmp);
        } else {
            auto cmp = std::make_shared<compareInst>(OpCode::CMP, SourceOperandType::ri, virlval, constrval);
            insts.emplace_back(cmp);
        }
    }

    // =================
    // 4. 都不是常数
    // =================
    else {
        auto virlval = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));
        auto virrval = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));

        auto cmp = std::make_shared<compareInst>(OpCode::CMP, SourceOperandType::rr, virlval, virrval);

        insts.emplace_back(cmp);
    }

    // =========================
    // step2: 条件mov
    // =========================
    auto bool_true = operlower.fastFind(1);
    auto bool_false = operlower.fastFind(0);

    auto mov_true = std::make_shared<movInst>(SourceOperandType::ri, boolVal, bool_true);
    auto mov_false = std::make_shared<movInst>(SourceOperandType::ri, boolVal, bool_false);

    setMovCond(mov_true, mov_false, cond);

    insts.emplace_back(mov_true);
    insts.emplace_back(mov_false);
    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::fcmpLower(const std::shared_ptr<IR::FCMPInst> &fcmp,
                                                                const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    /// @note 比较两个float
    /// @note vcmp + vmrs, vmrs相当于一个声明

    auto boolVal = operlower.mkOP(*fcmp, RegisterBank::gpr);
    std::shared_ptr<IR::Value> rval = fcmp->getRHS();
    std::shared_ptr<IR::Value> lval = fcmp->getLHS();
    auto cond = fcmp->getCond();

    auto rconst = std::dynamic_pointer_cast<IR::ConstantFloat>(rval);
    auto lconst = std::dynamic_pointer_cast<IR::ConstantFloat>(lval);

    // ===================
    // step1: vcmp
    // ===================
    if (rconst && lconst) {
        Err::todo("fcmp 2 const float.");
    } else if (rconst || lconst) {
        // mov %tmp::spr, #imme
        // vmov %tmp2, %tmp
        // vcmp.f32 %virVal, %tmp2
        float imme;
        std::shared_ptr<ConstantIDX> constVal;
        std::shared_ptr<BindOnVirOP> virVal;

        if (rconst) {
            imme = rconst->getVal();
            virVal = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));
            constVal = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(imme));
        } else {
            imme = lconst->getVal();
            virVal = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));
            constVal = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(imme));
        }

        if (constVal->getConst()->isEncoded()) {
            // mov %tmp::gpr, #imme
            // vmov %tmp2::spr, %tmp
            // vcmp.f32 %virVal, %tmp2
            // vmrs ...

            // auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
            auto relay = operlower.LoadedFind(imme, blk);
            auto relay2 = operlower.mkOP(IR::makeBType(IR::IRBTYPE::FLOAT), RegisterBank::spr);

            // auto mov = std::make_shared<movInst>(SourceOperandType::ri, relay, constVal);

            auto pair = std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32);
            auto vmov = std::make_shared<Vmov>(SourceOperandType::r, relay2, relay, pair); // twice mov
            pair = std::make_pair(bitType::f32, bitType::DEFAULT32);
            auto vcmp = std::make_shared<Vcmp>(NeonOpCode::VCMP, virVal, relay2, pair);
            auto vmrs = std::make_shared<Vmrs>();

            // insts.emplace_back(mov);
            insts.emplace_back(vmov);
            insts.emplace_back(vcmp);
            insts.emplace_back(vmrs);
        } else {
            // vmov %tmp, #imme
            // vcmp.f32 %virVal, %tmp
            // vmrs
            auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::FLOAT), RegisterBank::spr);

            auto pair = std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32);
            auto vmov = std::make_shared<Vmov>(SourceOperandType::ri, relay, constVal, pair);
            pair = std::make_pair(bitType::f32, bitType::DEFAULT32);
            auto vcmp = std::make_shared<Vcmp>(NeonOpCode::VCMP, virVal, relay, pair);
            auto vmrs = std::make_shared<Vmrs>();

            insts.emplace_back(vmov);
            insts.emplace_back(vcmp);
            insts.emplace_back(vmrs);
        }
    } else {
        auto fop1 = operlower.fastFind(lval)->as<BindOnVirOP>();
        auto fop2 = operlower.fastFind(rval)->as<BindOnVirOP>();
        auto pair = std::make_pair(bitType::f32, bitType::DEFAULT32);
        auto vcmp = std::make_shared<Vcmp>(NeonOpCode::VCMP, fop1, fop2, pair);
        auto vmrs = std::make_shared<Vmrs>();

        insts.emplace_back(vcmp);
        insts.emplace_back(vmrs); // 拷贝fpu状态字
    }
    // ===================
    // step2: 条件mov
    // ===================

    auto bool_true = operlower.fastFind(1);
    auto bool_false = operlower.fastFind(0);

    auto mov_true = std::make_shared<movInst>(SourceOperandType::ri, boolVal, bool_true);
    auto mov_false = std::make_shared<movInst>(SourceOperandType::ri, boolVal, bool_false);

    setMovCond(mov_true, mov_false, cond);

    insts.emplace_back(mov_true);
    insts.emplace_back(mov_false);
    return insts;
}