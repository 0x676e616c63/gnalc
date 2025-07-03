#include "mir/MIR.hpp"
#include "mir/info.hpp"
#include "mir/riscv64/frame.hpp"
#include "mir/passes/transforms/lowering.hpp"

using namespace MIR;

void RVFrameInfo::handleCallEntry(IR::pCall callinst, LoweringContext &ctx) const {
    Err::todo();
}

MIRGlobal_p RVFrameInfo::handleLib(IR::pCall callinst, LoweringContext &ctx) const {
    Err::todo();
    return nullptr;
}

void RVFrameInfo::handleMemset(IR::pCall callinst, LoweringContext &ctx) const {
    Err::todo();
}

void RVFrameInfo::handleMemcpy(IR::pCall callinst, LoweringContext &ctx) const {
    Err::todo();
}

void RVFrameInfo::makePrologue(MIRFunction_p mfunc, LoweringContext &ctx) const {
    Err::todo();
}

void RVFrameInfo::makeReturn(IR::pRet retinst, LoweringContext &ctx) const {
    Err::todo();
}

bool RVFrameInfo::isCallerSaved(const MIROperand &op) const {
    Err::todo();
    return true;
}

bool RVFrameInfo::isCalleeSaved(const MIROperand &op) const {
    Err::todo();
    return true;
}

void RVFrameInfo::makePostSAPrologue(MIRBlk_p entry, CodeGenContext &ctx, unsigned stkSize) const {
    Err::todo();
}

void RVFrameInfo::makePostSAEpilogue(MIRBlk_p entry, CodeGenContext &ctx, unsigned stkSize) const {
    Err::todo();
}

void RVFrameInfo::insertPrologueEpilogue(MIRFunction *mfunc, CodeGenContext &ctx) const {
    Err::todo();
}
