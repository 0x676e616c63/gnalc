// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "constraint/base.hpp"
#include "utils/exception.hpp"
#include "utils/logger.hpp"

#include <algorithm>
#include <map>
#include <numeric>
#include <set>
#include <sstream>
#include <unordered_set>
#include <vector>

namespace CSTR {
VarID VarHandle::newVar(std::string name) {
    if (name.empty()) {
        if (greek_pos < std::size(greeks))
            name = greeks[greek_pos++];
        else
            name = "var_" + std::to_string(var_names.size());
    }

    if (var_names_set.count(name))
        Logger::logWarning("[Constraint]: Variable name already exists.");

    var_names.emplace_back(name);
    var_names_set.emplace(std::move(name));
    return var_names.size() - 1;
}
std::string VarHandle::name(VarID v) const { return var_names[v]; }

void VarHandle::reset() {
    var_names.clear();
    var_names_set.clear();
    greek_pos = 0;
}

Expr Expr::operator+(const Expr &rhs) const {
    Expr ret;
    ret.constant = constant + rhs.constant;
    ret.coeffs = coeffs;
    for (const auto &[var, coe] : rhs.coeffs) {
        ret.coeffs[var] += coe;
        if (ret.coeffs[var] == 0)
            ret.coeffs.erase(var);
    }
    return ret;
}
Expr Expr::operator*(CoeT rhs) const {
    Expr ret = *this;
    for (auto &[var, coe] : ret.coeffs)
        coe *= rhs;
    ret.constant *= rhs;
    return ret;
}
Expr Expr::operator-(const Expr &rhs) const { return *this + rhs * -1; }

Constraint Constraint::newEqualZero(const Expr &expr) {
    return Constraint(expr.coeffs, expr.constant, ConstraintKind::EQ);
}

Constraint Constraint::newGreaterEqualZero(const Expr &expr) {
    return Constraint(expr.coeffs, expr.constant, ConstraintKind::GE);
}

// a + b + c >= 0 -> -a + -b + -c <= 0
Constraint Constraint::newLessEqualZero(const Expr &expr) {
    auto neg_coeffs = expr.coeffs;
    for (auto &[v, c] : neg_coeffs)
        neg_coeffs[v] = -c;
    return Constraint(neg_coeffs, -expr.constant, ConstraintKind::GE);
}

// a + b > 0 -> a + b - 1 >= 0
Constraint Constraint::newGreaterThanZero(const Expr &expr) {
    return newGreaterEqualZero({expr.coeffs, expr.constant - 1});
}

// a + b < 0 -> a + b + 1 <= 0
Constraint Constraint::newLessThanZero(const Expr &expr) { return newLessEqualZero({expr.coeffs, expr.constant + 1}); }
Constraint Constraint::newEqual(const Expr &lhs, const Expr &rhs) { return newEqualZero(lhs - rhs); }
Constraint Constraint::newGreaterEqual(const Expr &lhs, const Expr &rhs) { return newGreaterEqualZero(lhs - rhs); }
Constraint Constraint::newGreaterThan(const Expr &lhs, const Expr &rhs) { return newGreaterThanZero(lhs - rhs); }
Constraint Constraint::newLessEqual(const Expr &lhs, const Expr &rhs) { return newLessEqualZero(lhs - rhs); }
Constraint Constraint::newLessThan(const Expr &lhs, const Expr &rhs) { return newLessThanZero(lhs - rhs); }

bool Constraint::isTriviallyTrue() const {
    if (!coeffs.empty())
        return false;
    if (isEq())
        return constant == 0;
    return constant >= 0;
}

Constraint Constraint::operator+(const Constraint &rhs) const {
    Constraint ret;
    ret.constant = constant + rhs.constant;
    ret.kind = (kind == ConstraintKind::EQ && rhs.kind == ConstraintKind::EQ) ? ConstraintKind::EQ : ConstraintKind::GE;
    ret.coeffs = coeffs;
    for (const auto &[var, coe] : rhs.coeffs) {
        ret.coeffs[var] += coe;
        if (ret.coeffs[var] == 0)
            ret.coeffs.erase(var);
    }
    return ret;
}

Constraint Constraint::operator*(CoeT rhs) const {
    // if rhs < 0 and constraint is inequality, direction flips
    Err::gassert(rhs > 0 || kind == ConstraintKind::EQ);

    Constraint ret = *this;
    for (auto &[var, coe] : ret.coeffs)
        coe *= rhs;
    ret.constant *= rhs;
    return ret;
}

bool Constraint::operator==(const Constraint &rhs) const {
    return kind == rhs.kind && coeffs == rhs.coeffs && constant == rhs.constant;
}

bool Constraint::contradict(const Constraint &rhs) const {
    Err::gassert(kind == rhs.kind);

    if (isEq())
        return false;

    // 'x + y + c1 >= 0' and '-x - y + c2 >= 0' are contradictory iff 'c1 + c2 < 0'
    if (coeffs.size() != rhs.coeffs.size())
        return false;
    auto beg1 = coeffs.begin(), end1 = coeffs.end(), beg2 = rhs.coeffs.begin();
    while (beg1 != end1) {
        if (beg1->first + beg2->first != 0)
            return false;
        if (beg1->second != beg2->second)
            return false;
        ++beg1;
        ++beg2;
    }

    return constant + rhs.constant < 0;
}
bool Constraint::subsume(const Constraint &rhs) const {
    Err::gassert(kind == rhs.kind);

    if (isEq())
        return false;

    // 'x + y + c1 >= 0' subsumes 'x + y + c2 >= 0' iff 'c1 <= c2'
    if (coeffs.size() != rhs.coeffs.size())
        return false;
    auto beg1 = coeffs.begin(), end1 = coeffs.end(), beg2 = rhs.coeffs.begin();
    while (beg1 != end1) {
        if (*beg1 != *beg2)
            return false;
        ++beg1;
        ++beg2;
    }

    return constant <= rhs.constant;
}

bool Constraint::isEq() const { return kind == ConstraintKind::EQ; }

// Returns false if this constraint is unsatisfiable
bool Constraint::normalize() {
    if (coeffs.empty()) {
        if (isEq())
            return constant == 0;
        return constant >= 0;
    }

    std::vector<CoeT> coeffs_only;
    coeffs_only.reserve(coeffs.size());
    for (auto &t : coeffs)
        coeffs_only.push_back(t.second);

    CoeT g = gcd_list(coeffs_only);
    Err::gassert(g != 0);

    // If the constraint is an equality constraint and g does not evenly divide a0
    // the constraint is unsatisfiable. If the constraint is an inequality constraint,
    // we take the floor when dividing a0 by g (i.e., we replace a0 with floor(a0 / g)).
    if (isEq() && constant % g != 0)
        return false;

    constant = int_div(constant, g);
    for (auto &[var, coe] : coeffs)
        coeffs[var] /= g;

    return true;
}

void Constraint::dump(const VarHandle &VH, std::ostream &os) const {
    bool first = true;
    for (auto &[var, coe] : coeffs) {
        if (!first)
            os << " + ";

        if (coe == -1)
            os << "-";
        else if (coe != 1)
            os << coe;

        os << VH.name(var);
        first = false;
    }

    if (constant != 0) {
        if (!first)
            os << " + ";
        os << constant;
    } else if (first)
        os << "0";

    os << (kind == ConstraintKind::EQ ? " == 0" : " >= 0");
}

std::string Constraint::dump(const VarHandle &VH) const {
    std::ostringstream oss;
    dump(VH, oss);
    return oss.str();
}
} // namespace CSTR