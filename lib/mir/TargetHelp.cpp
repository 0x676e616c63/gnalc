#include "mir/MIR.hpp"
#include "mir/tools.hpp"

using namespace MIR_new;

void ARMInstTemplate::registerInc(MIRInst_p_l minsts, MIRInst_p_l::iterator it, ARMReg isa, unsigned amount) {
    ///@todo 这里如何区分位宽? 虽然不区分直接使用64位也可以

    MIROperand_p mimme = MIROperand::asImme(amount, OpT::Int);

    if (!is12ImmeWithProbShift(amount)) {
        ///@note armv7有专门的过程间寄存器ip(r12)
        ///@note ip是caller-save寄存器
        ///@note 用于存储临时数据, 辅助长跳转...
        ///@warning armv8没有对应的过程间寄存器
        ///@warning 所以这里用FP(X29)取代ip的工作, 反正也没有动态栈
        auto scratchReg = MIROperand::asISAReg(ARMReg::X29, OpT::Int);

        auto minst_loadImm = MIRInst::make(OpC::InstLoadImmToReg)->setOperand<0>(scratchReg)->setOperand<1>(mimme);

        minsts.insert(it, minst_loadImm);
        mimme = scratchReg;
    }

    auto misa = MIROperand::asISAReg(isa, OpT::Int);

    auto minst_inc = MIRInst::make(ARMOpC::INC)->setOperand<0>(misa)->setOperand<1>(misa)->setOperand<2>(mimme);

    minsts.insert(it, minst_inc); // ?

    return;
}

void ARMInstTemplate::registerDec(MIRInst_p_l minsts, MIRInst_p_l::iterator it, ARMReg isa, unsigned amount) {
    MIROperand_p mimme = MIROperand::asImme(amount, OpT::Int);

    if (!is12ImmeWithProbShift(amount)) {
        auto scratchReg = MIROperand::asISAReg(ARMReg::X29, OpT::Int);

        auto minst_loadImm = MIRInst::make(OpC::InstLoadImmToReg)->setOperand<0>(scratchReg)->setOperand<1>(mimme);

        minsts.insert(it, minst_loadImm);
        mimme = scratchReg;
    }

    auto misa = MIROperand::asISAReg(isa, OpT::Int);

    auto minst_inc = MIRInst::make(ARMOpC::DEC)->setOperand<0>(misa)->setOperand<1>(misa)->setOperand<2>(mimme);

    minsts.insert(it, minst_inc);

    return;
}

void ARMInstTemplate::registerAdjust(MIRInst_p_l minsts, MIRInst_p_l::iterator it, ARMReg isa, int amount) {

    if (amount == 0) {
        ARMInstTemplate::registerInc(minsts, it, isa, 0);
    } else if (amount > 0) {
        ARMInstTemplate::registerInc(minsts, it, isa, amount);
    } else {
        ARMInstTemplate::registerDec(minsts, it, isa, std::abs(amount));
    }
}