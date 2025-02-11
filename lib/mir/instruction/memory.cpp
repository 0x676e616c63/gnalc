#include "../../../include/mir/instructions/memory.hpp"

using namespace MIR;

std::shared_ptr<Operand> movInst::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand;
    else
        return nullptr;
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

std::shared_ptr<Operand> ldrInst::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return MemoryAddr;
    } else {
        return nullptr;
    }
}
