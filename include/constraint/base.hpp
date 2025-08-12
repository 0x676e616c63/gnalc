// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_CONSTRAINT_BASE_HPP
#define GNALC_CONSTRAINT_BASE_HPP

#include "utils/exception.hpp"
#include "utils/logger.hpp"

#include <algorithm>
#include <limits>
#include <map>
#include <numeric>
#include <optional>
#include <unordered_set>
#include <vector>

namespace CSTR {
using VarID = size_t;
using CoeT = int64_t;

constexpr VarID BAD_VAR_ID = std::numeric_limits<VarID>::max();

static int int_sign(CoeT x) { return x > 0 ? 1 : (x < 0 ? -1 : 0); }

static CoeT gcd_list(const std::vector<CoeT> &arr) {
    CoeT g = 0;
    for (auto v : arr)
        g = std::gcd(g, std::abs(v));
    return g;
}

static CoeT int_div(CoeT a, CoeT b) {
    if (a > 0)
        return a / b;
    return -((-a + b - 1) / b);
}

// Prefer greek letters for debug.
constexpr const char *greeks[] = {"α", "β", "γ", "δ", "ϵ", "ζ", "η", "θ", "ι", "κ", "λ", "μ",
                                  "ν", "ξ", "ο", "π", "ρ", "σ", "τ", "υ", "ϕ", "χ", "ψ", "ω"};

class VarHandle {
    std::vector<std::string> var_names;
    std::unordered_set<std::string> var_names_set;

    size_t greek_pos = 0;

public:
    VarID newVar(std::string name = "");
    std::string name(VarID v) const;
    void reset();
};

struct Expr {
    std::map<VarID, CoeT> coeffs;
    CoeT constant = 0;

    Expr operator+(const Expr &rhs) const;
    Expr operator*(CoeT rhs) const;
    Expr operator-(const Expr &rhs) const;
};

enum class ConstraintKind { EQ, GE }; // EQ: == 0, GE: >= 0
class Constraint {
public:
    std::map<VarID, CoeT> coeffs;
    CoeT constant = 0;
    ConstraintKind kind = ConstraintKind::EQ;

private:
    explicit Constraint(const std::map<VarID, CoeT> &coeffs_, CoeT constant_, ConstraintKind kind_)
        : coeffs(coeffs_), constant(constant_), kind(kind_) {}

public:
    Constraint() = default;
    Constraint(const Constraint &) = default;
    Constraint &operator=(const Constraint &) = default;
    Constraint(Constraint &&) = default;
    Constraint &operator=(Constraint &&) = default;

    static Constraint newEqualZero(const Expr &expr);

    static Constraint newGreaterEqualZero(const Expr &expr);
    // a + b + c >= 0 -> -a + -b + -c <= 0
    static Constraint newLessEqualZero(const Expr &expr);

    // a + b > 0 -> a + b - 1 >= 0
    static Constraint newGreaterThanZero(const Expr &expr);

    // a + b < 0 -> a + b + 1 <= 0
    static Constraint newLessThanZero(const Expr &expr);
    static Constraint newEqual(const Expr &lhs, const Expr &rhs);
    static Constraint newGreaterEqual(const Expr &lhs, const Expr &rhs);
    static Constraint newGreaterThan(const Expr &lhs, const Expr &rhs);
    static Constraint newLessEqual(const Expr &lhs, const Expr &rhs);
    static Constraint newLessThan(const Expr &lhs, const Expr &rhs);

    bool isTriviallyTrue() const;

    Constraint operator+(const Constraint &rhs) const;
    Constraint operator*(CoeT rhs) const;

    bool operator==(const Constraint &rhs) const;

    bool contradict(const Constraint &rhs) const;
    bool subsume(const Constraint &rhs) const;

    bool isEq() const;

    // Returns false if this constraint is unsatisfiable
    bool normalize();
    void dump(const VarHandle &VH, std::ostream &os) const;

    std::string dump(const VarHandle &VH) const;
};
} // namespace CSTR

#endif
