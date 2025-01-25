#include "../instruction.hpp"

namespace MIR {
class copy : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand;

public:
    copy() = delete;
    copy(std::shared_ptr<BindOnVirOP> TargetOP_,
         std::shared_ptr<BindOnVirOP> SourceOperand_)
        : Instruction(OpCode::COPY, SourceOperandType::r),
          SourceOperand(std::move(SourceOperand_)) {
        addTargetOP(std::move(TargetOP_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    std::string toString() override;
    ~copy() override = default;
};
} // namespace MIR