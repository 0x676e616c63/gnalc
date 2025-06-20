#ifdef GNALC_EXTENSION_ARMv7
#include "legacy_mir/instruction.hpp"
#include "legacy_mir/enum_name.hpp"

using namespace LegacyMIR;

Instruction::Instruction(OpCode _opcode, SourceOperandType _tptrait) : opcode(_opcode), tptrait(_tptrait) {}
Instruction::Instruction(NeonOpCode _opcode, SourceOperandType _tptrait) : opcode(_opcode), tptrait(_tptrait) {}

std::variant<OpCode, NeonOpCode> Instruction::getOpCode() const { return opcode; }

void Instruction::addTargetOP(std::shared_ptr<BindOnVirOP> TargetOperand_) {
    TargetOperand = std::move(TargetOperand_);
}

const std::shared_ptr<BindOnVirOP> &Instruction::getTargetOP() const { return TargetOperand; };

CondCodeFlag Instruction::getCondCodeFlag() const { return condition; }
void Instruction::setCondCodeFlag(CondCodeFlag newFlag) { condition = newFlag; }

void Instruction::setFlash() { flashFlag = true; }
bool Instruction::isSetFlash() const { return flashFlag; }

std::string Instruction::toString() {
    std::string str;

    if (TargetOperand.get())
        str += TargetOperand->toString() + " = ";

    str += enum_name(std::get<OpCode>(opcode));

    str += enum_name(condition);
    if (flashFlag && std::get<OpCode>(opcode) != OpCode::CMN && std::get<OpCode>(opcode) != OpCode::CMP &&
        std::get<OpCode>(opcode) != OpCode::TST && std::get<OpCode>(opcode) != OpCode::TEQ)
        str += 'S';

    str += enum_name(tptrait) + ' ';

    if (getSourceOP(1)) {
        str += getSourceOP(1)->toString();
    }
    if (getSourceOP(2)) {
        str += ", " + getSourceOP(2)->toString();
    }
    if (getSourceOP(3)) {
        str += ", " + getSourceOP(3)->toString();
    }

    str += '\n';
    return str;
}

// std::string bitTage(std::pair<bitType, bitType> dataTypes) {}
NeonInstruction::NeonInstruction(NeonOpCode _opcode, SourceOperandType _type,
                                 const std::pair<bitType, bitType> &_dataTypes)
    : Instruction(_opcode, _type), dataTypes(_dataTypes) {}

std::pair<bitType, bitType> NeonInstruction::getDataTypes() const { return dataTypes; }

std::string NeonInstruction::toString() {
    std::string str;

    if (getTargetOP().get())
        str += getTargetOP()->toString() + " = ";

    str += enum_name(std::get<NeonOpCode>(getOpCode()));

    str += enum_name(tptrait);

    str += enum_name(getCondCodeFlag()); ///

    str += enum_name(dataTypes) + ' ';

    /// Neon指令没有S标记

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
#endif