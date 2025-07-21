// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#include "../../../include/legacy_mir/instructions/memory.hpp"

using namespace LegacyMIR;

movInst::movInst(SourceOperandType _tptrait, std::shared_ptr<BindOnVirOP> TargetOP_,
                 std::shared_ptr<Operand> SourceOperand_)
    : Instruction(OpCode::MOV, _tptrait), SourceOperand(std::move(SourceOperand_)) {
    addTargetOP(std::move(TargetOP_));
}

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

strInst::strInst(SourceOperandType _tptrait, unsigned int _size, std::shared_ptr<BindOnVirOP> SourceOperand_,
                 std::shared_ptr<BaseADROP> MemoryAddr_)
    : Instruction(OpCode::STR, _tptrait), SourceOperand(std::move(SourceOperand_)), MemoryAddr(std::move(MemoryAddr_)),
      size(_size) {
    addTargetOP(nullptr);
}

strInst::strInst(SourceOperandType _tptrait, unsigned int _size, std::shared_ptr<BindOnVirOP> SourceOperand_,
                 std::shared_ptr<BaseADROP> MemoryAddr_, std::shared_ptr<BindOnVirOP> IndexReg_)
    : Instruction(OpCode::STR, _tptrait), SourceOperand(std::move(SourceOperand_)), MemoryAddr(std::move(MemoryAddr_)),
      IndexReg(std::move(IndexReg_)), size(_size) {
    addTargetOP(nullptr);
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

void strInst::setBaseReg(std::shared_ptr<BaseADROP> _ptr) { MemoryAddr = std::move(_ptr); }

std::shared_ptr<BaseADROP> strInst::getBase() const { return MemoryAddr; }

void strInst::setIndexReg(std::shared_ptr<BindOnVirOP> _ptr) { IndexReg = std::move(_ptr); }

ldrInst::ldrInst(SourceOperandType _tptrait, unsigned int _size, std::shared_ptr<BindOnVirOP> TargetOP_,
                 std::shared_ptr<BaseADROP> MemoryAddr_)
    : Instruction(OpCode::LDR, _tptrait), MemoryAddr(std::move(MemoryAddr_)), size(_size) {
    addTargetOP(std::move(TargetOP_));
}

ldrInst::ldrInst(SourceOperandType _tptrait, unsigned int _size, std::shared_ptr<BindOnVirOP> TargetOP_,
                 std::shared_ptr<BaseADROP> MemoryAddr_, std::shared_ptr<BindOnVirOP> IndexReg_)
    : Instruction(OpCode::LDR, _tptrait), MemoryAddr(std::move(MemoryAddr_)), IndexReg(std::move(IndexReg_)),
      size(_size) {
    addTargetOP(std::move(TargetOP_));
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

void ldrInst::setBaseReg(std::shared_ptr<BaseADROP> _ptr) { MemoryAddr = std::move(_ptr); }

std::shared_ptr<BaseADROP> ldrInst::getBase() const { return MemoryAddr; }

void ldrInst::setIndexReg(std::shared_ptr<BindOnVirOP> _ptr) { IndexReg = std::move(_ptr); }
#endif