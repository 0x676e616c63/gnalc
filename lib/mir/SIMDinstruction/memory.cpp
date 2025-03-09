#include "../../../include/mir/SIMDinstruction/memory.hpp"

using namespace MIR;

std::shared_ptr<Operand> Vmov::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand_1;
    } else {
        return nullptr;
    }
}

void Vmov::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        Err::gassert(ptr_new_reg != nullptr, "set a sourceoperand failed");
        SourceOperand_1 = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

std::shared_ptr<Operand> Vldr::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand_1;
    } else if (seq == 2) {
        return indexRegister;
    } else {
        return nullptr;
    }
}

void Vldr::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1) {
        auto ptr_new_base = std::dynamic_pointer_cast<BaseADROP>(ptr_new);
        Err::gassert(ptr_new_base != nullptr, "set a sourceoperand failed");
        SourceOperand_1 = ptr_new_base;
    } else if (seq == 2) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        Err::gassert(ptr_new_reg != nullptr, "set a sourceoperand failed");
        indexRegister = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

std::shared_ptr<Operand> Vstr::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand_1;
    } else if (seq == 2) {
        return SourceOperand_2;
    } else if (seq == 3) {
        return indexRegister;
    } else {
        return nullptr;
    }
}

void Vstr::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        Err::gassert(ptr_new_reg != nullptr, "set a sourceoperand failed");
        SourceOperand_1 = ptr_new_reg;
    } else if (seq == 2) {
        auto ptr_new_base = std::dynamic_pointer_cast<BaseADROP>(ptr_new);
        Err::gassert(ptr_new_base != nullptr, "set a sourceoperand failed");
        SourceOperand_2 = ptr_new_base;
    } else if (seq == 3) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        Err::gassert(ptr_new_reg != nullptr, "set a sourceoperand failed");
        indexRegister = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}
