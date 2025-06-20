#include "mir/MIR.hpp"

using namespace MIR;

void ARMInstTemplate::registerInc(MIRInst_p_l minsts, MIRInst_p_l::iterator it, ARMReg isa, unsigned amount,
                                  CodeGenContext &ctx) {
    ///@todo 这里如何区分位宽? 虽然不区分直接使用64位也可以

    MIROperand_p mimme = MIROperand::asImme(amount, OpT::Int);

    if (!is12ImmeWithProbShift(amount)) {
        ///@note armv7有专门的过程间寄存器ip(r12)
        ///@note ip是caller-save寄存器
        ///@note 用于存储临时数据, 辅助长跳转...
        ///@warning armv8没有对应的过程间寄存器
        ///@warning 所以这里用FP(X29)取代ip的工作, 反正也没有动态栈
        auto scratch = MIROperand::asISAReg(ARMReg::FP, OpT::Int64);
        auto imme = amount;
        auto movz = MIRInst::make(ARMOpC::MOVZ)
                        ->setOperand<0>(scratch, ctx)
                        ->setOperand<1>(MIROperand::asImme(imme & 0XFFFF, OpT::Int16), ctx);

        minsts.insert(it, movz);

        imme >>= 16;
        unsigned times = 1;
        while (imme != 0) {
            auto movk = MIRInst::make(ARMOpC::MOVK)
                            ->setOperand<0>(scratch, ctx)
                            ->setOperand<1>(MIROperand::asImme(imme & 0XFFFF, OpT::Int16), ctx)
                            ->setOperand<2>(MIROperand::asImme(16 | 0x00000000, OpT::special), ctx); // lsl only
            minsts.insert(it, movk);

            ++times;
            imme >>= 16;
        }
        mimme = scratch;
    }

    auto misa = MIROperand::asISAReg(isa, OpT::Int);

    auto minst_inc =
        MIRInst::make(ARMOpC::INC)->setOperand<0>(misa, ctx)->setOperand<1>(misa, ctx)->setOperand<2>(mimme, ctx);

    minsts.insert(it, minst_inc); // ?

    return;
}

void ARMInstTemplate::registerDec(MIRInst_p_l minsts, MIRInst_p_l::iterator it, ARMReg isa, unsigned amount,
                                  CodeGenContext &ctx) {
    MIROperand_p mimme = MIROperand::asImme(amount, OpT::Int);

    if (!is12ImmeWithProbShift(amount)) {
        auto scratch = MIROperand::asISAReg(ARMReg::FP, OpT::Int64);
        auto imme = amount;
        auto movz = MIRInst::make(ARMOpC::MOVZ)
                        ->setOperand<0>(scratch, ctx)
                        ->setOperand<1>(MIROperand::asImme(imme & 0XFFFF, OpT::Int16), ctx);

        minsts.insert(it, movz);

        imme >>= 16;
        unsigned times = 1;
        while (imme != 0) {
            auto movk = MIRInst::make(ARMOpC::MOVK)
                            ->setOperand<0>(scratch, ctx)
                            ->setOperand<1>(MIROperand::asImme(imme & 0XFFFF, OpT::Int16), ctx)
                            ->setOperand<2>(MIROperand::asImme(16 | 0x00000000, OpT::special), ctx); // lsl only
            minsts.insert(it, movk);

            ++times;
            imme >>= 16;
        }
        mimme = scratch;
    }

    auto misa = MIROperand::asISAReg(isa, OpT::Int);

    auto minst_inc =
        MIRInst::make(ARMOpC::DEC)->setOperand<0>(misa, ctx)->setOperand<1>(misa, ctx)->setOperand<2>(mimme, ctx);

    minsts.insert(it, minst_inc);

    return;
}

void ARMInstTemplate::registerAdjust(MIRInst_p_l minsts, MIRInst_p_l::iterator it, ARMReg isa, int amount,
                                     CodeGenContext &ctx) {

    if (amount == 0) {
        ARMInstTemplate::registerInc(minsts, it, isa, 0, ctx);
    } else if (amount > 0) {
        ARMInstTemplate::registerInc(minsts, it, isa, amount, ctx);
    } else {
        ARMInstTemplate::registerDec(minsts, it, isa, std::abs(amount), ctx);
    }
}