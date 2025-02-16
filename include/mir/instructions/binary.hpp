#pragma once
#ifndef GNALC_MIR_BINARY_HPP
#define GNALC_MIR_BINARY_HPP

#include "../instruction.hpp"
#include <utility>

namespace MIR {

class unaryInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;

public:
    unaryInst() = delete;
    unaryInst(OpCode _unaryOpCode, SourceOperandType _tptrait,
              std::shared_ptr<BindOnVirOP> TargetOperand_,
              std::shared_ptr<BindOnVirOP> SourceOperand_1_)
        : Instruction(_unaryOpCode, _tptrait),
          SourceOperand_1(std::move(SourceOperand_1_)) {
        addTargetOP(std::move(TargetOperand_));
    }
    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    ~unaryInst() override = default;
};

class binaryInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<BindOnVirOP> SourceOperand_2;

public:
    binaryInst() = delete;
    binaryInst(OpCode _binaryOpCode, SourceOperandType _tptrait,
               std::shared_ptr<BindOnVirOP> TargetOperand_,
               std::shared_ptr<BindOnVirOP> SourceOperand_1_,
               std::shared_ptr<BindOnVirOP> SourceOperand_2_)
        : Instruction(_binaryOpCode, _tptrait),
          SourceOperand_1(std::move(SourceOperand_1_)),
          SourceOperand_2(std::move(SourceOperand_2_)) {
        addTargetOP(std::move(TargetOperand_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    // std::string toString() override;
    ~binaryInst() override = default;
};

class ternaryInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<BindOnVirOP> SourceOperand_2;
    std::shared_ptr<BindOnVirOP> SourceOperand_3;

public:
    ternaryInst() = delete;
    ternaryInst(OpCode _ternaryOpCode, SourceOperandType _tptrait,
                std::shared_ptr<BindOnVirOP> TargetOperand_,
                std::shared_ptr<BindOnVirOP> SourceOperand_1_,
                std::shared_ptr<BindOnVirOP> SourceOperand_2_,
                std::shared_ptr<BindOnVirOP> SourceOperand_3_)
        : Instruction(_ternaryOpCode, _tptrait),
          SourceOperand_1(std::move(SourceOperand_1_)),
          SourceOperand_2(std::move(SourceOperand_2_)),
          SourceOperand_3(std::move(SourceOperand_3_)) {
        addTargetOP(std::move(TargetOperand_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    ~ternaryInst() override = default;
};

class binaryImmInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<Operand> SourceOperand_2; // BindOnVirOP, ConstIDX
    std::shared_ptr<ShiftOP> SourceOperand_3;

public:
    binaryImmInst() = delete;
    binaryImmInst(OpCode _binaryOpCode, SourceOperandType _tptrait,
                  std::shared_ptr<BindOnVirOP> TargetOperand_,
                  std::shared_ptr<BindOnVirOP> SourceOperand_1_,
                  std::shared_ptr<Operand> SourceOperand_2_,
                  std::shared_ptr<ShiftOP> SourceOperand_3_)
        : Instruction(_binaryOpCode, _tptrait),
          SourceOperand_1(std::move(SourceOperand_1_)),
          SourceOperand_2(std::move(SourceOperand_2_)),
          SourceOperand_3(std::move(SourceOperand_3_)) {
        addTargetOP(std::move(TargetOperand_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    ~binaryImmInst() override = default;
};

class compareInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<Operand> SourceOperand_2;

public:
    compareInst() = delete;
    compareInst(OpCode _cmpOpCode, SourceOperandType _tptrait,
                std::shared_ptr<BindOnVirOP> SourceOperand_1_,
                std::shared_ptr<Operand> SourceOperand_2_)
        : Instruction(_cmpOpCode, _tptrait),
          SourceOperand_1(std::move(SourceOperand_1_)),
          SourceOperand_2(std::move(SourceOperand_2_)) {
        addTargetOP(nullptr);
        setFlash();
    };

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    ~compareInst() override = default;
};

} // namespace MIR

#endif