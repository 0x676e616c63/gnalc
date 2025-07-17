// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Alias Analysis for SIR
// TODO: Maybe we should preserve these info in IRGen
//       rather than analyzing it afterwards.
#pragma once
#ifndef GNALC_SIR_PASSES_ANALYSIS_ALIAS_ANALYSIS_HPP
#define GNALC_SIR_PASSES_ANALYSIS_ALIAS_ANALYSIS_HPP

#include "ir/instructions/control.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "sir/base.hpp"
#include "sir/passes/pass_manager.hpp"

namespace SIR {
class LAAResult {
public:
    struct PtrInfo {
        Value* base = nullptr;
        bool untracked = true;
    };
    struct InstRW {
        std::set<Value *> read;
        std::set<Value *> write;
        bool untracked = false;
    };
private:
    mutable std::unordered_map<Value *, PtrInfo> ptr_cache;
    mutable std::unordered_map<Instruction *, InstRW> inst_rw_cache;

    PtrInfo analyzePointer(Value *) const;
    InstRW analyzeInstRW(Instruction *) const;
public:
    const PtrInfo &queryPointer(Value *) const;
    const InstRW &queryInstRW(Instruction *) const;

    // See if two pointers are of the same variable
    AliasInfo getAliasInfo(const pVal &lhs, const pVal &rhs) const;
    AliasInfo getAliasInfo(Value *lhs, Value *rhs) const;

    // See if two instructions are independent
    bool isIndependent(const pInst& lhs, const pInst& rhs) const;
    bool isIndependent(Instruction *lhs, Instruction *rhs) const;
};

class LAliasAnalysis : public PM::AnalysisInfo<LAliasAnalysis> {
public:
    LAAResult run(LinearFunction &f, LFAM &fam);

    // For PassManager
public:
    using Result = LAAResult;

private:
    friend AnalysisInfo<LAliasAnalysis>;
    static PM::UniqueKey Key;
};
} // namespace SIR

#endif