#include "mir/MIR.hpp"

using namespace MIR_new;

MIROperand_p MIRFunction::addStkObj(CodeGenContext &ctx, unsigned size, unsigned alignmant, int offset,
                                    StkObjUsage usage) {
    auto new_stk = MIROperand::asStkObj(ctx.nextId(), OpT::special);
    mStkObjs.emplace(new_stk, StkObj{size, alignmant, offset, usage}); // stkobj改成map, 和老mir不一样
    return new_stk;
}