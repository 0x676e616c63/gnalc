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
enum class AliasInfo { MustAlias, MayAlias, NoAlias };
enum class ModRefInfo {
    NoModRef,
    Ref,
    Mod,
    ModRef,
};
class AliasAnalysisResult {
public:
    friend class AliasAnalysis;
    struct PtrInfo {
        // Array arguments
        bool untracked_array = false;
        // Global Variable
        bool global_var = false;
        // Maybe alias
        // Only GlobalVariables or FormalArguments or ALLOCA
        // NO GEP or BITCAST here.
        std::unordered_set<Value *> potential_alias;
    };

private:
    // Target
    Function *func;

    // Local pointers/FormalArguments info map
    std::unordered_map<Value *, PtrInfo> ptr_info;

    // Function's Mod/Ref info, only GlobalVariables and FormalArguments
    std::unordered_set<Value *> read;
    std::unordered_set<Value *> write;

    // Some call we don't know
    // This may happen when we add runtime parallel lib or something.
    // When function contains them, the `ModRefInfo` will always be `ModRef`.
    bool has_untracked_call = false;

    // Has call to sylib
    // This means the function uses sylib.
    // In general, we can't eliminate them, they always have side effect.
    bool has_sylib_call = false;

    // Try insert `alias` to `target` as a potential alias.
    // Returns true for success.
    bool insertPotentialAlias(Value *target, Value *alias);

    // For cases involved with global variable,
    // this function generates one for global variable.
    PtrInfo getPtrInfo(Value *ptr) const;

    using AliasCacheKey = std::tuple<Value *, Value *>;
    struct AliasCacheHash {
        size_t operator()(const AliasCacheKey &key) const {
            return std::hash<Value *>()(std::get<0>(key)) ^ std::hash<Value *>()(std::get<1>(key));
        }
    };
    mutable std::unordered_map<AliasCacheKey, AliasInfo, AliasCacheHash> alias_cache;
public:
    // v1 and v2 must be pointers
    AliasInfo getAliasInfo(Value *v1, Value *v2) const;
    AliasInfo getAliasInfo(const pVal &v1, const pVal &v2) const;

    // v must be pointer
    // Check if v points a memory that outside don't know.
    bool isLocal(Value *v) const;
    bool isLocal(const pVal &v) const;

    // location must be a pointer
    ModRefInfo getInstModRefInfo(Instruction *inst, Value *location, FAM &fam) const;
    ModRefInfo getInstModRefInfo(const pInst &inst, const pVal &location, FAM &fam) const;

    ModRefInfo getFunctionModRefInfo() const;

    // Check if it contains call that we don't know
    bool hasUntrackedCall() const;

    // Check if it contains call to Sylib function: getxxx(), putxxx()
    bool hasSylibCall() const;

    // Add a cloned instruction
    void addClonedInst(Instruction *inst, Instruction *cloned);
    void addClonedInst(const pInst &inst, const pInst &cloned);

    const auto &getRead() const { return read; }
    const auto &getWrite() const { return write; }
};

class AliasAnalysis : public PM::AnalysisInfo<AliasAnalysis> {
public:
    AliasAnalysisResult run(Function &f, FAM &fam);

    // For PassManager
public:
    using Result = AliasAnalysisResult;

private:
    friend AnalysisInfo<AliasAnalysis>;
    static PM::UniqueKey Key;
};

// These functions can be treated as pure function (NoModRef)
// Currently there is no such function.
bool isPureBuiltinOrSylibFunc(const FunctionDecl *fn);

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
} // namespace IR

#endif