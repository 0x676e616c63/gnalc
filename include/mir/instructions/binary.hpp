#pragma once
#ifndef GNALC_MIR_INSTRUCTIONS_BINARY_HPP
#define GNALC_MIR_INSTRUCTIONS_BINARY_HPP

#include "mir/instruction.hpp"

namespace MIR {

class unaryInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;

public:
    unaryInst() = delete;
    unaryInst(OpCode _unaryOpCode, SourceOperandType _tptrait, std::shared_ptr<BindOnVirOP> TargetOperand_,
              std::shared_ptr<BindOnVirOP> SourceOperand_1_);

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    ~unaryInst() override = default;
};

class binaryInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<BindOnVirOP> SourceOperand_2;

public:
    binaryInst() = delete;
    binaryInst(OpCode _binaryOpCode, SourceOperandType _tptrait, std::shared_ptr<BindOnVirOP> TargetOperand_,
               std::shared_ptr<BindOnVirOP> SourceOperand_1_, std::shared_ptr<BindOnVirOP> SourceOperand_2_);

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    ~binaryInst() override = default;
};

class ternaryInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<BindOnVirOP> SourceOperand_2;
    std::shared_ptr<BindOnVirOP> SourceOperand_3;

public:
    ternaryInst() = delete;
    ternaryInst(OpCode _ternaryOpCode, SourceOperandType _tptrait, std::shared_ptr<BindOnVirOP> TargetOperand_,
                std::shared_ptr<BindOnVirOP> SourceOperand_1_, std::shared_ptr<BindOnVirOP> SourceOperand_2_,
                std::shared_ptr<BindOnVirOP> SourceOperand_3_);

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    ~ternaryInst() override = default;
};

class binaryImmInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<Operand> SourceOperand_2; // BindOnVirOP, ConstIDX
    std::shared_ptr<ShiftOP> SourceOperand_3;

public:
    binaryImmInst() = delete;
    binaryImmInst(OpCode _binaryOpCode, SourceOperandType _tptrait, std::shared_ptr<BindOnVirOP> TargetOperand_,
                  std::shared_ptr<BindOnVirOP> SourceOperand_1_, std::shared_ptr<Operand> SourceOperand_2_,
                  std::shared_ptr<ShiftOP> SourceOperand_3_);

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    ~binaryImmInst() override = default;
};

class compareInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<Operand> SourceOperand_2;

public:
    compareInst() = delete;
    compareInst(OpCode _cmpOpCode, SourceOperandType _tptrait, std::shared_ptr<BindOnVirOP> SourceOperand_1_,
                std::shared_ptr<Operand> SourceOperand_2_);

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    ~compareInst() override = default;
};

} // namespace MIR

#endif