#include "../basicblock.hpp"
#include "../function.hpp"
#include "../instruction.hpp"
#include <utility>

namespace MIR {
class branchInst : public Instruction {
private:
    std::variant<std::weak_ptr<Function>, std::weak_ptr<BasicBlock>> JmpTo; //

public:
    branchInst() = delete;
    branchInst(OpCode JmpCode_, std::weak_ptr<BasicBlock> JmpTo_)
        : Instruction(JmpCode_, SourceOperandType::cp),
          JmpTo(std::move(JmpTo_)) {}
    branchInst(OpCode JmpCode_, const std::weak_ptr<BasicBlock> &JmpTo_,
               std::shared_ptr<BindOnVirOP> retVal_)
        : Instruction(JmpCode_, SourceOperandType::cp) {
        addTargetOP(std::move(retVal_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override = 0;

    bool Check() override;
    // std::string toString() override;
    ~branchInst() override = default;
};
} // namespace MIR