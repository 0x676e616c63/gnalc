// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/MIR.hpp"
#include "mir/passes/transforms/RA.hpp"
#include "mir/tools.hpp"

using namespace MIR;

bool RegisterAllocImpl::isMoveInstruction(const MIRInst_p &minst) {

    if (!minst->isGeneric()) {
        return false;
    }

    auto mopcode = minst->opcode<OpC>();

    if (mopcode == OpC::InstCopy || mopcode == OpC::InstCopyFromReg || mopcode == OpC::InstCopyToReg) {

        if (isCore(minst->ensureDef()) && isCore(minst->getOp(1))) {

            if (!minst->getOp(1)->isImme()) { // chk use
                return true;
            }
        }
    }

    return false;
}

RegisterAllocImpl::Nodes RegisterAllocImpl::getUse(const MIRInst_p &minst) {
    Nodes uses;

    if (frameInfo->isFuncCall(minst)) {
        auto list = registerInfo->getCoreRegisterAllocationList();
        for (auto reg : list) {
            if (registerInfo->isCallerSaved(reg))
                uses.emplace(MIROperand::asISAReg(reg, OpT::Int));
        }
        return uses;
    }

    for (unsigned idx = 1; idx <= minst->getUseNr(); ++idx) {

        auto use = minst->getOp(idx);

        if (use && use->isVRegOrISAReg() && isCore(use)) {
            uses.emplace(use);
        }
    }

    return uses;
}

RegisterAllocImpl::Nodes RegisterAllocImpl::getDef(const MIRInst_p &minst) {
    Nodes defs;

    if (frameInfo->isFuncCall(minst)) {
        auto list = registerInfo->getCoreRegisterAllocationList();
        for (auto reg : list) {
            if (registerInfo->isCallerSaved(reg))
                defs.emplace(MIROperand::asISAReg(reg, OpT::Int));
        }
        return defs;
    }

    if (auto def = minst->getDef()) {

        if ((def->type() == OpT::Int16 || def->type() == OpT::Int32 || def->type() == OpT::Int64 ||
             def->type() == OpT::Int)) {

            defs.emplace(def);
        }
    }

    return defs;
}

MIROperand_p RegisterAllocImpl::heuristicSpill() {
    // const double Weight_IntervalLength = 5;
    // const double Weight_Degree = 3;
    // const double extra_Weight_ForNotPtr = +60;

    // ///@note 计算溢出权重
    // double weight_max = 0;
    // MIROperand_p spilled = nullptr;
    // for (const auto &op : spillWorkList) {

    //     double weight = 0;

    //     weight += liveinfo.intervalLengths[op] * Weight_IntervalLength; // narrowing convert here

    //     weight += degree[op] * Weight_Degree;

    //     if (op->type() != OpT::Int64) { // eh...
    //         weight += extra_Weight_ForNotPtr;
    //     }

    //     if (weight >= weight_max) {
    //         spilled = op;
    //         weight_max = weight;
    //     }
    // }
    // Err::gassert(spilled != nullptr, "heuristicSpill: spilled is nullptr");
    // // Logger::logInfo("spilled: " + std::to_string(spilled->getRecover()));
    return spillWorkList.front();
}

