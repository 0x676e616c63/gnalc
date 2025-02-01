#include "../../../include/mir/instructions/binary.hpp"
#include <cassert>

using namespace MIR;

std::shared_ptr<Operand> binaryInst::getSourceOP(unsigned int seq) {
    assert(seq <= 2 &&
           "Index out of range when request a source operand of a binaryInst");

    if (seq == 1)
        return SourceOperand_1;
    else
        return SourceOperand_2;
}