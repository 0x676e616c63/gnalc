// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

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

    if (minst->isARM() && minst->opcode<ARMOpC>() == ARMOpC::BL) {
        for (int i = 0; i < 18; ++i) {
            uses.emplace(MIROperand::asISAReg(static_cast<ARMReg>(i), OpT::Int));
        }

        return uses;
    }

    for (unsigned idx = 1; idx <= minst->getUseNr(); ++idx) {

        auto use = minst->getOp(idx);

        if (use && use->isVRegOrISAReg() &&
            (use->type() == OpT::Int16 || use->type() == OpT::Int32 || use->type() == OpT::Int64 ||
             use->type() == OpT::Int)) {

            uses.emplace(use);
        }
    }

    return uses;
}

RegisterAllocImpl::Nodes RegisterAllocImpl::getDef(const MIRInst_p &minst) {
    Nodes defs;

    if (minst->isARM() && minst->opcode<ARMOpC>() == ARMOpC::BL) {

        for (int i = 0; i < 19; ++i) {
            defs.emplace(MIROperand::asISAReg(static_cast<ARMReg>(i), OpT::Int));
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
    const double Weight_IntervalLength = 5;
    const double Weight_Degree = 3;
    const double extra_Weight_ForNotPtr = +60;

    ///@note 计算溢出权重
    double weight_max = 0;
    MIROperand_p spilled = nullptr;
    for (const auto &op : spillWorkList) {

        double weight = 0;

        weight += liveinfo.intervalLengths[op] * Weight_IntervalLength; // narrowing convert here

        weight += degree[op] * Weight_Degree;

        if (op->type() != OpT::Int64) { // eh...
            weight += extra_Weight_ForNotPtr;
        }

        if (weight >= weight_max) {
            spilled = op;
            weight_max = weight;
        }
    }
    Err::gassert(spilled != nullptr, "heuristicSpill: spilled is nullptr");
    // Logger::logInfo("spilled: " + std::to_string(spilled->getRecover()));
    return spilled;
}

RegisterAllocImpl::Nodes RegisterAllocImpl::spill(const MIROperand_p &mop) {
    auto &ctx = mfunc->Context();

    auto getSize = [](OpT type) {
        switch (type) {
        case OpT::Int64:
            return 8;
        case OpT::Floatvec:
        case OpT::Int64vec:
        case OpT::Intvec:
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

    for (auto &mblk : mfunc->blks()) {
        auto &minsts = mblk->Insts();
        for (auto it = minsts.begin(); it != minsts.end(); ++it) {
            auto minst = *it;
            auto uses = getUse(minst);
            auto defs = getDef(minst);

            if (auto it_op = uses.find(mop); it_op != uses.end()) {
                auto readStage = MIROperand::asVReg(ctx.nextId(), mtype);
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
                auto writeStage = MIROperand::asVReg(ctx.nextId(), mtype);
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
        if (inSet(mtype, OpT::Float32, OpT::Floatvec, OpT::Intvec, OpT::Int64vec, OpT::Float) &&
            inSet(mtype2, OpT::Float32, OpT::Floatvec, OpT::Intvec, OpT::Int64vec, OpT::Float)) {
            if (!minst->getOp(1)->isImme()) { // chk use
                return true;
            }
        }
    }

    return false;
}

RegisterAllocImpl::Nodes VectorRegisterAllocImpl::getUse(const MIRInst_p &minst) {
    Nodes uses;

    if (minst->isARM() && minst->opcode<ARMOpC>() == ARMOpC::BL) {
        for (int i = 0; i < 8; ++i) { // v0 ~ v7
            uses.emplace(MIROperand::asISAReg(static_cast<ARMReg>(i + 32U), OpT::Float));
        }

        for (int i = 16; i < 32; ++i) { // v16 ~ v31
            uses.emplace(MIROperand::asISAReg(static_cast<ARMReg>(i + 32U), OpT::Float));
        }

        return uses;
    }

    for (unsigned idx = 1; idx <= minst->getUseNr(); ++idx) {

        auto use = minst->getOp(idx);

        if (use && use->isVRegOrISAReg() &&
            inSet(use->type(), OpT::Float, OpT::Float32, OpT::Floatvec, OpT::Intvec, OpT::Int64vec)) {
            uses.emplace(use);
        }
    }

    return uses;
}

RegisterAllocImpl::Nodes VectorRegisterAllocImpl::getDef(const MIRInst_p &minst) {
    Nodes defs;

    if (minst->isARM() && minst->opcode<ARMOpC>() == ARMOpC::BL) {
        for (int i = 0; i < 8; ++i) { // v0 ~ v7
            defs.emplace(MIROperand::asISAReg(static_cast<ARMReg>(i + 32U), OpT::Float));
        }

        for (int i = 16; i < 32; ++i) { // v16 ~ v31
            defs.emplace(MIROperand::asISAReg(static_cast<ARMReg>(i + 32U), OpT::Float));
        }

        return defs;
    }

    if (auto def = minst->getDef()) {

        if (inSet(def->type(), OpT::Float, OpT::Float32, OpT::Intvec, OpT::Int64vec, OpT::Floatvec)) {
            defs.emplace(def);
        }
    }

    return defs;
}
