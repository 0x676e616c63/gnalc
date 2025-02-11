#include "../../../include/mir/SIMDinstruction/memory.hpp"

using namespace MIR;

std::shared_ptr<Operand> Vmov::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand_1;
    } else {
        return nullptr;
    }
}

std::shared_ptr<Operand> Vldr::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand_1;
    } else {
        return nullptr;
    }
}

std::shared_ptr<Operand> Vstr::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand_1;
    } else if (seq == 2) {
        return SourceOperand_2;
    } else {
        return nullptr;
    }
}