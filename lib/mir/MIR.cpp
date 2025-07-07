// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/MIR.hpp"

using namespace MIR;

std::map<unsigned, MIROperand_p> MIROperand::ISApool; // to alloc mems

MIROperand_p MIRFunction::addStkObj(CodeGenContext &ctx, unsigned size, unsigned alignmant, int offset,
                                    StkObjUsage usage) {
    MIROperand_p new_stk = MIROperand::asStkObj(ctx.nextId(), OpT::Int64);
    mStkObjs.emplace(new_stk, StkObj{size, alignmant, offset, usage});
    return new_stk;
}

MIROperand_p MIRFunction::addStkObj(CodeGenContext &ctx, unsigned size, unsigned alignmant, int offset,
                                    StkObjUsage usage, unsigned seq) {
    MIROperand_p new_stk = MIROperand::asStkObj(ctx.nextId(), OpT::Int64);
    mStkObjs.emplace(new_stk, StkObj{size, alignmant, offset, usage, seq});
    return new_stk;
}

unsigned MIRInst::getUseNr() const {
    unsigned cnt = 0; // record the max

    for (unsigned i = 1; i < MIRInst::maxOpCnt; ++i) { // skip def
        if (mOperands[i]) {
            cnt = i;
        }
    }

    return cnt;
}

unsigned MIRInst::getDefNr() const {
    ///@note currently only 0 or 1
    if (mOperands[0] == nullptr) {
        return 0;
    } else {
        return 1;
    }
}

unsigned MIRInst::getOpNr() const { return getUseNr() + getDefNr(); }

MIRModule::~MIRModule() {
    // FIXME:
    // This is a quick and dirty trick to avoid memory leak.
    // Currently we've found two circular references:
    // 1. MIRFunction is MIRReloc, which can be operands of instructions
    // contained in MIRFunction(ARMOpc::BL).
    // 2. MIRBlk's `mpreds` and `msuccs` contains shared_ptr of other blocks
    for (auto& fn : mFuncs) {
        for (auto& blk : fn->mBlks) {
            for (auto& inst : blk->mInsts)
                inst->mOperands.fill(nullptr);

            blk->mpreds.clear();
            blk->msuccs.clear();
        }
    }
}