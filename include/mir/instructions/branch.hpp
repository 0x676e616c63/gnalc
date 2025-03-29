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
                 std::shared_ptr<IR::FunctionDecl>> Dest; // 为PhiEliminate准备
    std::string JmpTo;                                    // with @ or %
    unsigned RetValType;                                  // only BL or BLX: 0(void), 1(int), 2(float)

public:
    branchInst() = delete;
    branchInst(OpCode JmpCode_, std::shared_ptr<IR::BasicBlock> Dest_, std::string JmpTo_)
        : Instruction(JmpCode_, SourceOperandType::cp), Dest(std::move(Dest_)), JmpTo(std::move(JmpTo_)) {}
    branchInst(OpCode JmpCode_, std::shared_ptr<IR::FunctionDecl> Dest_, std::string JmpTo_, unsigned int _RetValType)
        : Instruction(JmpCode_, SourceOperandType::cp), Dest(std::move(Dest_)), JmpTo(std::move(JmpTo_)),
          RetValType(_RetValType) {}

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override { return nullptr; }
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override {}

    auto getDest() { return Dest; }
    auto getJmpTo() { return JmpTo; }
    void changeJmpTo(std::string _newJmpTo) { JmpTo = _newJmpTo; }
    bool isJmpToBlock() { return Dest.index() == 0; }
    bool isJmpToFunc() { return Dest.index() == 1; }
    unsigned int getRetValType() const { return RetValType; }

    std::string toString() override;
    ~branchInst() override = default;
};

class RET : public Instruction {
public:
    RET() : Instruction(OpCode::RET, SourceOperandType::cp) {}

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override { return nullptr; }
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override {} // 为了过编译只能先do nothing

    std::string toString() override { return "RET\n"; }
    ~RET() override = default;
};

} // namespace MIR

#endif