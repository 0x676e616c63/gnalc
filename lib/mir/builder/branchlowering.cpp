#include "../../../include/mir/SIMDinstruction/memory.hpp"
#include "../../../include/mir/builder/lowering.hpp"
#include "../../../include/mir/instructions/binary.hpp"
#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mir/instructions/copy.hpp"
#include "../../../include/mir/instructions/memory.hpp"
#include "../../../include/mirtools/tool.hpp"

using namespace MIR;

std::list<std::shared_ptr<Instruction>> InstLowering::brLower(const std::shared_ptr<IR::BRInst> &br,
                                                              const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    if (!br->isConditional()) {
        // b label
        auto Dest = br->getDest();
        auto b_true = std::make_shared<branchInst>(OpCode::B, Dest, Dest->getName());
        insts.emplace_back(b_true);
    } else if (auto constcond = std::dynamic_pointer_cast<IR::ConstantI1>(br->getCond())) {
        //   虽然奇怪但是确实有这种IR
        //   br i1 1, label %true, label %false
        //   br i1 0, label %true, label %false
        auto trueDest = br->getTrueDest();
        auto falseDest = br->getFalseDest();
        auto boolean = constcond->getVal();

        if (boolean) {
            auto b_true = std::make_shared<branchInst>(OpCode::B, trueDest, trueDest->getName());
            insts.emplace_back(b_true);
        } else {
            auto b_false = std::make_shared<branchInst>(OpCode::B, trueDest, falseDest->getName());
            insts.emplace_back(b_false);
        }
    } else {
        auto cond = br->getCond();
        auto trueDest = br->getTrueDest();
        auto falseDest = br->getFalseDest();

        // teq (BindOnVirOP)cond, #0x1
        // b<eq> label_true
        // b label_false
        auto boolVal = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(cond));
        auto trueVal = operlower.fastFind(1); // #0x1
        auto teq = std::make_shared<compareInst>(OpCode::TEQ, SourceOperandType::rr, boolVal, trueVal);
        auto b_true = std::make_shared<branchInst>(OpCode::B, trueDest, trueDest->getName());
        b_true->setCondCodeFlag(CondCodeFlag::eq);
        auto b_false = std::make_shared<branchInst>(OpCode::B, falseDest, falseDest->getName());
        // b_false.condflag : AL
        insts.emplace_back(teq);
        insts.emplace_back(b_true);
        insts.emplace_back(b_false);
    }

    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::retLower(const std::shared_ptr<IR::RETInst> &ret,
                                                               const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    auto retType = ret->getRetBType();

    if (retType != IR::IRBTYPE::FLOAT) {
        // mov $r0, %retVal
        auto retVal = operlower.fastFind(ret->getRetVal()); // 可能是常量

        SourceOperandType optype;
        if (std::dynamic_pointer_cast<ConstantIDX>(retVal))
            optype = SourceOperandType::i;
        else
            optype = SourceOperandType::r;

        auto mov = std::make_shared<movInst>(optype, operlower.getPreColored(CoreRegister::r0), retVal);
        insts.emplace_back(mov);
    } else {
        auto pair = std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32);

        if (auto ret_const = std::dynamic_pointer_cast<IR::ConstantFloat>(ret->getRetVal())) {
            auto retVal = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(ret_const->getVal()));

            if (retVal->getConst()->isEncoded()) {
                // mov %tmp #imme
                // vmov $s0, %tmp
                auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
                auto mov = std::make_shared<movInst>(SourceOperandType::i, relay, retVal);
                auto vmov =
                    std::make_shared<Vmov>(SourceOperandType::r, operlower.getPreColored(FPURegister::s0), relay, pair);
                insts.emplace_back(mov);
                insts.emplace_back(vmov);
            } else {
                // vmov $s0, %retVal
                auto vmov = std::make_shared<Vmov>(SourceOperandType::i, operlower.getPreColored(FPURegister::s0),
                                                   retVal, pair);
                insts.emplace_back(vmov);
            }
        } else {
            // vmov $s0, %retVal

            auto retVal = operlower.fastFind(ret->getRetVal());

            SourceOperandType optype;
            if (std::dynamic_pointer_cast<ConstantIDX>(retVal))
                optype = SourceOperandType::i;
            else
                optype = SourceOperandType::r;

            auto vmov = std::make_shared<Vmov>(optype, operlower.getPreColored(FPURegister::s0), retVal, pair);

            insts.emplace_back(vmov);
        }
    }

    auto bkd_ret = std::make_shared<RET>();
    insts.emplace_back(bkd_ret);

    return insts;
}

