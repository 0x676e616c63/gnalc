#include "../../include/mir/instruction.hpp"
#include "../../include/mirtools/enum_name.hpp"

using namespace MIR;

std::string Instruction::toString() {
    std::string str;

    if (TargetOperand.get())
        str += TargetOperand->toString() + " = ";

    if (opcode.index() == 0)
        str += enum_name(std::get<OpCode>(opcode));
    else
        str += enum_name(std::get<NeonOpCode>(opcode));

    str += enum_name(condition);
    if (flashFlag)
        str += 's';

    str += '-' + enum_name(tptrait) + ' ';

    if (getSourceOP(1)) {
        str += getSourceOP(1)->toString() + ' ';
    }
    if (getSourceOP(2)) {
        str += getSourceOP(2)->toString() + ' ';
    }
    if (getSourceOP(3)) {
        str += getSourceOP(3)->toString() + ' ';
    }

    str += '\n';
    return str;
}