#include "../../../include/mir/SIMDinstruction/arithmetics.hpp"

using namespace MIR;

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
        Err::gassert(ptr_new_reg != nullptr && ptr_new_reg->getBank() != RegisterBank::gpr, "set a sourceoperand failed");
        SourceOperand_1 = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
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
        Err::gassert(ptr_new_reg != nullptr && ptr_new_reg->getBank() != RegisterBank::gpr, "set a sourceoperand failed");
        SourceOperand_1 = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

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
        Err::gassert(ptr_new_reg != nullptr && ptr_new_reg->getBank() != RegisterBank::gpr, "set a sourceoperand failed");
        SourceOperand_1 = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}