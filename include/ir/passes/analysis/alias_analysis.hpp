// Alias/ModRef Analysis for SysY.
// SysY has no pointers, which means only arrays can have alias.
// So this implementation is much simplified than normal Alias/ModRef Analysis.
#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_ALIAS_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_ALIAS_ANALYSIS_HPP

#include "../../instructions/control.hpp"
#include "../pass_manager.hpp"

namespace IR {
class AliasAnalysis;
class AliasAnalysisResult {
public:
    friend class AliasAnalysis;
    struct PtrInfo {
        // Array arguments
        bool untracked_array = false;
        // Global Variable
        bool global_var = false;
        // Maybe alias
        // There is GlobalVariables or FormalArguments or ALLOCA
        // NO GEP here.
        std::set<const Value *> potential_alias;
    };

private:
    // Target
    Function *func;

    // Local/Array arguments info map
    std::unordered_map<const Value *, PtrInfo> ptr_info;

    // Mod/Ref info, only global and Array arguments
    std::set<const Value *> read;
    std::set<const Value *> write;

    // some call we don't know (part of Sylib)
    bool has_untracked_call = false;

    // Try insert `alias` to `target` as a potential alias.
    // Returns true for success.
    bool insertPotentialAlias(const Value *target, const Value *alias);

    // For cases involved with global variable,
    // this function generates one for global variable.
    PtrInfo getPtrInfo(const Value *ptr) const;

public:
    enum class AliasInfo { MustAlias, MayAlias, NoAlias };
    enum class ModRefInfo {
        NoModRef,
        Ref,
        Mod,
        ModRef,
    };

    // v1 and v2 must be Global Variable or array with the given function
    AliasInfo getAliasInfo(const Value *v1, const Value *v2) const;

    // candidate must be Global Variable or array with the given function
    ModRefInfo getInstModRefInfo(const Instruction *inst,
                                 const Value *location, FAM &fam) const;

    ModRefInfo getFunctionModRefInfo() const;

    // Check if it contains call to Sylib function: getxxx(), putxxx()
    bool hasUntrackedCall() const;
};

class AliasAnalysis : public PM::AnalysisInfo<AliasAnalysis> {
public:
    static AliasAnalysisResult run(Function &f, FAM &fam);

    // For PassManager
public:
    using Result = AliasAnalysisResult;

private:
    friend AnalysisInfo<AliasAnalysis>;
    static PM::UniqueKey Key;
};

// These functions can be treated as pure function (NoModRef)
bool isPureBuiltinOrSylibFunc(const FunctionDecl *fn);

// Check if function is pure
// Given the same input, always returns the same output.
bool isPure(FAM &fam, const CALLInst *call);

// Check if function has side effect
// It don't change the outer scope, but its output may change even with same input.
// The difference is that pure function never read global variable or outer memory.
// but this only guarantee no write to global or outer memory.
bool hasSideEffect(FAM &fam, const CALLInst *call);

} // namespace IR

#endif