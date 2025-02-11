#include "../../../include/mir/instructions/copy.hpp"

using namespace MIR;

std::shared_ptr<Operand> COPY::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand;
    else
        return nullptr;
}
