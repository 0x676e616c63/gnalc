#include <utility>

#include "../instruction.hpp"

namespace MIR {

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
    bool Check() override;
    std::string toString() override;
    ~binaryInst() override = default;
};

class binaryImmInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<Operand> SourceOperand_2; // BindOnVirOP, ConstIDX, ShiftOP
public:
    binaryImmInst() = delete;
    binaryImmInst(OpCode _binaryOpCode, SourceOperandType _tptrait,
                  std::shared_ptr<BindOnVirOP> TargetOperand_,
                  std::shared_ptr<BindOnVirOP> SourceOperand_1_,
                  std::shared_ptr<Operand> SourceOperand_2_)
        : Instruction(_binaryOpCode, _tptrait),
          SourceOperand_1(std::move(SourceOperand_1_)),
          SourceOperand_2(std::move(SourceOperand_2_)) {
        addTargetOP(std::move(TargetOperand_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    bool Check() override;
    std::string toString() override;
    ~binaryImmInst() override = default;
};

class compareInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<BindOnVirOP> SourceOperand_2;

public:
    compareInst(OpCode _cmpOpCode,
                std::shared_ptr<BindOnVirOP> SourceOperand_1_,
                std::shared_ptr<BindOnVirOP> SourceOperand_2_)
        : Instruction(_cmpOpCode, SourceOperandType::rr),
          SourceOperand_1(std::move(SourceOperand_1_)),
          SourceOperand_2(std::move(SourceOperand_2_)) {
        addTargetOP(nullptr);
    };
    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    bool Check() override;
    std::string toString() override;
    ~compareInst() override = default;
};

} // namespace MIR