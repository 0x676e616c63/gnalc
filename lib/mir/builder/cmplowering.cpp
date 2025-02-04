#include "../../../include/mir/builder/lowering.hpp"
#include "../../../include/mir/instructions/binary.hpp"
#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mir/instructions/copy.hpp"
#include "../../../include/mir/instructions/memory.hpp"
#include "../../../include/mirtools/tool.hpp"
#include <algorithm>
#include <cassert>

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
}

void setMovCond(const std::shared_ptr<movInst> &mov_true,
                const std::shared_ptr<movInst> &mov_false, IR::ICMPOP cond) {
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

std::list<std::shared_ptr<Instruction>>
InstLowering::icmpLower(const std::shared_ptr<IR::ICMPInst> &icmp) {
    ///@note 原始的LLVM IR的 icmp/fcmp 之后就是对应跳转指令
    ///@note 然而在优化之后就不一定, 比较和跳转之间可能存在刷新符号位的指令
    ///@note 所以使用带条件的mov保证所有情况下都正常执行, 后续数据流窥孔中再考虑合并为常见情况
    std::list<std::shared_ptr<Instruction>> insts{};

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

        auto relaylval = operlower.mkOP(
            std::make_shared<IR::BType>(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto mov_lval = std::make_shared<movInst>(SourceOperandType::ri,
                                                  relaylval, constlval);
        auto relayrval = operlower.mkOP(
            std::make_shared<IR::BType>(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto mov_rval = std::make_shared<movInst>(SourceOperandType::ri,
                                                  relayrval, constrval);

        auto cmp = std::make_shared<compareInst>(
            OpCode::CMP, SourceOperandType::rr, relaylval, relayrval);

        insts.emplace_back(mov_lval);
        insts.emplace_back(mov_rval);
        insts.emplace_back(cmp);
    }

    // =================
    // 2. lval为常数, 考虑加movt/w或者变换比较逻辑
    // =================
    else if (lconst) {
        auto constlval = std::dynamic_pointer_cast<ConstantIDX>(
            operlower.fastFind(lconst->getVal()));
        auto virrval =
            std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));

        if (!constlval->getConst()->isEncoded()) {
            // 变换逻辑, 交换顺序
            cond = getReverse(cond);
            std::swap(lval, rval);

            auto virlval = std::dynamic_pointer_cast<BindOnVirOP>(
                operlower.fastFind(lval));
            auto constrval = operlower.fastFind(rval);

            auto cmp = std::make_shared<compareInst>(
                OpCode::CMP, SourceOperandType::ri, virlval, constrval);

            insts.emplace_back(cmp);
        } else {
            // 加 mov
            auto relaylval =
                operlower.mkOP(std::make_shared<IR::BType>(IR::IRBTYPE::I32),
                               RegisterBank::gpr);
            auto mov_lval = std::make_shared<movInst>(SourceOperandType::ri,
                                                      relaylval, constlval);
            auto cmp = std::make_shared<compareInst>(
                OpCode::CMP, SourceOperandType::rr, relaylval, virrval);

            insts.emplace_back(mov_lval);
            insts.emplace_back(cmp);
        }
    }

    // =================
    // 3. rval为常数, 考虑可能添加movt/w
    // =================
    else if (rconst) {
        auto constrval = std::dynamic_pointer_cast<ConstantIDX>(
            operlower.fastFind(rconst->getVal()));
        auto virlval =
            std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));

        if (constrval->getConst()->isEncoded()) {
            // 加 mov
            auto relayrval =
                operlower.mkOP(std::make_shared<IR::BType>(IR::IRBTYPE::I32),
                               RegisterBank::gpr);
            auto mov_rval = std::make_shared<movInst>(SourceOperandType::ri,
                                                      relayrval, constrval);
            auto cmp = std::make_shared<compareInst>(
                OpCode::CMP, SourceOperandType::rr, virlval, relayrval);

            insts.emplace_back(mov_rval);
            insts.emplace_back(cmp);
        }
    }

    // =================
    // 4. 都不是常数
    // =================
    else {
        auto virlval =
            std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(lval));
        auto virrval =
            std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(rval));

        auto cmp = std::make_shared<compareInst>(
            OpCode::CMP, SourceOperandType::rr, virlval, virrval);

        insts.emplace_back(cmp);
    }

    // =========================
    // step2: 条件mov
    // =========================
    auto bool_true = operlower.fastFind(1);
    auto bool_false = operlower.fastFind(0);

    auto mov_true =
        std::make_shared<movInst>(SourceOperandType::ri, boolVal, bool_true);
    auto mov_false =
        std::make_shared<movInst>(SourceOperandType::ri, boolVal, bool_false);

    setMovCond(mov_true, mov_false, cond);

    insts.emplace_back(mov_true);
    insts.emplace_back(mov_false);
    return insts;
}
