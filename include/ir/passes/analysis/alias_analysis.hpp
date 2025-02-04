// Alias/ModRef Analysis for SysY.
// SysY has no pointers, which means only arrays can have alias.
// So this implementation is much simplified than normal Alias/ModRef Analysis.
#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_ALIAS_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_ALIAS_ANALYSIS_HPP

#include "../pass_manager.hpp"

namespace IR {
class AliasAnalysisPass;
class AliasAnalysisResult {
public:
    friend class AliasAnalysisPass;
    struct PtrInfo {
        bool untracked = false;
        std::set<const Value*> potential_alias;
    };
private:
    std::unordered_map<const Value*, PtrInfo> ptr_info;
    std::set<const Value*> read;
    std::set<const Value*> write;
    bool has_untracked_call = false;

    bool insertAlias(const Value* target, const Value* alias);
    PtrInfo getPtrInfo(const Value* ptr) const;
public:
    enum class AliasInfo {
        MustAlias,
        NoAlias
    };
    enum class ModRefInfo {
        NoModRef,
        Ref,
        Mod,
        ModRef,
    };

    // v1 and v2 must be pointer
    AliasInfo getAliasInfo(const Value* v1, const Value* v2) const;

    // operand must be pointer
    ModRefInfo getInstModRefInfo(const Instruction* inst, const Value* candidate) const;

    ModRefInfo getFunctionModRefInfo() const;
};

class AliasAnalysisPass : public PM::AnalysisInfo<AliasAnalysisPass> {
public:
    static AliasAnalysisResult run(Function &f, FAM &fam);

    // For PassManager
public:
    using Result = AliasAnalysisResult;

private:
    friend AnalysisInfo<AliasAnalysisPass>;
    static PM::UniqueKey Key;
};
} // namespace IR

#endif