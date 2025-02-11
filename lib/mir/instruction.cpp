#include "../../include/mir/instruction.hpp"
#include "../../include/mirtools/enum_name.hpp"

using namespace MIR;

std::string Instruction::toString() {
    std::string str;

    if (TargetOperand.get())
        str += TargetOperand->toString() + " = ";

    str += enum_name(std::get<OpCode>(opcode));

    str += enum_name(condition);
    if (flashFlag && std::get<OpCode>(opcode) != OpCode::CMN &&
        std::get<OpCode>(opcode) != OpCode::CMP &&
        std::get<OpCode>(opcode) != OpCode::TST)
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

std::string NeonInstruction::toString() {
    std::string str;

    if (getTargetOP().get())
        str += getTargetOP()->toString() + " = ";

    str += enum_name(std::get<NeonOpCode>(getOpCode()));

    str += enum_name(getCondCodeFlag()); ///

    str += '.' + enum_name(dataTypes.first) + '.' + enum_name(dataTypes.second);

    /// Neon指令没有S标记

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