#include "../../../include/mir/instructions/copy.hpp"
#include "../../../include/mirtools/enum_name.hpp"

using namespace MIR;

std::shared_ptr<Operand> COPY::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand;
    else
        return nullptr;
}

void COPY::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1) {
        SourceOperand = ptr_new;
    } else {
        Err::unreachable("set operand index out of ");
    }
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
    str += '\n';

    return str;
}

std::string calleesaveInst::toString() {
    std::string str;

    str += enum_name(std::get<OpCode>(opcode)) + ' ';

    for (const auto &reg : getRegList()) {
        str += "$" + enum_name(static_cast<CoreRegister>(reg)) + " ,";
    }
    str += '\n';

    return str;
}