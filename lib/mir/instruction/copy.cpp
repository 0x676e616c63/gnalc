#include "../../../include/mir/instructions/copy.hpp"

using namespace MIR;

std::shared_ptr<Operand> COPY::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand;
    else
        return nullptr;
}

std::shared_ptr<Operand> PHI::getSourceOP(unsigned int seq) {
    if (seq > SourceOperands.size()) {
        return nullptr;
    } else {
        return SourceOperands[seq - 1].val;
    }
}

std::string PHI::toString() {
    std::string str;

    str += getTargetOP()->toString();
    str += "= PHI ";

    for (const auto &PhiOper : SourceOperands) {
        str += "[ ";
        str += PhiOper.val->toString() + ", ";
        str += '%' + PhiOper.pre + " ], ";
    }

    return str;
}