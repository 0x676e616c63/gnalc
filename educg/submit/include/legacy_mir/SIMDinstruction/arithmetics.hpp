// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_SIMDINSTRUCTION_ARITHMETICS_HPP
#define GNALC_LEGACY_MIR_SIMDINSTRUCTION_ARITHMETICS_HPP

#include "../instruction.hpp"

using namespace LegacyMIR;

class Vbinary : public NeonInstruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<BindOnVirOP> SourceOperand_2;

public:
    Vbinary() = delete;
    Vbinary(NeonOpCode _opcode, std::shared_ptr<BindOnVirOP> TargetOperand_,
            std::shared_ptr<BindOnVirOP> SourceOperand_1_, std::shared_ptr<BindOnVirOP> SourceOperand_2_,
            std::pair<bitType, bitType> _dataTypes);

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    ~Vbinary() override = default;
};

class Vunary : public NeonInstruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;

public:
    Vunary() = delete;
    Vunary(NeonOpCode _opcode, std::shared_ptr<BindOnVirOP> TargetOperand_,
           std::shared_ptr<BindOnVirOP> SourceOperand_1_, std::pair<bitType, bitType> _dataTypes);

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    ~Vunary() override = default;
};

class Vcmp : public NeonInstruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<BindOnVirOP> SourceOperand_2;

public:
    Vcmp() = delete;
    Vcmp(NeonOpCode _opcode, std::shared_ptr<BindOnVirOP> SourceOperand_1_,
         std::shared_ptr<BindOnVirOP> SourceOperand_2_, std::pair<bitType, bitType> _dataTypes);

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    ~Vcmp() override = default;
};

class Vmrs : public NeonInstruction {
private:
public:
    Vmrs();

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;

    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    std::string toString() override;
    ~Vmrs() override = default;
};
#endif
#endif