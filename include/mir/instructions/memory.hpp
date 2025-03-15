#pragma once
#ifndef GNALC_MIR_MEMORY_HPP
#define GNALC_MIR_MEMORY_HPP

#include "../instruction.hpp"
#include <utility>

namespace MIR {

class movInst : public Instruction {
private:
    std::shared_ptr<Operand> SourceOperand; // ConstPoolValue, BindOnVirRegister
public:
    movInst() = delete;
    movInst(SourceOperandType _tptrait, std::shared_ptr<BindOnVirOP> TargetOP_,
            std::shared_ptr<Operand> SourceOperand_)
        : Instruction(OpCode::MOV, _tptrait),
          SourceOperand(std::move(SourceOperand_)) {
        addTargetOP(std::move(TargetOP_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    ~movInst() override = default;
};

class strInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand;
    std::shared_ptr<BaseADROP> MemoryAddr;           // base register
    std::shared_ptr<BindOnVirOP> IndexReg = nullptr; // 变址寄存器, 用于常数偏移巨大时
    unsigned int size;                               // 8, 4, 2, 1

public:
    strInst() = delete;
    strInst(SourceOperandType _tptrait, unsigned int _size,
            std::shared_ptr<BindOnVirOP> SourceOperand_,
            std::shared_ptr<BaseADROP> MemoryAddr_)
        : Instruction(OpCode::STR, _tptrait),
          SourceOperand(std::move(SourceOperand_)),
          MemoryAddr(std::move(MemoryAddr_)), size(_size) {
        addTargetOP(nullptr);
    }

    strInst(SourceOperandType _tptrait, unsigned int _size,
            std::shared_ptr<BindOnVirOP> SourceOperand_,
            std::shared_ptr<BaseADROP> MemoryAddr_, std::shared_ptr<BindOnVirOP> IndexReg_)
        : Instruction(OpCode::STR, _tptrait),
          SourceOperand(std::move(SourceOperand_)),
          MemoryAddr(std::move(MemoryAddr_)),
          IndexReg(std::move(IndexReg_)), size(_size) {
        addTargetOP(nullptr);
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    void setBaseReg(std::shared_ptr<BaseADROP> _ptr) { MemoryAddr = std::move(_ptr); }

    void setIndexReg(std::shared_ptr<BindOnVirOP> _ptr) { IndexReg = std::move(_ptr); }

    ~strInst() override = default;
};

class ldrInst : public Instruction {
private:
    std::shared_ptr<BaseADROP> MemoryAddr;
    std::shared_ptr<BindOnVirOP> IndexReg = nullptr; // 变址寄存器, 用于常数偏移巨大时
    unsigned int size;                               // 8, 4, 2, 1

public:
    ldrInst() = delete;
    ldrInst(SourceOperandType _tptrait, unsigned int _size,
            std::shared_ptr<BindOnVirOP> TargetOP_,
            std::shared_ptr<BaseADROP> MemoryAddr_)
        : Instruction(OpCode::LDR, _tptrait),
          MemoryAddr(std::move(MemoryAddr_)), size(_size) {
        addTargetOP(std::move(TargetOP_));
    }

    ldrInst(SourceOperandType _tptrait, unsigned int _size,
            std::shared_ptr<BindOnVirOP> TargetOP_,
            std::shared_ptr<BaseADROP> MemoryAddr_, std::shared_ptr<BindOnVirOP> IndexReg_)
        : Instruction(OpCode::LDR, _tptrait),
          MemoryAddr(std::move(MemoryAddr_)), IndexReg(std::move(IndexReg_)), size(_size) {
        addTargetOP(std::move(TargetOP_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    void setBaseReg(std::shared_ptr<BaseADROP> _ptr) { MemoryAddr = std::move(_ptr); }

    void setIndexReg(std::shared_ptr<BindOnVirOP> _ptr) { IndexReg = std::move(_ptr); }

    ~ldrInst() override = default;
};

} // namespace MIR

#endif