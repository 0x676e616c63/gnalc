#include "../../ir/instructions/phi.hpp"
#include "../instruction.hpp"

namespace MIR {
/// @brief 用于将后端中一些隐式的值传递显示表达出来, 比如参数传递, 函数返回值
/// @brief 以及在寄存器分配中, 表示出寄存器占用
class COPY : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand;

public:
    COPY() = delete;
    COPY(std::shared_ptr<BindOnVirOP> TargetOP_,
         std::shared_ptr<BindOnVirOP> SourceOperand_)
        : Instruction(OpCode::COPY, SourceOperandType::r),
          SourceOperand(std::move(SourceOperand_)) {
        addTargetOP(std::move(TargetOP_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    // std::string toString() override;
    ~COPY() override = default;
};
} // namespace MIR