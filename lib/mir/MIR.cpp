#include "mir/MIR.hpp"

using namespace MIR_new;

MIROperand_p MIRFunction::addStkObj(struct CodeGenContext &ctx, unsigned size, unsigned alignmant, int offset,
                                    StkObjUsage usage) {
    auto new_stk = MIROperand::asStkObj(ctx.nextId(), OpT::special);
    mStkObjs.emplace(new_stk, StkObj{size, alignmant, offset, usage}); // stkobj改成map, 和老mir不一样
    return new_stk;
}

MIROperand_p MIRFunction::addStkObj(struct CodeGenContext &ctx, unsigned size, unsigned alignmant, int offset,
                                    StkObjUsage usage, unsigned seq) {
    auto new_stk = MIROperand::asStkObj(ctx.nextId(), OpT::special);
    mStkObjs.emplace(new_stk, StkObj{size, alignmant, offset, usage, seq});
    return new_stk;
}

unsigned MIRInst::getUseNr() const {
    unsigned cnt = 0;

    for (unsigned i = 1; i < MIRInst::maxOpCnt; ++i) { // skip def
        if (mOperands[i]) {
            ++cnt;
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
