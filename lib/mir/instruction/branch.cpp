#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mirtools/enum_name.hpp"

using namespace MIR;

std::string branchInst::toString() {
    std::string str;
    str += enum_name(std::get<OpCode>(opcode)) + ' ';
    str += JmpTo;

    return str;
}