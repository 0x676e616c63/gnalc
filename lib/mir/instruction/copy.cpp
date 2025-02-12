#include "../../../include/mir/instructions/copy.hpp"

using namespace MIR;

std::shared_ptr<Operand> copy::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand;
    else
        return nullptr;
}

bool copy::Check() {
    if (tptrait != SourceOperandType::r)
        return false;

    if (!dynamic_cast<BindOnVirOP *>(SourceOperand.get()))
        return false;
    else
        return true;
}