RegisterAllocImpl::Nodes RegisterAllocImpl::spill(const MIROperand_p &mop) {
    auto &ctx = mfunc->Context();

    auto getSize = [](OpT type) {
        switch (type) {
        case OpT::Intvec2:
        case OpT::Floatvec2:
        case OpT::Int64:
            return 8;
        case OpT::Floatvec3:
        case OpT::Intvec3:
            return 12;
        case OpT::Floatvec4:
        case OpT::Int64vec2:
        case OpT::Intvec4:
            return 16;
        case OpT::Int:
            return 8;
        default:
            return 4;
        }
    };

    ++spilltimes;

    Nodes stageValues;

    auto mtype = mop->type();
    auto stkobj = mfunc->addStkObj(mfunc->Context(), getSize(mtype), getSize(mtype), 0, StkObjUsage::Spill);

    MIROperand_p yet_another_insert_op = nullptr;

    for (auto &mblk : mfunc->blks()) {
        auto &minsts = mblk->Insts();
        for (auto it = minsts.begin(); it != minsts.end(); ++it) {
            const auto &minst = *it;
            auto uses = getUse(minst);
            auto defs = getDef(minst);

            // LAMBDA BEGIN

            auto add_yaio = [&](const auto &stage) {
                if (ctx.isARMv8() && minst->isGeneric() && minst->opcode<OpC>() == OpC::InstVInsert &&
                    !yet_another_insert_op) {
                    yet_another_insert_op = stage;
                }
            };

            // LAMBDA END

            if (defs.size() && minst->isGeneric() && minst->opcode<OpC>() == OpC::InstVInsert) {
                int debug;
            }

            if (auto it_op = uses.find(mop); it_op != uses.end()) {

                auto readStage =
                    !yet_another_insert_op ? MIROperand::asVReg(ctx.nextId(), mtype) : yet_another_insert_op;

                add_yaio(readStage);

                auto minst_load =
                    MIRInst::make(OpC::InstLoad)
                        ->setOperand<0>(readStage, mfunc->Context())
                        ->setOperand<1>(stkobj, mfunc->Context())
                        ->setOperand<5>(MIROperand::asImme(getBitWide(mtype), OpT::special), mfunc->Context());

                minsts.insert(it, minst_load);

                minst->replace(mop, readStage, ctx);

                stageValues.emplace(readStage);
            }

            if (auto it_op = defs.find(mop); it_op != defs.end()) {

                auto writeStage =
                    !yet_another_insert_op ? MIROperand::asVReg(ctx.nextId(), mtype) : yet_another_insert_op;

                add_yaio(writeStage);

                auto minst_store =
                    MIRInst::make(OpC::InstStore)
                        ->setOperand<1>(writeStage, mfunc->Context())
                        ->setOperand<2>(stkobj, mfunc->Context())
                        ->setOperand<5>(MIROperand::asImme(getBitWide(mtype), OpT::special), mfunc->Context());

                minsts.insert(std::next(it), minst_store);

                minst->replace(mop, writeStage, ctx);

                stageValues.emplace(writeStage);
            }
        }
    }

    return stageValues;
}

bool VectorRegisterAllocImpl::isMoveInstruction(const MIRInst_p &minst) {
    if (!minst->isGeneric()) {
        return false;
    }

    auto mopcode = minst->opcode<OpC>();

    if (mopcode == OpC::InstCopy || mopcode == OpC::InstCopyFromReg || mopcode == OpC::InstCopyToReg) {

        auto mtype = minst->ensureDef()->type();
        auto mtype2 = minst->getOp(1)->type();

        ///@warning RISCV  may be not fit this
        if (inRange(mtype, OpT::Float, OpT::Floatvec4) && inRange(mtype2, OpT::Float, OpT::Floatvec4)) {
            if (!minst->getOp(1)->isImme()) { // chk use
                return true;
            }
        }
    }

    return false;
}

RegisterAllocImpl::Nodes VectorRegisterAllocImpl::getUse(const MIRInst_p &minst) {
    Nodes uses;

    if (frameInfo->isFuncCall(minst)) {
        auto list = registerInfo->getFpOrVecRegisterAllocationList();
        for (auto reg : list) {
            if (registerInfo->isCallerSaved(reg))
                uses.emplace(MIROperand::asISAReg(reg, OpT::Float));
        }
        return uses;
    }

    for (unsigned idx = 1; idx <= minst->getUseNr(); ++idx) {

        auto use = minst->getOp(idx);

        if (use && use->isVRegOrISAReg() && inRange(use->type(), OpT::Float, OpT::Floatvec4)) {
            uses.emplace(use);
        }
    }

    return uses;
}

RegisterAllocImpl::Nodes VectorRegisterAllocImpl::getDef(const MIRInst_p &minst) {
    Nodes defs;

    if (frameInfo->isFuncCall(minst)) {
        auto list = registerInfo->getFpOrVecRegisterAllocationList();
        for (auto reg : list) {
            if (registerInfo->isCallerSaved(reg))
                defs.emplace(MIROperand::asISAReg(reg, OpT::Float));
        }
        return defs;
    }

    if (auto def = minst->getDef()) {

        if (inRange(def->type(), OpT::Float, OpT::Floatvec4)) {
            defs.emplace(def);
        }
    }

    return defs;
}
