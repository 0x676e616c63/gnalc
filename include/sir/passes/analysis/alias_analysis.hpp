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

#include <optional>

namespace SIR {
struct ScalarAccess {
    Value *base;
};

// Affine Expr
// e(i,j,k...) = c0 + c1 * i + c2 * j + c3 * k + ...
struct AffineExpr {
    // Theses coeffs must be non-zero.
    // That is, if `coeffs.count(i)`, then `i` is in this affine expr.
    std::map<IndVar *, int> coeffs;
    int constant;

    int coe(IndVar *i) const;
    AffineExpr operator+(const AffineExpr &rhs) const;
    AffineExpr operator-(const AffineExpr &rhs) const;
    AffineExpr operator*(int rhs) const;
    bool operator==(const AffineExpr &rhs) const;
};

bool isIsomorphic(const AffineExpr &lhs, const AffineExpr &rhs);

struct ArrayAccess {
    Value *base;

    // Array Indices
    // for i in [0, n)
    //   for j in [0, m)
    //     a[2 * j][i + 1]
    //
    // Access for a[i][j]: indices = { 2 * j, i + 1 }
    std::vector<AffineExpr> indices;
    // TODO: Domain
};

struct MemoryAccess {
private:
    std::variant<ArrayAccess, ScalarAccess> access;

public:
    bool isArray() const { return std::holds_alternative<ArrayAccess>(access); }
    bool isScalar() const { return std::holds_alternative<ScalarAccess>(access); }
    auto &array() const { return std::get<ArrayAccess>(access); }
    auto &scalar() const { return std::get<ScalarAccess>(access); }

    MemoryAccess() = default;
    explicit MemoryAccess(const ArrayAccess &array_access) : access(array_access) {}
    explicit MemoryAccess(const ScalarAccess &scalar_access) : access(scalar_access) {}
};

struct InstRW {
    std::set<Value *> read;
    std::set<Value *> write;
};

class LAAResult {
private:
    mutable std::unordered_map<Value *, std::optional<MemoryAccess>> access_cache;
    mutable std::unordered_map<Instruction *, std::optional<InstRW>> inst_rw_cache;

    std::optional<MemoryAccess> analyzePointer(Value *) const;
    std::optional<InstRW> analyzeInstRW(Instruction *) const;

public:
    const std::optional<MemoryAccess> &queryPointer(Value *) const;
    const std::optional<InstRW> &queryInstRW(Instruction *) const;
    const std::optional<MemoryAccess> &queryPointer(const pVal&) const;
    const std::optional<InstRW> &queryInstRW(const pInst&) const;

    // See if two pointers are of the same variable
    AliasInfo getAliasInfo(const pVal &lhs, const pVal &rhs) const;
    AliasInfo getAliasInfo(Value *lhs, Value *rhs) const;

    // Determines whether two instructions are independent.
    bool isIndependent(const pInst &lhs, const pInst &rhs) const;
    bool isIndependent(Instruction *lhs, Instruction *rhs) const;

    // Determines instruction independence considering only scalars.
    // This is useful for requiring detailed array access information
    // without interference from scalar dependencies.
    bool isScalarIndependent(const pInst &lhs, const pInst &rhs) const;
    bool isScalarIndependent(Instruction *lhs, Instruction *rhs) const;
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