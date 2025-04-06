#include "../../../include/mir/SIMDinstruction/arithmetics.hpp"

using namespace MIR;

Vbinary::Vbinary(NeonOpCode _opcode, std::shared_ptr<BindOnVirOP> TargetOperand_,
                 std::shared_ptr<BindOnVirOP> SourceOperand_1_, std::shared_ptr<BindOnVirOP> SourceOperand_2_,
                 std::pair<bitType, bitType> _dataTypes)
    : NeonInstruction(_opcode, SourceOperandType::rr, _dataTypes), SourceOperand_1(std::move(SourceOperand_1_)),
      SourceOperand_2(std::move(SourceOperand_2_)) {
    addTargetOP(std::move(TargetOperand_));
}

std::shared_ptr<Operand> Vbinary::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand_1;
    } else if (seq == 2) {
        return SourceOperand_2;
    } else {
        return nullptr;
    }
}

void Vbinary::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1 || seq == 2) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        Err::gassert(ptr_new_reg != nullptr && ptr_new_reg->getBank() != RegisterBank::gpr,
                     "set a sourceoperand failed");
        SourceOperand_1 = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

Vunary::Vunary(NeonOpCode _opcode, std::shared_ptr<BindOnVirOP> TargetOperand_,
               std::shared_ptr<BindOnVirOP> SourceOperand_1_, std::pair<bitType, bitType> _dataTypes)
    : NeonInstruction(_opcode, SourceOperandType::r, _dataTypes), SourceOperand_1(std::move(SourceOperand_1_)) {
    addTargetOP(std::move(TargetOperand_));
}

std::shared_ptr<Operand> Vunary::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand_1;
    } else {
        return nullptr;
    }
}

void Vunary::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        Err::gassert(ptr_new_reg != nullptr && ptr_new_reg->getBank() != RegisterBank::gpr,
                     "set a sourceoperand failed");
        SourceOperand_1 = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

Vcmp::Vcmp(NeonOpCode _opcode, std::shared_ptr<BindOnVirOP> SourceOperand_1_,
           std::shared_ptr<BindOnVirOP> SourceOperand_2_, std::pair<bitType, bitType> _dataTypes)
    : NeonInstruction(_opcode, SourceOperandType::rr, _dataTypes), SourceOperand_1(std::move(SourceOperand_1_)),
      SourceOperand_2(std::move(SourceOperand_2_)) {}

std::shared_ptr<Operand> Vcmp::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand_1;
    } else if (seq == 2) {
        return SourceOperand_2;
    } else {
        return nullptr;
    }
}

void Vcmp::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1 || seq == 2) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        Err::gassert(ptr_new_reg != nullptr && ptr_new_reg->getBank() != RegisterBank::gpr,
                     "set a sourceoperand failed");
        SourceOperand_1 = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

Vmrs::Vmrs()
    : NeonInstruction(NeonOpCode::VMRS, SourceOperandType::cp, std::make_pair(bitType::DEFAULT32, bitType::DEFAULT32)) {
}

std::shared_ptr<Operand> Vmrs::getSourceOP(unsigned int seq) { return nullptr; }

void Vmrs::setSourceOP(unsigned int seq, std::shared_ptr<Operand>) {}

std::string Vmrs::toString() { return "vmrs APSR_nzcv, FPSCR"; }