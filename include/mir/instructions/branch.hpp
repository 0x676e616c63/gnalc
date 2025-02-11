#include "../basicblock.hpp"
#include "../function.hpp"
#include "../instruction.hpp"
#include <utility>

namespace MIR {
class branchInst : public Instruction {
private:
    std::variant<std::shared_ptr<IR::BasicBlock>,
                 std::shared_ptr<IR::FunctionDecl>>
        Dest; // 为PhiEliminate准备
    std::string JmpTo;

public:
    branchInst() = delete;
    branchInst(OpCode JmpCode_, std::shared_ptr<IR::BasicBlock> Dest_,
               std::string JmpTo_)
        : Instruction(JmpCode_, SourceOperandType::cp), Dest(std::move(Dest_)),
          JmpTo(std::move(JmpTo_)) {}
    branchInst(OpCode JmpCode_, std::shared_ptr<IR::FunctionDecl> Dest_,
               std::string JmpTo_)
        : Instruction(JmpCode_, SourceOperandType::cp), Dest(std::move(Dest_)),
          JmpTo(std::move(JmpTo_)) {}

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override {
        return nullptr;
    };
    auto getDest() { return Dest; }

    // std::string toString() override;
    ~branchInst() override = default;
};
} // namespace MIR