#include <utility>

#include "../instruction.hpp"

using namespace MIR;

class Binary_imme : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand_1;
    std::shared_ptr<Operand> SourceOperand_2; // BindOnVirOP, ConstIDX, ShiftOP
public:
    Binary_imme() = delete;
    Binary_imme(OpCode _binaryOpCode, SourceOperandType _tptrait,
                std::shared_ptr<Operand> TargetOperand_,
                std::shared_ptr<BindOnVirOP> SourceOperand_1_,
                std::shared_ptr<Operand> SourceOperand_2_)
        : Instruction(_binaryOpCode, _tptrait),
          SourceOperand_1(std::move(SourceOperand_1_)),
          SourceOperand_2(std::move(SourceOperand_2_)) {
        addTargetOP(TargetOperand_);
    }
    // to be continued
};
