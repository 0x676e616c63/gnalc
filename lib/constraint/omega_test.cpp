// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "constraint/omega_test.hpp"

#include "constraint/base.hpp"
#include "utils/exception.hpp"

#include <algorithm>
#include <iostream>
#include <limits>
#include <list>
#include <map>
#include <optional>
#include <set>
#include <sstream>
#include <vector>

namespace CSTR {
void OmegaSolver::addConstraint(const Constraint &con) {
    for (auto &[var, coe] : con.coeffs)
        V.insert(var);
    S.push_back(con);
}

void OmegaSolver::addConstraints(const std::vector<Constraint> &constraints) {
    for (auto &con : constraints)
        addConstraint(con);
}

bool OmegaSolver::mayHasIntSolutions() {
    if (!normalize())
        return false;

    debugDumpPoint("Starting with:");

    if (!eliminateEqualities())
        return false;

    if (!eliminateInequalities())
        return false;

    debugDumpPoint("Finally:");
    return true;
}

void OmegaSolver::dump(std::ostream &os) {
    for (auto &con : S) {
        con.dump(VH, os);
        os << std::endl;
    }
}
std::string OmegaSolver::dump() {
    std::ostringstream oss;
    dump(oss);
    return oss.str();
}

void OmegaSolver::debugDumpPoint(const std::string &msg) {
    if (debug_dump_stream) {
        if (!msg.empty())
            *debug_dump_stream << msg << std::endl;
        dump(*debug_dump_stream);
        *debug_dump_stream << std::endl;
    }
}

void OmegaSolver::enableDebugDump(std::ostream &os) { debug_dump_stream = &os; }

bool OmegaSolver::normalize() {
    for (auto it = S.begin(); it != S.end();) {
        if (!it->normalize())
            return false;

        if (it->isTriviallyTrue())
            it = S.erase(it);
        else
            ++it;
    }
    return true;
}

// Substitute variable v with def
void OmegaSolver::substitute(VarID v, const Constraint &def) {
    if (debug_dump_stream)
        *debug_dump_stream << "Substituting " << VH.name(v) << " with: " << def.dump(VH) << "\n";

    auto it = def.coeffs.find(v);
    if (it == def.coeffs.end())
        return;
    CoeT coe_v = it->second;

    // for each constraint that contains v, replace v by the given def expression
    for (auto &con : S) {
        auto it2 = con.coeffs.find(v);
        if (it2 == con.coeffs.end())
            continue;
        CoeT coeff_in_con = it2->second;
        con.coeffs.erase(v);
        // v = (-def.constant - sum_{u!=v} def.coeffs[u]*u) / coe_v
        // multiply by coeff_in_con and add to con
        Err::gassert((coeff_in_con * -def.constant) % coe_v == 0, "Bad substitution");
        con.constant += coeff_in_con * -def.constant / coe_v;
        for (const auto &[def_v, def_coe] : def.coeffs) {
            if (def_v == v)
                continue;
            Err::gassert((coeff_in_con * -def_coe) % coe_v == 0, "Bad substitution");
            con.coeffs[def_v] += coeff_in_con * -def_coe / coe_v;
            if (con.coeffs[def_v] == 0)
                con.coeffs.erase(def_v);
        }
        if (def.kind == ConstraintKind::GE || con.kind == ConstraintKind::GE)
            con.kind = ConstraintKind::GE;
    }
}

// Substitute variable v by integer value val and remove v from V.
void OmegaSolver::substitute(VarID v, CoeT val) {
    if (debug_dump_stream)
        *debug_dump_stream << "Substituting " << VH.name(v) << " = " << val << "\n";

    for (auto it = S.begin(); it != S.end();) {
        auto &con = *it;
        auto itv = con.coeffs.find(v);
        if (itv == con.coeffs.end()) {
            ++it;
            continue;
        }

        CoeT a = itv->second;
        con.constant += a * val;
        con.coeffs.erase(itv);
    }

    V.erase(v);
}

// Eliminate equality constraints following Pugh's method.
// Returns false if we detect unsatisfiable constraint during process.
bool OmegaSolver::eliminateEqualities() {
    // We'll repeatedly scan for equality constraints and eliminate them.
    while (true) {
        // Grab an Eq Constraint
        auto it = std::find_if(S.begin(), S.end(), [](const Constraint &con) { return con.isEq(); });
        if (it == S.end())
            break;
        Constraint C = *it;

        if (C.coeffs.empty()) {
            // unsatisfiable
            if (C.constant != 0)
                return false;

            S.erase(it);
            continue;
        }

        // check for a variable with unit coefficient
        VarID var_unit = BAD_VAR_ID;
        for (auto &[v, a] : C.coeffs) {
            if (a == 1 || a == -1) {
                var_unit = v;
                break;
            }
        }

        if (var_unit != BAD_VAR_ID) {
            substitute(var_unit, C);
            S.erase(it);
            V.erase(var_unit);

            // re-normalize modified constraints
            if (!normalize())
                return false;

            debugDumpPoint("elimEQ: After Unit Round:");
            continue;
        }

        // No unit coefficient found, choose k with the smallest absolute coefficient.
        VarID k = BAD_VAR_ID;
        CoeT ak = 0;
        CoeT smallest_coe = std::numeric_limits<CoeT>::max();
        for (auto &[v, a] : C.coeffs) {
            CoeT a_abs = std::abs(a);
            if (a_abs < smallest_coe) {
                smallest_coe = a_abs;
                k = v;
                ak = a;
            }
        }
        Err::gassert(k != BAD_VAR_ID);

        // We create a new variable σ and produce the constraint:
        //  mσ = sum_{i in V} (ai mod_hat m)xi
        CoeT m = std::abs(ak) + 1;
        VarID sigma = VH.newVar();
        V.insert(sigma);

        // def: m * σ - sum_{i in V} (ai mod_hat m)xi == 0
        Constraint def;
        def.kind = ConstraintKind::EQ;
        def.constant = -int_mod_hat(C.constant, m);
        def.coeffs[sigma] = m;

        for (auto &[v, a] : C.coeffs) {
            CoeT r = int_mod_hat(a, m);
            if (r != 0)
                def.coeffs[v] = -r;
        }

        substitute(k, def);

        // re-normalize modified constraints
        if (!normalize())
            return false;

        debugDumpPoint("elimEQ: After Round:");
    }

    return true;
}

bool OmegaSolver::eliminateInequalities() {
    // First simplify `S` by single-variable constraints.
    while (true) {
        // Known integer bounds for variable in single-variable constraints.
        // This can let us find tight or contradictory pairs of constraints.
        std::map<VarID, CoeT> lower_bound;
        std::map<VarID, CoeT> upper_bound;
        // Collect bounds
        for (auto it = S.begin(); it != S.end();) {
            Constraint &con = *it;

            if (con.coeffs.size() == 1) {
                // single var constraint: a*v + constant >=/== 0
                auto [v, a] = *con.coeffs.begin();
                CoeT c = con.constant;

                // a*v + c >= 0
                if (a > 0) {
                    // v >= ceil(-c / a)
                    CoeT lb = ceil_div(-c, a);
                    auto itlb = lower_bound.find(v);
                    if (itlb == lower_bound.end() || lb > itlb->second)
                        lower_bound[v] = lb;
                    else {
                        // Redundant bounds, remove it.
                        it = S.erase(it);
                        continue;
                    }
                } else {
                    // a < 0: v <= floor(-c / a)
                    CoeT ub = floor_div(-c, a);
                    auto itub = upper_bound.find(v);
                    if (itub == upper_bound.end() || ub < itub->second)
                        upper_bound[v] = ub;
                    else {
                        // Redundant bounds, remove it.
                        it = S.erase(it);
                        continue;
                    }
                }
            }
            ++it;
        }

        bool changed = false;
        // Scan for contradictory and tight pair
        for (auto [v, lb] : lower_bound) {
            auto itub = upper_bound.find(v);
            if (itub == upper_bound.end())
                continue;

            auto ub = itub->second;

            // Contradictory
            if (lb > ub)
                return false;

            // Tight
            if (lb == ub) {
                substitute(v, lb);
                if (!normalize())
                    return false;
                changed = true;
            }
        }
        if (!changed)
            break;
    }

    // If the problem involves at most one variable and has passed the above tests,
    // we report that it has integer solutions.
    if (V.size() <= 1)
        return true;

    // Otherwise, we reduce the problem to one or more integer programming problems in fewer
    // dimensions and repeat the above process, eventually getting to problems in one dimension.
    // TODO: Fourier-Motzkin variable elimination

    return true;
}
} // namespace CSTR