// Loop-oriented Alias Analysis
// An inter-procedural field-sensitive alias analysis based on AMM (Access-based Memory Modeling).
//
// The main difference between this and the BasicAliasAnalysis in 'basic_alias_analysis.hpp'
// is that this models memory in a fine-grained access-based manner.
//
// Reference:
// - "Loop-Oriented Array- and Field-Sensitive Pointer Analysis for Automatic SIMD Vectorization"
//      https://yuleisui.github.io/publications/lctes16.pdf
#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_LOOP_ALIAS_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_LOOP_ALIAS_ANALYSIS_HPP

#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/scev.hpp"
#include "ir/instructions/control.hpp"
#include "ir/passes/pass_manager.hpp"

namespace IR {
class LoopAAResult : public AAResult {
private:
public:
    struct LocationSet {
        static constexpr size_t Inf = std::numeric_limits<size_t>::max();
        struct AccessPair {
            size_t trip_count;
            size_t stride;
        };

        Value* base;
        size_t offset;
        std::vector<AccessPair> accesses;
    };

    bool overlap(const LocationSet &lhs, const LocationSet &rhs) const;

    AliasInfo getAliasInfo(Value *v1, Value *v2) const override;
    AliasInfo getAliasInfo(const pVal &v1, const pVal &v2) const override;

    ModRefInfo getInstModRefInfo(Instruction *inst, Value *location, FAM &fam) const override;
    ModRefInfo getInstModRefInfo(const pInst &inst, const pVal &location, FAM &fam) const override;

private:
    std::unordered_map<Value *, LocationSet> ptr_map;
};
class LoopAliasAnalysis : public PM::AnalysisInfo<LoopAliasAnalysis> {
public:
    LoopAAResult run(Function &f, FAM &fam);

    // For PassManager
public:
    using Result = LoopAAResult;

private:
    friend AnalysisInfo<LoopAliasAnalysis>;
    static PM::UniqueKey Key;
};
} // namespace IR

#endif
