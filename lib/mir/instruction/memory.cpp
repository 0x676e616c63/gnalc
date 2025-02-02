#include "../../../include/mir/instructions/memory.hpp"

using namespace MIR;

std::shared_ptr<Operand> movInst::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand;
    else
        return nullptr;
}

bool movInst::Check() {
    if (tptrait != SourceOperandType::r || tptrait != SourceOperandType::cp)
        return false;

    if (!dynamic_cast<BindOnVirOP *>(SourceOperand.get()) &&
        !dynamic_cast<ConstantIDX *>(SourceOperand.get()))
        return false;
    else
        return true;
}

std::shared_ptr<Operand> strInst::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand;
    } else if (seq == 2) {
        return MemoryAddr;
    } else {
        return nullptr;
    }
}

bool strInst::Check() {
    if (tptrait != SourceOperandType::ra)
        return false;

    if (!dynamic_cast<BindOnVirOP *>(SourceOperand.get()) ||
        !dynamic_cast<BaseADROP *>(MemoryAddr.get()))
        return false;
    else
        return true;
}

std::shared_ptr<Operand> ldrInst::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return MemoryAddr;
    } else {
        return nullptr;
    }
}

bool ldrInst::Check() {
    if (tptrait != SourceOperandType::a) {
        return false;
    }

    if (!dynamic_cast<BaseADROP *>(MemoryAddr.get())) {
        return false;
    } else {
        return true;
    }
}