std::list<std::shared_ptr<Instruction>> InstLowering::callLower(const std::shared_ptr<IR::CALLInst> &call,
                                                                const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    auto func = call->getFunc();
    auto functype = IR::toFunctionType(func->getType());

    // auto &types = functype->getParams();
    auto params = call->getArgs();

    unsigned int cnt = 0;
    unsigned int fcnt = 0;

    // =====================
    // step1: 加载参数
    // =====================
    for (auto &arg : params) {
        auto type = arg->getType();
        if (auto btype = IR::toBType(type)) {
            /// @brief int / float
            if (btype->getInner() == IR::IRBTYPE::I32 || btype->getInner() == IR::IRBTYPE::I8 ||
                btype->getInner() == IR::IRBTYPE::I1) {
                // 传参的时候I几都一样, 尤其是用寄存器的时候
                if (cnt <= 4) {
                    // mov $rx, %arg
                    auto reg = operlower.getPreColored(static_cast<CoreRegister>(cnt));

                    if (auto arg_const = std::dynamic_pointer_cast<IR::ConstantInt>(arg)) {
                        auto const_arg = operlower.fastFind(arg_const->getVal());
                        auto mov = std::make_shared<movInst>(SourceOperandType::ri, reg, const_arg);
                        insts.emplace_back(mov);

                    } else {
                        auto arg_in_reg = operlower.fastFind(arg);
                        auto mov = std::make_shared<movInst>(SourceOperandType::rr, reg, arg_in_reg);
                        insts.emplace_back(mov);
                    }

                } else {
                    // (mov %arg, #arg)
                    // str %arg, [sp, #offset]
                    std::shared_ptr<BindOnVirOP> arg_in_reg;
                    if (auto arg_const = std::dynamic_pointer_cast<IR::ConstantInt>(arg)) {
                        arg_in_reg = operlower.mkOP(*arg, RegisterBank::gpr);
                        auto const_arg = operlower.fastFind(arg_const->getVal());

                        auto mov = std::make_shared<movInst>(SourceOperandType::ri, arg_in_reg, const_arg);
                        insts.emplace_back(mov);
                    } else {
                        arg_in_reg = std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(arg));
                    }

                    auto str = std::make_shared<strInst>(SourceOperandType::ra, 4, arg_in_reg, operlower.mkStackOP());
                    insts.emplace_back(str);
                }
                ++cnt;
            } else if (btype->getInner() == IR::IRBTYPE::FLOAT) {

                auto reg = operlower.getPreColored(static_cast<FPURegister>(fcnt));
                if (auto arg_const = std::dynamic_pointer_cast<IR::ConstantFloat>(arg)) {

                    // (mov %tmp, #Encoded)
                    // vmov $sx, %tmp
                    auto const_arg = std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind(arg_const->getVal()));
                    if (const_arg->getConst()->isEncoded()) {
                        auto arg_in_reg = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);

                        auto mov = std::make_shared<movInst>(SourceOperandType::ri, arg_in_reg, const_arg);
                        auto pair = std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32);
                        auto vmov = std::make_shared<Vmov>(SourceOperandType::r, reg, arg_in_reg, pair);
                        insts.emplace_back(mov);
                        insts.emplace_back(vmov);
                    } else {
                        auto pair = std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32);
                        auto vmov = std::make_shared<Vmov>(SourceOperandType::ri, reg, const_arg, pair);
                        insts.emplace_back(vmov);
                    }

                } else {
                    // vmov $sx, %tmp
                    auto pair = std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32);
                    auto arg_in_reg = operlower.fastFind(arg);
                    auto vmov = std::make_shared<Vmov>(SourceOperandType::r, reg, arg_in_reg, pair);
                }

                ++fcnt;
            } else
                Err::not_implemented("Unknown basic type '" + btype->toString() + "'");
        } else {
            /// @brief 指针类
            std::shared_ptr<BindOnVirOP> arg_in_reg;
            std::shared_ptr<BaseADROP> ptr = std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(arg));

            if (ptr->getConstOffset() == 0)
                arg_in_reg = ptr;
            else {
                auto const_offset =
                    std::dynamic_pointer_cast<ConstantIDX>(operlower.fastFind((int)ptr->getConstOffset()));
                auto base = ptr->getBase();
                auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
                arg_in_reg = relay;
                if (const_offset->getConst()->isEncoded()) {
                    // mov %tmp2, #constOffset
                    // add %tmp, %base, %tmp2
                    auto relay2 = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
                    auto mov = std::make_shared<movInst>(SourceOperandType::ri, relay2, const_offset);

                    auto add = std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::rr, relay, base, relay2,
                                                               nullptr);
                    insts.emplace_back(mov);
                    insts.emplace_back(add);
                } else {
                    // add %tmp, %base, #constOffset

                    auto add = std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, relay, base,
                                                               const_offset, nullptr);
                    insts.emplace_back(add);
                }
            }

            if (cnt <= 4) {
                // mov $rx, %loc
                auto reg = operlower.getPreColored(static_cast<CoreRegister>(cnt));

                auto mov = std::make_shared<movInst>(SourceOperandType::r, reg, arg_in_reg);
                insts.emplace_back(mov);

            } else {
                // str %loc, [sp, #offset]
                auto str = std::make_shared<strInst>(SourceOperandType::ra, 4, arg_in_reg, operlower.mkStackOP());
                insts.emplace_back(str);
            }
            ++cnt;
        }
    }

    // =====================
    // step2: call
    // =====================
    std::shared_ptr<BindOnVirOP> target;
    auto retType = IR::toBType(functype->getRet());
    unsigned int RetValType = -1;
    if (retType->getInner() == IR::IRBTYPE::VOID)
        RetValType = 0;
    else if (retType->getInner() == IR::IRBTYPE::FLOAT)
        RetValType = 2;
    else // float
        RetValType = 1;
    auto bl_call = std::make_shared<branchInst>(OpCode::BL, func, func->getName(), RetValType);

    insts.emplace_back(bl_call);

    // =====================
    // step3: 接收返回值
    // =====================
    if (retType->getInner() == IR::IRBTYPE::I32) {
        target = operlower.mkOP(*call, RegisterBank::gpr);
        auto reg = operlower.getPreColored(CoreRegister::r0);
        auto mov = std::make_shared<movInst>(SourceOperandType::r, target, reg);
        insts.emplace_back(mov);
    } else if (retType->getInner() == IR::IRBTYPE::FLOAT) {
        target = operlower.mkOP(*call, RegisterBank::spr);
        auto reg = operlower.getPreColored(FPURegister::s0);
        auto pair = std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32);
        auto vmov = std::make_shared<Vmov>(SourceOperandType::r, target, reg, pair);
        insts.emplace_back(vmov);
    } else if (retType->getInner() == IR::IRBTYPE::VOID) {
        // nothing
    } else {
        Err::unreachable("unknown ret value type detected!");
    }

    return insts;
}