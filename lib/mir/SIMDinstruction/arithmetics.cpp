#include "../../../include/mir/SIMDinstruction/arithmetics.hpp"

using namespace MIR;

std::shared_ptr<Operand> Vbinary::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand_1;
    } else if (seq == 2) {
        return SourceOperand_2;
    } else {
        return nullptr;
    }
}

std::shared_ptr<Operand> Vunary::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand_1;
    } else {
        return nullptr;
    }
}

std::shared_ptr<Operand> Vcmp::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand_1;
    } else if (seq == 2) {
        return SourceOperand_2;
    } else {
        return nullptr;
    }
}