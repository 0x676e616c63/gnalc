#include "mir/passes/transforms/RA.hpp"

using namespace MIR_new;

bool RegisterAllocImpl::isMoveInstruction(const MIRInst_p &minst) {

    if (!minst->isGeneric()) {
        return false;
    }

    auto mopcode = minst->opcode<OpC>();

    if (mopcode == OpC::InstCopy || mopcode == OpC::InstCopyFromReg || mopcode == OpC::InstCopyToReg) {

        auto mtype = minst->getDef()->type();
        if (mtype == OpT::Int16 || mtype == OpT::Int32 || mtype == OpT::Int64 || mtype == OpT::Int) {
            return true;
        }
    }

    return false;
}

RegisterAllocImpl::Nodes RegisterAllocImpl::getUse(const MIRInst_p &minst) {
    Nodes uses;

    if (!minst->isGeneric() && minst->opcode<ARMOpC>() == ARMOpC::BL) {
        for (int i = 0; i < 18; ++i) {
            uses.emplace(MIROperand::asISAReg(static_cast<ARMReg>(i), OpT::Int));
        }

        // 虽然一般也不会assign LR
        uses.emplace(MIROperand::asISAReg(ARMReg::LR, OpT::Int));

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

    if (!minst->isGeneric() && minst->opcode<ARMOpC>() == ARMOpC::BL) {
        for (int i = 0; i < 18; ++i) {
            defs.emplace(MIROperand::asISAReg(static_cast<ARMReg>(i), OpT::Int));
        }

        defs.emplace(MIROperand::asISAReg(ARMReg::LR, OpT::Int));

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
    const double extra_Weight_ForNotPtr = +60; // origin: 60

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
    return spilled;
}

RegisterAllocImpl::Nodes RegisterAllocImpl::spill(const MIROperand_p &mop) {
    auto &ctx = mfunc->CodeGenContext();

    auto getSize = [](OpT type) {
        switch (type) {
        case OpT::Int64:
            return 8;
        case OpT::Floatvec:
            return 16;
        case OpT::Intvec:
            return 16;
        case OpT::Int:
            return 8;
        default:
            return 4;
        }
    };

    ++spilltimes;

    Nodes stageValues{};

    auto stkobj =
        mfunc->addStkObj(mfunc->CodeGenContext(), getSize(mop->type()), getSize(mop->type()), 0, StkObjUsage::Spill);

    for (auto &mblk : mfunc->blks()) {
        auto &minsts = mblk->Insts();
        for (auto it = minsts.begin(); it != minsts.end(); ++it) {
            auto minst = *it;
            auto uses = getUse(minst);
            auto defs = getDef(minst);

            if (auto it_op = uses.find(mop); it_op != uses.end()) {
                auto readStage = MIROperand::asVReg(ctx.nextId(), mop->type());
                auto minst_load = MIRInst::make(OpC::InstLoad)->setOperand<0>(readStage)->setOperand<1>(stkobj);

                minsts.insert(it, minst_load);

                minst->replace(*it_op, readStage);

                stageValues.insert(readStage);
                continue;
            }

            if (auto it_op = defs.find(mop); it_op != defs.end()) {
                auto writeStage = MIROperand::asVReg(ctx.nextId(), mop->type());
                auto minst_store = MIRInst::make(OpC::InstStore)->setOperand<1>(writeStage)->setOperand<2>(stkobj);

                minsts.insert(std::next(it), minst_store);

                minst->replace(*it_op, writeStage);

                stageValues.insert(writeStage);
                continue;
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

        auto mtype = minst->getDef()->type();
        if (mtype == OpT::Float32 || mtype == OpT::Floatvec || mtype == OpT::Intvec) {
            return true;
        }
    }

    return false;
}

RegisterAllocImpl::Nodes VectorRegisterAllocImpl::getUse(const MIRInst_p &minst) {
    Nodes uses;

    if (!minst->isGeneric() && minst->opcode<ARMOpC>() == ARMOpC::BL) {
        for (int i = 0; i < 16; ++i) {
            uses.emplace(MIROperand::asISAReg(static_cast<ARMReg>(i + 32U), OpT::Int));
        }

        return uses;
    }

    for (unsigned idx = 1; idx <= minst->getUseNr(); ++idx) {

        auto use = minst->getOp(idx);

        if (use && use->isVRegOrISAReg() &&
            (use->type() == OpT::Float32 || use->type() == OpT::Floatvec || use->type() == OpT::Intvec)) {
            uses.emplace(use);
        }
    }

    return uses;
}

RegisterAllocImpl::Nodes VectorRegisterAllocImpl::getDef(const MIRInst_p &minst) {
    Nodes defs;

    if (!minst->isGeneric() && minst->opcode<ARMOpC>() == ARMOpC::BL) {
        for (int i = 0; i < 16; ++i) {
            defs.emplace(MIROperand::asISAReg(static_cast<ARMReg>(i + 32U), OpT::Float32));
        }

        return defs;
    }

    if (auto def = minst->getDef()) {

        if ((def->type() == OpT::Float32 || def->type() == OpT::Intvec || def->type() == OpT::Floatvec)) {
            defs.emplace(def);
        }
    }

    return defs;
}
