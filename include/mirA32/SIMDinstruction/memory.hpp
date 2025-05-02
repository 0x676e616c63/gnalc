#pragma once
#ifndef GNALC_MIR_SIMDINSTRUCTION_MEMORY_HPP
#define GNALC_MIR_SIMDINSTRUCTION_MEMORY_HPP

#include "mirA32/instruction.hpp"
#include <utility>

using namespace MIR;

class Vmov : public NeonInstruction {
private:
    std::shared_ptr<Operand> SourceOperand_1;

public:
    Vmov() = delete;
    Vmov(SourceOperandType _type, std::shared_ptr<BindOnVirOP> TargetOP_, std::shared_ptr<Operand> SourceOperand_1_,
         std::pair<bitType, bitType> _dataTypes);

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;
    ~Vmov() override = default;
};

class Vldr : public NeonInstruction {
private:
    std::shared_ptr<BaseADROP> SourceOperand_1;
    std::shared_ptr<BindOnVirOP> indexRegister = nullptr;

public:
    Vldr() = delete;
    Vldr(std::shared_ptr<BindOnVirOP> TargetOP_, std::shared_ptr<BaseADROP> SourceOperand_1_,
         std::pair<bitType, bitType> _dataTypes);

    void setBaseReg(std::shared_ptr<BaseADROP> _ptr);
    void setIndexReg(std::shared_ptr<BindOnVirOP> _ptr);

    std::shared_ptr<BaseADROP> getBase() const;

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    ~Vldr() override = default;
};

class Vstr : public NeonInstruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<BaseADROP> SourceOperand_2;
    std::shared_ptr<BindOnVirOP> indexRegister = nullptr;

public:
    Vstr() = delete;
    Vstr(std::shared_ptr<BindOnVirOP> SourceOperand_1_, std::shared_ptr<BaseADROP> SourceOperand_2_,
         std::pair<bitType, bitType> _dataTypes);

    void setBaseReg(const std::shared_ptr<BaseADROP> _ptr);

    void setIndexReg(std::shared_ptr<BindOnVirOP> _ptr);

    std::shared_ptr<BaseADROP> getBase() const;

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    ~Vstr() override = default;
};
#endif