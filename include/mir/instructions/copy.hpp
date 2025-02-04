#include "../../ir/instructions/phi.hpp"
#include "../instruction.hpp"

namespace MIR {
class copyInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand;

public:
    copyInst() = delete;
    copyInst(std::shared_ptr<BindOnVirOP> TargetOP_,
             std::shared_ptr<BindOnVirOP> SourceOperand_)
        : Instruction(OpCode::COPY, SourceOperandType::r),
          SourceOperand(std::move(SourceOperand_)) {
        addTargetOP(std::move(TargetOP_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    bool Check() override;
    // std::string toString() override;
    ~copyInst() override = default;
};
} // namespace MIR