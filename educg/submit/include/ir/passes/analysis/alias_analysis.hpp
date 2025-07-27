// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Generic Alias Analysis Interface
#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_ALIAS_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_ALIAS_ANALYSIS_HPP

#include "../../instructions/control.hpp"
#include "../pass_manager.hpp"

namespace IR {
enum class AliasInfo { MustAlias, MayAlias, NoAlias };
enum class ModRefInfo {
    NoModRef,
    Ref,
    Mod,
    ModRef,
};
class AAResult {
public:
    virtual ~AAResult() = default;

    // v1 and v2 must be pointers
    virtual AliasInfo getAliasInfo(Value *v1, Value *v2) const = 0;
    virtual AliasInfo getAliasInfo(const pVal &v1, const pVal &v2) const = 0;

    // location must be a pointer
    virtual ModRefInfo getInstModRefInfo(Instruction *inst, Value *location, FAM &fam) const = 0;
    virtual ModRefInfo getInstModRefInfo(const pInst &inst, const pVal &location, FAM &fam) const = 0;
};

struct RWInfo {
    std::vector<Value *> read;
    std::vector<Value *> write;
    bool untracked = false;
};

RWInfo getCallRWInfo(FAM &fam, CALLInst *call);
struct SharedRWInfo {
    std::vector<pVal> read;
    std::vector<pVal> write;
    bool untracked = false;
};
SharedRWInfo getCallRWInfo(FAM &fam, const pCall &call);

// Check if function is pure
// Given the same input, always returns the same output.
bool isPure(FAM& fam, FunctionDecl* decl);
bool isPure(FAM &fam, const pFuncDecl &decl);
bool isPure(FAM &fam, const CALLInst *call);
bool isPure(FAM &fam, const pCall &call);

// Check if the call instruction has side effect
// It don't change the outer scope, but its output may change even with same input.
// The difference is that pure function never read global variable or outer memory.
// but this only guarantee no write to global or outer memory.
bool hasSideEffect(FAM& fam, FunctionDecl* decl);
bool hasSideEffect(FAM &fam, const pFuncDecl &decl);
bool hasSideEffect(FAM &fam, const CALLInst *call);
bool hasSideEffect(FAM &fam, const pCall &call);

// Check if the basic block has side effect
bool hasSideEffect(FAM &fam, BasicBlock* block);
bool hasSideEffect(FAM &fam, const pBlock& block);

// Check if the loop has side effect
bool hasSideEffect(FAM &fam, const Loop* loop);
bool hasSideEffect(FAM &fam, const pLoop& loop);

// Check if the instruction has side effect
bool hasSideEffect(FAM &fam, Instruction* inst);
bool hasSideEffect(FAM &fam, const pInst& inst);

pVal getMemLocation(Value* i);
pVal getMemLocation(const pVal &i);

Value* getPtrBase(Value* ptr);
pVal getPtrBase(const pVal& ptr);
} // namespace IR

#endif