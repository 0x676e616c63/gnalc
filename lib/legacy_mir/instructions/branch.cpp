// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#include "legacy_mir/instructions/branch.hpp"
#include "legacy_mir/enum_name.hpp"

using namespace LegacyMIR;

branchInst::branchInst(OpCode JmpCode_, std::shared_ptr<IR::BasicBlock> Dest_, std::string JmpTo_)
    : Instruction(JmpCode_, SourceOperandType::cp), Dest(std::move(Dest_)), JmpTo(std::move(JmpTo_)) {}
branchInst::branchInst(OpCode JmpCode_, std::shared_ptr<IR::FunctionDecl> Dest_, std::string JmpTo_,
                       unsigned int _RetValType)
    : Instruction(JmpCode_, SourceOperandType::cp), Dest(std::move(Dest_)), JmpTo(std::move(JmpTo_)),
      RetValType(_RetValType) {}

std::shared_ptr<Operand> branchInst::getSourceOP(unsigned int seq) { return nullptr; }

void branchInst::setSourceOP(unsigned int seq, std::shared_ptr<Operand>) {}

std::variant<std::shared_ptr<IR::BasicBlock>, std::shared_ptr<IR::FunctionDecl>> branchInst::getDest() { return Dest; }

std::string branchInst::getJmpTo() { return JmpTo; }

void branchInst::changeJmpTo(std::string _newJmpTo) { JmpTo = _newJmpTo; }

bool branchInst::isJmpToBlock() { return Dest.index() == 0; }

bool branchInst::isJmpToFunc() { return Dest.index() == 1; }

unsigned int branchInst::getRetValType() const { return RetValType; }

std::string branchInst::toString() {
    std::string str;
    str += enum_name(std::get<OpCode>(opcode));
    str += enum_name(getCondCodeFlag());
    str += ' ';
    str += JmpTo + '\n';

    return str;
}

RET::RET() : Instruction(OpCode::RET, SourceOperandType::cp) {}

std::shared_ptr<Operand> RET::getSourceOP(unsigned int seq) { return nullptr; }

void RET::setSourceOP(unsigned int seq, std::shared_ptr<Operand>) {} // 为了过编译只能先do nothing

std::string RET::toString() { return "RET\n"; }
#endif