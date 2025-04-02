#include "../../../../include/mir/passes/transforms/uselessMovEli.hpp"

using namespace MIR;

PM::PreservedAnalyses uselessMovEli::run(Function &func, FAM &fam) {
    // function = &func;

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
        auto source = std::dynamic_pointer_cast<BindOnVirOP>(inst->getSourceOP(1));

        if (!source)
            return false;

        if (std::get<CoreRegister>(target->getColor()) != std::get<CoreRegister>(source->getColor()))
            return false;

        if (std::get<CoreRegister>(target->getColor()) == CoreRegister::none)
            return false; // to fit RA

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