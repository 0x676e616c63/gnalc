// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Affine Alias Analysis for SIR
// Alias Analysis for Affine Fors
#pragma once
#ifndef GNALC_SIR_PASSES_ANALYSIS_AFFINE_ALIAS_ANALYSIS_HPP
#define GNALC_SIR_PASSES_ANALYSIS_AFFINE_ALIAS_ANALYSIS_HPP

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

    // Loop Invariant, but not an SIR constant. It can be a nullptr.
    // TODO: Something like SCEVExpr in IR may be better.
    Value* invariant = nullptr;

    int coe(IndVar *i) const;
    int coe(const pIndVar& i) const;
    // One induction variable and no constant or invariant
    bool isLinear() const;
    std::pair<int, IndVar*> getLinear() const;

    bool isConstant() const;
    int getConstant() const;

    AffineExpr operator+(const AffineExpr &rhs) const;
    AffineExpr operator-(const AffineExpr &rhs) const;
    AffineExpr operator*(int rhs) const;
    bool operator==(const AffineExpr &rhs) const;
    bool isIsomorphic(const AffineExpr &rhs) const;

    bool knownNonNegative() const;
    bool knownLessOrEqual(const AffineExpr &rhs) const;
    bool knownGreaterOrEqual(const AffineExpr &rhs) const;
};

// Two induction variables are isomorphic iff they have the same base, step, bound and nested depth.
bool isIndVarIsomorphic(IndVar *lhs, IndVar *rhs);

// Two Affine Exprs are isomorphic iff their `coeffs` are isomorphic and constants are equal.
// Two `coeffs` are isomorphic iff they have the same `coeff` on isomorphic induction variables.
bool isAffineExprIsomorphic(const AffineExpr &lhs, const AffineExpr &rhs);

struct IterRange {
    AffineExpr base;
    AffineExpr step;
    AffineExpr bound;

    bool covers(const IterRange& other) const;
    bool overlaps(const IterRange &other) const;
    bool equals(const IterRange &other) const;
    bool operator==(const IterRange &other) const;
};

struct ArrayAccess {
    Value *base;

    // Array Indices
    // for i in [0, n)
    //   for j in [0, m)
    //     a[2 * j][i + 1]
    //
    // Access for a[i][j]: indices = { 2 * j, i + 1 }
    std::vector<AffineExpr> indices;
    std::map<IndVar*, IterRange> domain;
    bool covers(const ArrayAccess &other) const;
    bool overlaps(const ArrayAccess &other) const;
};

std::ostream& operator<<(std::ostream &os, const AffineExpr &expr);
std::ostream& operator<<(std::ostream &os, const IterRange &access);
std::ostream& operator<<(std::ostream &os, const ArrayAccess &access);

struct MemoryAccess {
private:
    std::variant<ArrayAccess, ScalarAccess> access;

public:
    bool isArray() const { return std::holds_alternative<ArrayAccess>(access); }
    bool isScalar() const { return std::holds_alternative<ScalarAccess>(access); }
    auto &array() const { return std::get<ArrayAccess>(access); }
    auto &scalar() const { return std::get<ScalarAccess>(access); }
    auto type() const { return access.index(); }

    MemoryAccess() = default;
    explicit MemoryAccess(const ArrayAccess &array_access) : access(array_access) {}
    explicit MemoryAccess(const ScalarAccess &scalar_access) : access(scalar_access) {}

    bool covers(const MemoryAccess &other) const;
    bool overlaps(const MemoryAccess &other) const;
};

struct InstRW {
    std::set<Value *> read;
    std::set<Value *> write;
};

class AffineAAResult {
private:
    mutable std::unordered_map<Value *, std::optional<MemoryAccess>> access_cache;
    mutable std::unordered_map<Instruction *, std::optional<InstRW>> inst_rw_cache;

    std::optional<MemoryAccess> analyzePointer(Value *) const;
    std::optional<InstRW> analyzeInstRW(Instruction *) const;

    LinearFunction* func{};
    LFAM* fam{};

public:
    AffineAAResult(LinearFunction *func_, LFAM* fam_) : func(func_), fam(fam_) {}

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

class AffineAliasAnalysis : public PM::AnalysisInfo<AffineAliasAnalysis> {
public:
    AffineAAResult run(LinearFunction &f, LFAM &fam);

    // For PassManager
public:
    using Result = AffineAAResult;

private:
    friend AnalysisInfo<AffineAliasAnalysis>;
    static PM::UniqueKey Key;
};

struct FuncRW {
    std::set<Value *> read;
    std::set<Value *> write;
};
std::optional<FuncRW> queryFuncRW(LFAM* lfam, LinearFunction* func);
} // namespace SIR


#endif