// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#include "../../../../include/legacy_mir/passes/transforms/preRAlegalize.hpp"
#include "../../../../include/legacy_mir/instructions/binary.hpp"
#include <algorithm>

using namespace LegacyMIR;

PM::PreservedAnalyses PreRALegalize::run(Function &function, FAM &manager) {
    func = &function;
    varpool = &(func->editInfo().varpool);
    constClearSet.clear();

    for (auto blk : func->getBlocks()) {
        runOnBlk(blk);
    }

    for (auto &baseptr : constClearSet)
        baseptr->setConstOffset(0); // 遍历完成之后统一清零, 防止语义问题

    return PM::PreservedAnalyses::all();
}

void PreRALegalize::runOnBlk(const BlkP &blk) {
    for (const auto &inst : blk->getInsts()) {
        ///@note 逐条遍历
        runOnInst(blk, inst);
    }
}

void PreRALegalize::runOnInst(const BlkP &blk, const InstP &inst) {
    if (auto ninst = std::dynamic_pointer_cast<NeonInstruction>(inst)) {
        auto nopcode = std::get<NeonOpCode>(ninst->getOpCode());

        if (nopcode == NeonOpCode::VLDR) {
            auto baseReg = std::dynamic_pointer_cast<BaseADROP>(ninst->getSourceOP(1));
            if (baseReg->getConstOffset() > 1020 || baseReg->getConstOffset() < 0) {
                addInstBefore(blk, std::dynamic_pointer_cast<Vldr>(ninst));
            }
        }

        if (nopcode == NeonOpCode::VSTR) {
            auto baseReg = std::dynamic_pointer_cast<BaseADROP>(ninst->getSourceOP(2));
            if (baseReg->getConstOffset() > 1020 || baseReg->getConstOffset() < 0) {
                addInstBefore(blk, std::dynamic_pointer_cast<Vstr>(ninst));
            }
        }

        if (nopcode == NeonOpCode::VLDX || nopcode == NeonOpCode::VSTX) {
            Err::todo("vldx vstx todo...");
        }

    } else {
        auto opcode = std::get<OpCode>(inst->getOpCode());

        if (opcode == OpCode::STR) {
            auto baseReg = std::dynamic_pointer_cast<BaseADROP>(inst->getSourceOP(2));
            if (baseReg->getConstOffset() > 4095 || baseReg->getConstOffset() < -4095) { // 一般不会是负的
                addInstBefore(blk, std::dynamic_pointer_cast<strInst>(inst));
            }
        }

        if (opcode == OpCode::LDR) {
            auto baseReg = std::dynamic_pointer_cast<BaseADROP>(inst->getSourceOP(1));
            if (baseReg->getConstOffset() > 4095 || baseReg->getConstOffset() < -4095) {
                addInstBefore(blk, std::dynamic_pointer_cast<ldrInst>(inst));
            }
        }
    }
}

void PreRALegalize::addInstBefore(const BlkP &blk, const std::shared_ptr<ldrInst> &ldr) {
    auto &insts = blk->getInsts();

    auto it = std::find_if(insts.begin(), insts.end(), [&ldr](const auto &ptr) { return ptr.get() == ldr.get(); });

    // ~ baseReg.constOffset = 0 ~
    // ldr ... [%baseReg, %index_Reg]

    auto baseReg = std::dynamic_pointer_cast<BaseADROP>(ldr->getSourceOP(1));
    int offset = baseReg->getConstOffset();
    constClearSet.insert(baseReg);

    auto [ptr, const_op] = varpool->getLoaded(offset, blk);

    if (auto stk = baseReg->as<StackADROP>()) {
        auto idxrelay = varpool->mkOP_backup(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto unknown = make<UnknownConstant>(stk->getObj());
        auto add = make<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, idxrelay, ptr, unknown, nullptr);
        insts.insert(it, add);
        ptr = idxrelay;
    }

    ldr->setIndexReg(ptr);
}
void PreRALegalize::addInstBefore(const BlkP &blk, const std::shared_ptr<strInst> &str) {
    auto &insts = blk->getInsts();

    auto it = std::find_if(insts.begin(), insts.end(), [&str](const auto &ptr) { return ptr.get() == str.get(); });

    auto baseReg = std::dynamic_pointer_cast<BaseADROP>(str->getSourceOP(2));
    int offset = baseReg->getConstOffset();
    constClearSet.insert(baseReg);

    auto [ptr, const_op] = varpool->getLoaded(offset, blk);

    if (auto stk = baseReg->as<StackADROP>()) {
        auto idxrelay = varpool->mkOP_backup(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto unknown = make<UnknownConstant>(stk->getObj());
        auto add = make<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, idxrelay, ptr, unknown, nullptr);
        insts.insert(it, add);
        ptr = idxrelay;
    }

    str->setIndexReg(ptr);
}
void PreRALegalize::addInstBefore(const BlkP &blk, const std::shared_ptr<Vldr> &Vldr) {
    auto &insts = blk->getInsts();

    auto it = std::find_if(insts.begin(), insts.end(), [&Vldr](const auto &ptr) { return ptr.get() == Vldr.get(); });

    auto baseReg = std::dynamic_pointer_cast<BaseADROP>(Vldr->getSourceOP(1));
    int offset = baseReg->getConstOffset();
    constClearSet.insert(baseReg);

    auto [ptr, const_op] = varpool->getLoaded(offset, blk);

    if (auto stk = baseReg->as<StackADROP>()) {
        auto idxrelay = varpool->mkOP_backup(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto unknown = make<UnknownConstant>(stk->getObj());
        auto add = make<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, idxrelay, ptr, unknown, nullptr);
        insts.insert(it, add);
        ptr = idxrelay;
    }

    Vldr->setIndexReg(ptr);
}
void PreRALegalize::addInstBefore(const BlkP &blk, const std::shared_ptr<Vstr> &Vstr) {
    auto &insts = blk->getInsts();

    auto it = std::find_if(insts.begin(), insts.end(), [&Vstr](const auto &ptr) { return ptr.get() == Vstr.get(); });

    auto baseReg = std::dynamic_pointer_cast<BaseADROP>(Vstr->getSourceOP(2));
    int offset = baseReg->getConstOffset();
    constClearSet.insert(baseReg);

    auto [ptr, const_op] = varpool->getLoaded(offset, blk);

    if (auto stk = baseReg->as<StackADROP>()) {
        auto idxrelay = varpool->mkOP_backup(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        auto unknown = make<UnknownConstant>(stk->getObj());
        auto add = make<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, idxrelay, ptr, unknown, nullptr);
        insts.insert(it, add);
        ptr = idxrelay;
    }

    Vstr->setIndexReg(ptr);
}
#endif