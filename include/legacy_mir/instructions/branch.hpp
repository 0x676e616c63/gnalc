// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_INSTRUCTIONS_BRANCH_HPP
#define GNALC_LEGACY_MIR_INSTRUCTIONS_BRANCH_HPP

#include "ir/basic_block.hpp"
#include "ir/function.hpp"
#include "legacy_mir/basicblock.hpp"
#include "legacy_mir/function.hpp"
#include "legacy_mir/instruction.hpp"

namespace LegacyMIR {
class branchInst : public Instruction {
private:
    std::variant<std::shared_ptr<IR::BasicBlock>,
                 std::shared_ptr<IR::FunctionDecl>> Dest; // 为PhiEliminate准备
    std::string JmpTo;                                    // with @ or %
    unsigned RetValType;                                  // only BL or BLX: 0(void), 1(int), 2(float)

public:
    branchInst() = delete;
    branchInst(OpCode JmpCode_, std::shared_ptr<IR::BasicBlock> Dest_, std::string JmpTo_);
    branchInst(OpCode JmpCode_, std::shared_ptr<IR::FunctionDecl> Dest_, std::string JmpTo_, unsigned int _RetValType);

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    std::variant<std::shared_ptr<IR::BasicBlock>, std::shared_ptr<IR::FunctionDecl>> getDest();
    std::string getJmpTo();
    void changeJmpTo(std::string _newJmpTo);
    bool isJmpToBlock();
    bool isJmpToFunc();
    unsigned int getRetValType() const;

    std::string toString() override;
    ~branchInst() override = default;
};

class RET : public Instruction {
public:
    RET();

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    std::string toString() override;
    ~RET() override = default;
};

} // namespace MIR

#endif
#endif
