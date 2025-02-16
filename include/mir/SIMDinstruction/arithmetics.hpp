#include "../instruction.hpp"

using namespace MIR;

class Vbinary : public NeonInstruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<BindOnVirOP> SourceOperand_2;

public:
    Vbinary() = delete;
    Vbinary(NeonOpCode _opcode, std::shared_ptr<BindOnVirOP> TargetOperand_,
            std::shared_ptr<BindOnVirOP> SourceOperand_1_,
            std::shared_ptr<BindOnVirOP> SourceOperand_2_,
            std::pair<bitType, bitType> _dataTypes)
        : NeonInstruction(_opcode, SourceOperandType::rr, _dataTypes),
          SourceOperand_1(std::move(SourceOperand_1_)),
          SourceOperand_2(std::move(SourceOperand_2_)) {
        addTargetOP(std::move(TargetOperand_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    ~Vbinary() override = default;
};

class Vunary : public NeonInstruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;

public:
    Vunary() = delete;
    Vunary(NeonOpCode _opcode, std::shared_ptr<BindOnVirOP> TargetOperand_,
           std::shared_ptr<BindOnVirOP> SourceOperand_1_,
           std::pair<bitType, bitType> _dataTypes)
        : NeonInstruction(_opcode, SourceOperandType::r, _dataTypes),
          SourceOperand_1(std::move(SourceOperand_1_)) {
        addTargetOP(std::move(TargetOperand_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    ~Vunary() override = default;
};

class Vcmp : public NeonInstruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<BindOnVirOP> SourceOperand_2;

public:
    Vcmp() = delete;
    Vcmp(NeonOpCode _opcode, std::shared_ptr<BindOnVirOP> SourceOperand_1_,
         std::shared_ptr<BindOnVirOP> SourceOperand_2_,
         std::pair<bitType, bitType> _dataTypes)
        : NeonInstruction(_opcode, SourceOperandType::rr, _dataTypes),
          SourceOperand_1(std::move(SourceOperand_1_)),
          SourceOperand_2(std::move(SourceOperand_2_)) {}

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    ~Vcmp() override = default;
};

class Vmrs : public Instruction {
private:
public:
    Vmrs() = delete;
    Vmrs() : Instruction(NeonOpCode::VMRS, SourceOperandType::cp) {}

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override {
        return nullptr;
    }

    std::string toString() override { return "vmrs APSR_nzcv, FPSCR"; }
    ~Vmrs() override = default;
};