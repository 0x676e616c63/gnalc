#pragma once
#ifndef GNALC_MIR_BRANCH_HPP
#define GNALC_MIR_BRANCH_HPP

#include "../../ir/basic_block.hpp"
#include "../../ir/function.hpp"
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

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override = 0;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override = 0;

    auto getDest() { return Dest; }
    bool isJmpToBlock() { return Dest.index() == 0; }
    bool isJmpToFunc() { return Dest.index() == 1; }

    std::string toString() override;
    ~branchInst() override = default;
};

class RET : public Instruction {
public:
    RET() : Instruction(OpCode::RET, SourceOperandType::cp) {}

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override = 0;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override = 0;

    std::string toString() override { return "RET"; }
    ~RET() override = default;
};

} // namespace MIR

#endif