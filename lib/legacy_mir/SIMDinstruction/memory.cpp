// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#include "legacy_mir/SIMDinstruction/memory.hpp"

using namespace LegacyMIR;

Vmov::Vmov(SourceOperandType _type, std::shared_ptr<BindOnVirOP> TargetOP_, std::shared_ptr<Operand> SourceOperand_1_,
           std::pair<bitType, bitType> _dataTypes)
    : NeonInstruction(NeonOpCode::VMOV, _type, _dataTypes), SourceOperand_1(std::move(SourceOperand_1_)) {
    addTargetOP(std::move(TargetOP_));
}

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

Vldr::Vldr(std::shared_ptr<BindOnVirOP> TargetOP_, std::shared_ptr<BaseADROP> SourceOperand_1_,
           std::pair<bitType, bitType> _dataTypes)
    : NeonInstruction(NeonOpCode::VLDR, SourceOperandType::a, _dataTypes),
      SourceOperand_1(std::move(SourceOperand_1_)) {
    addTargetOP(std::move(TargetOP_));
}

void Vldr::setBaseReg(std::shared_ptr<BaseADROP> _ptr) { SourceOperand_1 = std::move(_ptr); }

void Vldr::setIndexReg(std::shared_ptr<BindOnVirOP> _ptr) { indexRegister = std::move(_ptr); }

std::shared_ptr<BaseADROP> Vldr::getBase() const { return SourceOperand_1; };

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

Vstr::Vstr(std::shared_ptr<BindOnVirOP> SourceOperand_1_, std::shared_ptr<BaseADROP> SourceOperand_2_,
           std::pair<bitType, bitType> _dataTypes)
    : NeonInstruction(NeonOpCode::VSTR, SourceOperandType::ra, _dataTypes),
      SourceOperand_1(std::move(SourceOperand_1_)), SourceOperand_2(std::move(SourceOperand_2_)) {}

void Vstr::setBaseReg(const std::shared_ptr<BaseADROP> _ptr) { SourceOperand_1 = _ptr; }

void Vstr::setIndexReg(std::shared_ptr<BindOnVirOP> _ptr) { indexRegister = std::move(_ptr); }

std::shared_ptr<BaseADROP> Vstr::getBase() const { return SourceOperand_2; };

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
#endif