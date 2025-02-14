#include "../../../include/mir/SIMDinstruction/memory.hpp"
#include "../../../include/mir/builder/lowering.hpp"
#include "../../../include/mir/instructions/binary.hpp"
#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mir/instructions/copy.hpp"
#include "../../../include/mir/instructions/memory.hpp"
#include "../../../include/mirtools/tool.hpp"

using namespace MIR;

std::list<std::shared_ptr<Instruction>>
InstLowering::brLower(const std::shared_ptr<IR::BRInst> &br) {
    std::list<std::shared_ptr<Instruction>> insts;

    if (!br->isConditional()) {
        // b label
        auto Dest = br->getDest();
        auto b_true =
            std::make_shared<branchInst>(OpCode::B, Dest, Dest->getName());
        insts.emplace_back(b_true);
    } else {
        auto cond = br->getCond();
        auto trueDest = br->getTrueDest();
        auto falseDest = br->getFalseDest();

        // teq (BindOnVirOP)cond, #0x1
        // b<eq> label_true
        // b label_false
        auto boolVal =
            std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(cond));
        auto trueVal = operlower.fastFind(1); // #0x1
        auto teq = std::make_shared<compareInst>(
            OpCode::TEQ, SourceOperandType::rr, boolVal, trueVal);
        auto b_true = std::make_shared<branchInst>(OpCode::B, trueDest,
                                                   trueDest->getName());
        b_true->setCondCodeFlag(CondCodeFlag::eq);
        auto b_false = std::make_shared<branchInst>(OpCode::B, falseDest,
                                                    falseDest->getName());
    }

    return insts;
}

std::list<std::shared_ptr<Instruction>>
InstLowering::retLower(const std::shared_ptr<IR::RETInst> &ret) {
    /// @brief 指令选择阶段, retLower只有加载返回值, 因为不确定后续lr是如何恢复的
    std::list<std::shared_ptr<Instruction>> insts;

    auto retType = ret->getRetBType();

    if (retType != IR::IRBTYPE::FLOAT) {
        // mov $r0, %retVal
        auto retVal = operlower.fastFind(ret->getRetVal()); // 可能是常量
        auto mov = std::make_shared<movInst>(
            SourceOperandType::i, operlower.getPreColored(CoreRegister::r0),
            retVal);
        insts.emplace_back(mov);
    } else {
        auto pair = std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32);

        if (auto ret_const = std::dynamic_pointer_cast<IR::ConstantFloat>(
                ret->getRetVal())) {
            auto retVal = std::dynamic_pointer_cast<ConstantIDX>(
                operlower.fastFind(ret_const->getVal()));

            if (retVal->getConst()->isEncoded()) {
                // mov %tmp #imme
                // vmov $s0, %tmp
                auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32),
                                            RegisterBank::gpr);
                auto mov = std::make_shared<movInst>(SourceOperandType::cp,
                                                     relay, retVal);
                auto vmov = std::make_shared<Vmov>(
                    SourceOperandType::r,
                    operlower.getPreColored(FPURegister::s0), relay, pair);
                insts.emplace_back(mov);
                insts.emplace_back(vmov);
            } else {
                // vmov $s0, %retVal
                auto vmov = std::make_shared<Vmov>(
                    SourceOperandType::cp,
                    operlower.getPreColored(FPURegister::s0), retVal, pair);
                insts.emplace_back(vmov);
            }
        } else {
            // vmov $s0, %retVal

            auto retVal = operlower.fastFind(ret->getRetVal());
            auto vmov = std::make_shared<Vmov>(
                SourceOperandType::r, operlower.getPreColored(FPURegister::s0),
                retVal, pair);

            insts.emplace_back(vmov);
        }
    }

    return insts;
}

