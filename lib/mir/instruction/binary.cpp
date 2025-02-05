#include "../../../include/mir/instructions/binary.hpp"
#include "../../../include/mirtools/enum_name.hpp"

using namespace MIR;

std::shared_ptr<Operand> unaryInst::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand_1;
    else
        return nullptr;
}

bool unaryInst::Check() {
    if (tptrait != SourceOperandType::r)
        return false;

    if (!dynamic_cast<BindOnVirOP *>(SourceOperand_1.get()))
        return false;
    else
        return true;
}

std::shared_ptr<Operand> binaryInst::getSourceOP(unsigned int seq) {

    if (seq == 1)
        return SourceOperand_1;
    else if (seq == 2)
        return SourceOperand_2;
    return nullptr;
}

bool binaryInst::Check() {
    // check tptrait
    if (tptrait != SourceOperandType::rr)
        return false;

    // check operands type

    if (!dynamic_cast<BindOnVirOP *>(SourceOperand_1.get()) ||
        !dynamic_cast<BindOnVirOP *>(SourceOperand_2.get()))
        return false;
    else
        return true;
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

bool ternaryInst::Check() {
    // check tptrait
    if (tptrait != SourceOperandType::rrr)
        return false;

    // check operands type

    if (!dynamic_cast<BindOnVirOP *>(SourceOperand_1.get()) ||
        !dynamic_cast<BindOnVirOP *>(SourceOperand_2.get()) ||
        !dynamic_cast<BindOnVirOP *>(SourceOperand_2.get()))
        return false;
    else
        return true;
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

bool binaryImmInst::Check() {
    // check tptrait
    if (tptrait != SourceOperandType::rr && tptrait != SourceOperandType::rsi &&
        tptrait != SourceOperandType::ri)
        return false;

    // check operands type
    if (!dynamic_cast<BindOnVirOP *>(SourceOperand_1.get()))
        return false;

    if (dynamic_cast<ConstantIDX *>(SourceOperand_2.get()) &&
        !SourceOperand_3.get())
        return true;

    else if (dynamic_cast<BindOnVirOP *>(SourceOperand_2.get()) &&
             (!SourceOperand_3.get() ||
              dynamic_cast<ShiftOP *>(SourceOperand_3.get()))) {
        return true;

    } else
        return false;
}

std::shared_ptr<Operand> compareInst::getSourceOP(unsigned int seq) {

    if (seq == 1)
        return SourceOperand_1;
    else if (seq == 2)
        return SourceOperand_2;
    return nullptr;
}

bool compareInst::Check() {
    // check tptrait
    if (tptrait != SourceOperandType::rr)
        return false;

    // check operands type

    if (!dynamic_cast<BindOnVirOP *>(SourceOperand_1.get()) ||
        !dynamic_cast<BindOnVirOP *>(SourceOperand_2.get()))
        return false;
    else
        return true;
}
