#include <utility>

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

class PhiOper {
public:
    const std::shared_ptr<Operand> val;
    const std::string pre; // isel中简单处理
    PhiOper() = delete;
    PhiOper(std::shared_ptr<Operand> _val, std::string _pre) : val(std::move(_val)), pre(std::move(_pre)) {}

    ~PhiOper() = default;
};

class PHI : public Instruction {
private:
    std::vector<PhiOper> SourceOperands;

public:
    PHI() = delete;
    PHI(std::shared_ptr<BindOnVirOP> TargetOP_, std::vector<PhiOper> _list) : SourceOperands(std::move(_list)), Instruction(OpCode::PHI, SourceOperandType::rr) { addTargetOP(std::move(TargetOP_)); }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    std::string toString() override;
    ~PHI() override = default;
};
} // namespace MIR