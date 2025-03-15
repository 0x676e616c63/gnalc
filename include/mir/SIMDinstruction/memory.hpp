#include <utility>

#include "../instruction.hpp"

using namespace MIR;

class Vmov : public NeonInstruction {
private:
    std::shared_ptr<Operand> SourceOperand_1;

public:
    Vmov() = delete;
    Vmov(SourceOperandType _type, std::shared_ptr<BindOnVirOP> TargetOP_,
         std::shared_ptr<Operand> SourceOperand_1_,
         std::pair<bitType, bitType> _dataTypes)
        : NeonInstruction(NeonOpCode::VMOV, _type, _dataTypes),
          SourceOperand_1(std::move(SourceOperand_1_)) {
        addTargetOP(std::move(TargetOP_));
    }

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
    Vldr(std::shared_ptr<BindOnVirOP> TargetOP_,
         std::shared_ptr<BaseADROP> SourceOperand_1_,
         std::pair<bitType, bitType> _dataTypes)
        : NeonInstruction(NeonOpCode::VLDR, SourceOperandType::a, _dataTypes),
          SourceOperand_1(std::move(SourceOperand_1_)) {
        addTargetOP(std::move(TargetOP_));
    }
    void setBaseReg(std::shared_ptr<BaseADROP> _ptr) { SourceOperand_1 = std::move(_ptr); }

    void setIndexReg(std::shared_ptr<BindOnVirOP> _ptr) { indexRegister = std::move(_ptr); }

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
    Vstr(std::shared_ptr<BindOnVirOP> SourceOperand_1_,
         std::shared_ptr<BaseADROP> SourceOperand_2_,
         std::pair<bitType, bitType> _dataTypes)
        : NeonInstruction(NeonOpCode::VSTR, SourceOperandType::ra, _dataTypes),
          SourceOperand_1(std::move(SourceOperand_1_)),
          SourceOperand_2(std::move(SourceOperand_2_)) {}

    void setBaseReg(const std::shared_ptr<BaseADROP> _ptr) { SourceOperand_1 = _ptr; }

    void setIndexReg(std::shared_ptr<BindOnVirOP> _ptr) { indexRegister = std::move(_ptr); }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    ~Vstr() override = default;
};