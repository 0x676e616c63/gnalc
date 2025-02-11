#include "../../../include/mir/instructions/binary.hpp"
#include "../../../include/mirtools/enum_name.hpp"

using namespace MIR;

std::shared_ptr<Operand> unaryInst::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand_1;
    else
        return nullptr;
}

std::shared_ptr<Operand> binaryInst::getSourceOP(unsigned int seq) {

    if (seq == 1)
        return SourceOperand_1;
    else if (seq == 2)
        return SourceOperand_2;
    return nullptr;
}


std::shared_ptr<Operand> ternaryInst::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand_1;
    else if (seq == 2)
        return SourceOperand_2;
    else if (seq == 3)
        return SourceOperand_3;
    else
        return nullptr;
}

std::shared_ptr<Operand> binaryImmInst::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand_1;
    else if (seq == 2)
        return SourceOperand_2;
    else if (seq == 3)
        return SourceOperand_3;
    else
        return nullptr;
}


std::shared_ptr<Operand> compareInst::getSourceOP(unsigned int seq) {

    if (seq == 1)
        return SourceOperand_1;
    else if (seq == 2)
        return SourceOperand_2;
    return nullptr;
}
