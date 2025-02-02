#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mirtools/enum_name.hpp"

using namespace MIR;

bool branchInst::Check() {
    if (tptrait != SourceOperandType::cp)
        return false;
    else
        return true;
}