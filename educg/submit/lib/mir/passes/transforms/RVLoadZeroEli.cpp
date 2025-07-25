// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/mir/passes/transforms/RVLoadZeroEli.hpp"

#include "../../../../include/mir/passes/transforms/isel.hpp"

using namespace MIR;

bool isLoadZero(const MIRInst_p &curr) {
    if (curr->isRV())
        return curr->opcode<RVOpC>() == RVOpC::LI && curr->getOp(1)->imme() == 0;
    if (curr->isGeneric()) {
        return (curr->opcode<OpC>() == OpC::InstLoadImm || curr->opcode<OpC>() == OpC::InstLoadImmEx) &&
               curr->getOp(1)->imme() == 0;
    }
    return false;
}

PM::PreservedAnalyses RVLoadZeroEli::run(MIRFunction &func, FAM &fam) {
    for (const auto &blk : func.blks()) {
        for (const auto &curr : blk->Insts()) {
            if (isLoadZero(curr)) {
                auto &def = curr->ensureDef();
                auto x0 = MIROperand::asISAReg(RVReg::X0, def->type());
                auto op = chooseCopyOpC(def, x0);
                Logger::logDebug("RVLoadZeroEli: ", curr->dbgDump());
                curr->resetOpcode(op);
                curr->setOperand<1>(x0, func.Context());
            }
        }
    }
    return PM::PreservedAnalyses::all();
}
