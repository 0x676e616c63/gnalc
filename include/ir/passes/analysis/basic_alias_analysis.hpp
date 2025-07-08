// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Basic Alias Analysis
// An partial inter-procedural field-insensitive alias analysis.
// The ModRef result is inter-procedural, while the Alias result is intra-procedural.
// For a more accurate result, see Loop-oriented Alias Analysis in 'lpa.hpp'.
//
// Warning: This pass must be run after PromotePass, since it do NOT handle pointers over scalar values.
#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_BASIC_ALIAS_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_BASIC_ALIAS_ANALYSIS_HPP

#include "ir/instructions/control.hpp"
#include "ir/passes/pass_manager.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"

namespace IR {
class BasicAAResult : public AAResult {
public:
    friend class BasicAliasAnalysis;
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
            auto seed = std::hash<Value *>()(std::get<0>(key));
            Util::hashSeedCombine(seed, std::hash<Value *>()(std::get<1>(key)));
            return seed;
        }
    };
    mutable std::unordered_map<AliasCacheKey, AliasInfo, AliasCacheHash> alias_cache;
public:
    // v1 and v2 must be pointers
    AliasInfo getAliasInfo(Value *v1, Value *v2) const override;
    AliasInfo getAliasInfo(const pVal &v1, const pVal &v2) const override;

    // v must be pointer
    // Check if v points a memory that outside don't know.
    bool isLocal(Value *v) const;
    bool isLocal(const pVal &v) const;

    // location must be a pointer
    ModRefInfo getInstModRefInfo(Instruction *inst, Value *location, FAM &fam) const override;
    ModRefInfo getInstModRefInfo(const pInst &inst, const pVal &location, FAM &fam) const override;

    ModRefInfo getFunctionModRefInfo() const;

    // Check if it contains call that we don't know
    bool hasUntrackedCall() const;

    // Check if it contains call to Sylib function: getxxx(), putxxx()
    bool hasSylibCall() const;

    // Add a cloned pointer
    void addClonedPointer(Value *raw, Value *cloned);
    void addClonedPointer(const pVal &raw, const pVal &cloned);

    const auto &getRead() const { return read; }
    const auto &getWrite() const { return write; }
};

class BasicAliasAnalysis : public PM::AnalysisInfo<BasicAliasAnalysis> {
public:
    BasicAAResult run(Function &f, FAM &fam);

    // For PassManager
public:
    using Result = BasicAAResult;

private:
    friend AnalysisInfo<BasicAliasAnalysis>;
    static PM::UniqueKey Key;
};
} // namespace IR

#endif