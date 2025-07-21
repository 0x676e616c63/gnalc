// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#include "../../../../include/legacy_mir/passes/transforms/uselessMovEli.hpp"

using namespace LegacyMIR;

PM::PreservedAnalyses uselessMovEli::run(Function &func, FAM &fam) {
    function = &func;

    impl(func);

    return PM::PreservedAnalyses::all();
}

void uselessMovEli::impl(Function &function) {

    for (const auto &blk : function.getBlocks()) {

        auto &insts = blk->getInsts();
        for (auto it = insts.begin(); it != insts.end();) {
            auto &inst = *it;
            ++it;

            if (isUseless(inst))
                blk->delInst(inst);
        }
    }
}

bool uselessMovEli::isUseless(const InstP &inst) {

    auto opcode = inst->getOpCode();

    if (opcode.index() == 0) {

        auto op = std::get<OpCode>(opcode);

        if (op != OpCode::MOV && op != OpCode::COPY)
            return false;

        auto target = inst->getTargetOP();

        if (target->getOperandTrait() == OperandTrait::BaseAddress)
            target = target->as<BaseADROP>()->getBase();

        auto source = std::dynamic_pointer_cast<BindOnVirOP>(inst->getSourceOP(1));

        if (!source)
            return false;

        if (source->getOperandTrait() == OperandTrait::BaseAddress)
            source = source->as<BaseADROP>()->getBase();

        if (op == OpCode::COPY) {
            if (target->getBank() != source->getBank())
                return false;
            auto bank = target->getBank();

            switch (bank) {
            case RegisterBank::gpr:
                if (std::get<CoreRegister>(target->getColor()) != std::get<CoreRegister>(source->getColor()))
                    return false;
                break;
            case RegisterBank::spr:
                if (std::get<FPURegister>(target->getColor()) != std::get<FPURegister>(source->getColor()))
                    return false;
                break;
            default:
                Err::todo("dpr, qpr todo...");
            }
            return true; // avoid std::get<...> below
        }

        // mov
        if (std::get<CoreRegister>(target->getColor()) != std::get<CoreRegister>(source->getColor()))
            return false;

        if (std::get<CoreRegister>(target->getColor()) == CoreRegister::none)
            return false; // to fit RA, not in use now

    } else {
        auto op = std::get<NeonOpCode>(opcode);

        if (op != NeonOpCode::VMOV)
            return false;

        auto target = inst->getTargetOP();
        auto source = std::dynamic_pointer_cast<BindOnVirOP>(inst->getSourceOP(1));

        if (!source)
            return false;

        ///@note 理论上应该再检查dataTypePair...
        if (target->getColor().index() != 1 || source->getColor().index() != 1)
            return false;

        if (std::get<FPURegister>(target->getColor()) != std::get<FPURegister>(source->getColor()))
            return false;

        if (std::get<FPURegister>(target->getColor()) == FPURegister::none)
            return false;
    }

    return true;
}
#endif