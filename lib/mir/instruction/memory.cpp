#include "../../../include/mir/instructions/memory.hpp"

using namespace MIR;

std::shared_ptr<Operand> movInst::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand;
    else
        return nullptr;
}

void movInst::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1) {
        SourceOperand = ptr_new;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

std::shared_ptr<Operand> strInst::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return SourceOperand;
    } else if (seq == 2) {
        return MemoryAddr;
    } else if (seq == 3) {
        return IndexReg;
    } else {
        return nullptr;
    }
}

void strInst::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        Err::gassert(ptr_new_reg != nullptr, "set a sourceoperand failed");
        SourceOperand = ptr_new_reg;
    } else if (seq == 2) {
        auto ptr_new_base = std::dynamic_pointer_cast<BaseADROP>(ptr_new);
        Err::gassert(ptr_new_base != nullptr, "set a sourceoperand failed");
        MemoryAddr = ptr_new_base;
    } else if (seq == 3) { // index
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        Err::gassert(ptr_new_reg != nullptr, "set a sourceoperand failed");
        IndexReg = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

std::shared_ptr<Operand> ldrInst::getSourceOP(unsigned int seq) {
    if (seq == 1) {
        return MemoryAddr;
    } else if (seq == 2) {
        return IndexReg;
    } else {
        return nullptr;
    }
}

void ldrInst::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1) {
        auto ptr_new_base = std::dynamic_pointer_cast<BaseADROP>(ptr_new);
        Err::gassert(ptr_new_base != nullptr, "set a sourceoperand failed");
        MemoryAddr = ptr_new_base;
    } else if (seq == 2) { // index
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        Err::gassert(ptr_new_reg != nullptr, "set a sourceoperand failed");
        IndexReg = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}