#include "../instruction.hpp"

using namespace MIR;

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

class Vmrs : public Instruction {
private:
public:
    Vmrs();

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;

    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    std::string toString() override;
    ~Vmrs() override = default;
};