std::list<std::shared_ptr<Instruction>>
InstLowering::callLower(const std::shared_ptr<IR::CALLInst> &call) {
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
            if (btype->getInner() == IR::IRBTYPE::I32) {
                if (cnt <= 4) {
                    // mov $rx, %arg
                    auto reg =
                        operlower.getPreColored(static_cast<CoreRegister>(cnt));

                    if (auto arg_const =
                            std::dynamic_pointer_cast<IR::ConstantInt>(arg)) {
                        auto const_arg =
                            operlower.fastFind(arg_const->getVal());
                        auto mov = std::make_shared<movInst>(
                            SourceOperandType::cp, reg, const_arg);
                        insts.emplace_back(mov);

                    } else {
                        auto arg_in_reg = operlower.fastFind(arg);
                        auto mov = std::make_shared<movInst>(
                            SourceOperandType::r, reg, arg_in_reg);
                        insts.emplace_back(mov);
                    }

                } else {
                    // (mov %arg, #arg)
                    // str %arg, [sp, #offset]
                    std::shared_ptr<BindOnVirOP> arg_in_reg;
                    if (auto arg_const =
                            std::dynamic_pointer_cast<IR::ConstantInt>(arg)) {
                        arg_in_reg = operlower.mkOP(*arg, RegisterBank::gpr);
                        auto const_arg =
                            operlower.fastFind(arg_const->getVal());

                        auto mov = std::make_shared<movInst>(
                            SourceOperandType::cp, arg_in_reg, const_arg);
                        insts.emplace_back(mov);
                    } else {
                        arg_in_reg = std::dynamic_pointer_cast<BindOnVirOP>(
                            operlower.fastFind(arg));
                    }

                    auto str = std::make_shared<strInst>(SourceOperandType::ra,
                                                         4, arg_in_reg,
                                                         operlower.mkStackOP());
                    insts.emplace_back(str);
                }
                ++cnt;
            } else if (btype->getInner() == IR::IRBTYPE::FLOAT) {

                auto reg =
                    operlower.getPreColored(static_cast<FPURegister>(fcnt));
                if (auto arg_const =
                        std::dynamic_pointer_cast<IR::ConstantFloat>(arg)) {

                    // (mov %tmp, #Encoded)
                    // vmov $sx, %tmp
                    auto const_arg = std::dynamic_pointer_cast<ConstantIDX>(
                        operlower.fastFind(arg_const->getVal()));
                    if (const_arg->getConst()->isEncoded()) {
                        auto arg_in_reg = operlower.mkOP(
                            IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);

                        auto mov = std::make_shared<movInst>(
                            SourceOperandType::cp, arg_in_reg, const_arg);
                        auto pair = std::make_pair(bitType::DEFAULT32,
                                                   bitType::DEFAULT32);
                        auto vmov = std::make_shared<Vmov>(
                            SourceOperandType::r, reg, arg_in_reg, pair);
                        insts.emplace_back(mov);
                        insts.emplace_back(vmov);
                    } else {
                        auto pair = std::make_pair(bitType::DEFAULT32,
                                                   bitType::DEFAULT32);
                        auto vmov = std::make_shared<Vmov>(
                            SourceOperandType::cp, reg, const_arg, pair);
                        insts.emplace_back(vmov);
                    }

                } else {
                    // vmov $sx, %tmp
                    auto pair =
                        std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32);
                    auto arg_in_reg = operlower.fastFind(arg);
                    auto vmov = std::make_shared<Vmov>(SourceOperandType::r,
                                                       reg, arg_in_reg, pair);
                }

                ++fcnt;
            }
            else Err::not_implemented("Unknown basic type '" + btype->toString() + "'");
        } else {
            /// @brief 指针类
            std::shared_ptr<BindOnVirOP> arg_in_reg;
            std::shared_ptr<BaseADROP> ptr =
                std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(arg));

            if (ptr->getConstOffset() == 0)
                arg_in_reg = ptr;
            else {
                auto const_offset = std::dynamic_pointer_cast<ConstantIDX>(
                    operlower.fastFind((int)ptr->getConstOffset()));
                auto base = ptr->getBase();
                auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32),
                                            RegisterBank::gpr);
                arg_in_reg = relay;
                if (const_offset->getConst()->isEncoded()) {
                    // mov %tmp2, #constOffset
                    // add %tmp, %base, %tmp2
                    auto relay2 = operlower.mkOP(
                        IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
                    auto mov = std::make_shared<movInst>(SourceOperandType::cp,
                                                         relay2, const_offset);

                    auto add = std::make_shared<binaryImmInst>(
                        OpCode::ADD, SourceOperandType::rr, relay, base, relay2,
                        nullptr);
                    insts.emplace_back(mov);
                    insts.emplace_back(add);
                } else {
                    // add %tmp, %base, #constOffset

                    auto add = std::make_shared<binaryImmInst>(
                        OpCode::ADD, SourceOperandType::ri, relay, base,
                        const_offset, nullptr);
                    insts.emplace_back(add);
                }
            }

            if (cnt <= 4) {
                // mov $rx, %loc
                auto reg =
                    operlower.getPreColored(static_cast<CoreRegister>(cnt));

                auto mov = std::make_shared<movInst>(SourceOperandType::r, reg,
                                                     arg_in_reg);
                insts.emplace_back(mov);

            } else {
                // str %loc, [sp, #offset]
                auto str = std::make_shared<strInst>(SourceOperandType::ra, 4,
                                                     arg_in_reg,
                                                     operlower.mkStackOP());
                insts.emplace_back(str);
            }
            ++cnt;
        }
    }

    // =====================
    // step2: call
    // =====================
    auto bl_call =
        std::make_shared<branchInst>(OpCode::BL, func, func->getName());

    insts.emplace_back(bl_call);

    // =====================
    // step3: 接收返回值
    // =====================
    std::shared_ptr<BindOnVirOP> target;
    auto retType = IR::toBType(functype->getRet());
    if (retType->getInner() == IR::IRBTYPE::I32) {
        target = operlower.mkOP(*call, RegisterBank::gpr);
        auto reg = operlower.getPreColored(CoreRegister::r0);
        auto mov = std::make_shared<movInst>(SourceOperandType::r, target, reg);
        insts.emplace_back(mov);
    } else if (retType->getInner() == IR::IRBTYPE::FLOAT) {
        target = operlower.mkOP(*call, RegisterBank::spr);
        auto reg = operlower.getPreColored(FPURegister::s0);
        auto pair = std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32);
        auto vmov =
            std::make_shared<Vmov>(SourceOperandType::r, target, reg, pair);
        insts.emplace_back(vmov);
    } else if (retType->getInner() == IR::IRBTYPE::VOID) {
        // nothing
    } else {
        Err::unreachable("unknown ret value type detected!");
    }

    return insts;
}