// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "constraint/omega_test.hpp"

#include "constraint/base.hpp"
#include "utils/exception.hpp"

#include <algorithm>
#include <limits>
#include <list>
#include <map>
#include <set>
#include <sstream>
#include <vector>

namespace CSTR {
void OmegaSolver::addConstraint(const Constraint &con) {
    for (auto &[var, coe] : con.coeffs)
        V.insert(var);
    S.push_back(con);

    if (debug_dump_stream)
        *debug_dump_stream << "Adding Constraint: " << con.dump(VH) << "\n";
}

void OmegaSolver::reset() {
    S.clear();
    V.clear();
    VH.reset();

    // No need to reset `debug_dump_stream`, they are only used for debugging.
    // debug_dump_stream = nullptr;
}

bool OmegaSolver::mayHasIntSolutions() {
    if (!normalize())
        return false;

    setDebugDumpPoint("Solving:");

    if (!eliminateEqualities()) {
        setDebugDumpPoint("Contradictions found when eliminating equalities:");
        return false;
    }

    if (!eliminateInequalities()) {
        setDebugDumpPoint("Contradictions found when eliminating inequalities:");
        return false;
    }

    setDebugDumpPoint("Problem may has integer solutions:");
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

void OmegaSolver::setDebugDumpPoint(const std::string &msg) {
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

// Eliminate equality constraints.
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

            setDebugDumpPoint("elimEQ: After Unit Round:");
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

        setDebugDumpPoint("elimEQ: After Round:");
    }

    return true;
}

// If the dark and real shadow resulting from each combination of an upper and lower
// bound are identical, the projection is called an exact projection.
// This will happen, for example, if all the coefficients of z in lower bounds on z are 1,
// or if all the coefficients of z in upper bounds on z are -1.
// The projection is also guaranteed to be exact if the only constraints having
// non-unit coefficients produce inequalities of the form a0 >= 0.
bool guaranteedExactProjection(const std::list<Constraint> &S, VarID v) {
    const Constraint *only_one_non_unit = nullptr;
    for (auto &con : S) {
        auto it = con.coeffs.find(v);
        if (it == con.coeffs.end())
            continue;

        if (std::abs(it->second) != 1) {
            if (only_one_non_unit)
                return false;
            only_one_non_unit = &con;
        }
    }

    if (only_one_non_unit)
        return only_one_non_unit->constant >= 0;

    return true;
}

// Eliminate inequality constraint.
// Returns false if we detect unsatisfiable constraint during process.
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

    // Remove subsumed constraints, while searching for contradictions
    while (true) {
        bool changed = false;
        for (const auto &con : S) {
            for (auto it = S.begin(); it != S.end(); ++it) {
                if (&*it == &con)
                    continue;

                if (con.contradict(*it))
                    return false;

                if (con.subsume(*it)) {
                    S.erase(it);
                    changed = true;
                    break;
                }
            }
            if (changed)
                break;
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

    // Eliminate unbounded variables first (variables that have no upper or no lower bound)
    while (true) {
        std::vector<VarID> to_remove;
        for (auto v : V) {
            bool has_pos = false, has_neg = false;
            for (const auto &con : S) {
                auto it = con.coeffs.find(v);
                if (it == con.coeffs.end())
                    continue;
                if (it->second > 0)
                    has_pos = true;
                if (it->second < 0)
                    has_neg = true;
                if (has_pos && has_neg)
                    break;
            }
            // v is unbounded on one side -> drop all constraints involving v
            if (!has_pos || !has_neg)
                to_remove.push_back(v);
        }

        if (to_remove.empty())
            break;

        if (debug_dump_stream) {
            *debug_dump_stream << "Removing unbounded vars:";
            for (auto v : to_remove)
                *debug_dump_stream << " " << VH.name(v);
            *debug_dump_stream << "\n";
        }

        // Performing Fourier-Motzkin elimination on an unbounded variable simply deletes
        // all the constraints involving it.
        for (auto v : to_remove) {
            for (auto it = S.begin(); it != S.end();) {
                if (it->coeffs.find(v) != it->coeffs.end())
                    it = S.erase(it);
                else
                    ++it;
            }
            V.erase(v);
        }
        if (!normalize())
            return false;
    }

    // If we found no multi-variable constraints, the system must have solutions.
    if (V.size() <= 1)
        return true;

    while (V.size() > 1) {
        // 1. We first decide which variable to eliminate. We choose this variable so as to perform
        //    an exact projection if possible, and to minimize the number of constraints resulting from
        //    the combination of upper and lower bounds. If we are forced to perform non-exact reductions,
        //    we choose a variable with coefficients as close to zero as possible.
        //
        // If there are no exact projections, use heuristic below:
        //   heuristic = minimize |P| * |N|, where P for positive constraints (upper bounds) and N for negative.
        VarID pick = BAD_VAR_ID;
        uint64_t best_cost = std::numeric_limits<uint64_t>::max();
        size_t best_pcount = 0, best_ncount = 0;

        bool must_exact_proj = false;
        for (auto v : V) {
            if (guaranteedExactProjection(S, v)) {
                pick = v;
                must_exact_proj = true;

                if (debug_dump_stream)
                    *debug_dump_stream << "Pick " << VH.name(v) << " which has guaranteed exact projection :-)\n";
                break;
            }
            size_t pcount = 0, ncount = 0;
            for (const auto &con : S) {
                auto itv = con.coeffs.find(v);
                if (itv == con.coeffs.end())
                    continue;
                if (itv->second > 0)
                    ++pcount;
                else if (itv->second < 0)
                    ++ncount;
            }
            uint64_t cost = pcount * ncount;
            if (cost < best_cost ||
                (cost == best_cost && std::max(pcount, ncount) < std::max(best_pcount, best_ncount))) {
                best_cost = cost;
                pick = v;
                best_pcount = pcount;
                best_ncount = ncount;
            }
        }

        Err::gassert(pick != BAD_VAR_ID, "No variable picked for elimination");

        // must_exact_proj has logged before.
        if (!must_exact_proj && debug_dump_stream)
            *debug_dump_stream << "Pick " << VH.name(pick) << " with cost " << best_cost << "\n";

        // Partition constraints into P (positive coeff of `pick`), N (negative coeff), Z (no `pick`)
        std::list<Constraint> P_cons, N_cons, Z_cons;
        for (const auto &con : S) {
            auto itv = con.coeffs.find(pick);
            if (itv == con.coeffs.end())
                Z_cons.push_back(con);
            else {
                if (itv->second > 0)
                    P_cons.push_back(con);
                else if (itv->second < 0)
                    N_cons.push_back(con);
                else
                    Err::unreachable("Bad Constraint with zero coeff for " + VH.name(pick));
            }
        }

        // If either P or N empty: `pick` is an unbounded variable.
        // Drop constraints containing `pick`, which simply replaces `S` with `Zcons`.
        if (P_cons.empty() || N_cons.empty()) {
            S = Z_cons;
            V.erase(pick);
            if (!normalize())
                return false;
            setDebugDumpPoint("After eliminating unbounded variable " + VH.name(pick) + ":");
            continue;
        }

        // 2. Calculate the real and dark shadows of the set of constraints along that dimension.

        // Do Fourier-Motzkin variable elimination:
        // Combine every P x N pair
        auto real_shadow = Z_cons;
        auto dark_shadow = Z_cons;
        for (const auto &p : P_cons) {
            CoeT a_p = p.coeffs.at(pick); // > 0
            for (const auto &n : N_cons) {
                CoeT a_n = n.coeffs.at(pick); // < 0

                // multipliers so that `pick` cancels:
                //   mp * p + mn * n -> new constraint without `pick`
                CoeT mp = -a_n;
                CoeT mn = a_p;
                Err::gassert(mp > 0 && mn > 0);

                Constraint combined = p * mp + n * mn;

                // At this point, `combined` is in real shadow, so if it is already contradictory,
                // there can't be integer solutions.
                if (!combined.normalize()) {
                    if (debug_dump_stream) {
                        *debug_dump_stream << "Contradiction found in real shadow during elimination of "
                                           << VH.name(pick) << ":\n";
                        *debug_dump_stream << "Combining '" << p.dump(VH) << "' and '" << n.dump(VH) << "' and got '"
                                           << combined.dump(VH) << "'\n";
                    }
                    return false;
                }

                if (!combined.isTriviallyTrue())
                    real_shadow.push_back(combined);

                // Don't bother with projections that are guaranteed to be exact.
                // Dark shadows for them is the same as real shadows.
                if (must_exact_proj)
                    continue;

                // Now build `combined` for dark shadow.
                // Here we reuse `combined` since it has been copied to `real_shadow`.
                //
                // Paper's dark criterion (for a pair of upper and lower bounds):
                //   dark holds if bα − aβ ≥ (a − 1)(b − 1)
                // In our implementation,
                //   - `mp`: `a` (multiplier of an upper bound)
                //   - `mn`: `b` (multiplier of a lower bound)
                //   - `combined`: `b * alpha - a * beta`
                //
                // Thus, the criterion is
                //   combined >= (mp - 1) * (mn - 1)  ---> combined - (mp - 1) * (mn - 1) >= 0

                combined.constant -= (mp - 1) * (mn - 1);

                // Now `combined` is in dark shadow, so contradiction doesn't mean no
                // integer solutions, since there can be solutions between dark and real shadows.
                // Anyway, add it to the set, we'll handle them later.
                if (!combined.normalize()) {
                    if (debug_dump_stream) {
                        *debug_dump_stream << "Contradiction found in dark shadow during elimination of "
                                           << VH.name(pick) << ":\n";
                        *debug_dump_stream << "Combining '" << p.dump(VH) << "' and '" << n.dump(VH)
                                           << "', and sub offset " << (mp - 1) * (mn - 1) << ", got '"
                                           << combined.dump(VH) << "'\n";
                    }
                }

                if (!combined.isTriviallyTrue())
                    dark_shadow.push_back(combined);
            }
        }

        // 3. If the real and dark shadows are identical, there are integer solutions to the original
        //    set of constraints iff there are integer solutions to the shadow.
        //
        // `real_shadow == dark_shadow` can happen if during every round of elimination,
        // (mp - 1) * (mn - 1) == 0. This might not be captured by `must_exact_proj`.
        // Besides, the real shadow and dark shadow are build together, thus the order of constraints
        // are identical. So a std::list compare is enough.
        if (must_exact_proj || real_shadow == dark_shadow) {
            // Don't use dark_shadow here, they're empty by design for performance.
            S = std::move(real_shadow);
            V.erase(pick);
            if (!normalize())
                return false;
            setDebugDumpPoint("After Fourier-Motzkin elimination round (exact projection):");
            continue;
        }

        // 4. Otherwise:

        // (a) If there are no integer solutions to the real shadow, we know there are no integer
        //     solutions to the original set of constraints.

        // Build tmp solver for real shadow
        OmegaSolver real_shadow_solver = *this;
        real_shadow_solver.S = std::move(real_shadow);
        real_shadow_solver.V.erase(pick);
        // no integer solutions to the real shadow
        if (!real_shadow_solver.normalize())
            return false;

        // (b) If there are integer solutions to the dark shadow, we know there are integer
        //     solutions to the original constraints.
        OmegaSolver dark_shadow_solver = *this;
        dark_shadow_solver.S = std::move(dark_shadow);
        dark_shadow_solver.V.erase(pick);

        if (!dark_shadow_solver.normalize()) {
            if (debug_dump_stream)
                *debug_dump_stream << "Dark shadow has no integer solutions. :(\n";
        } else if (dark_shadow_solver.V.size() <= 1 || dark_shadow_solver.mayHasIntSolutions())
            return true;

        // (c) Otherwise, we know if an integer solution exists, it must be closely nestled
        //     between an upper bound and a lower bound. Therefore, we consider a set of planes
        //     that are parallel to a lower bound and close to a lower bound. Any integer solution
        //     closely nestled between an upper bound and a lower bound must lie on one of these planes.
        //     Computationally, we analyze the problem as follows:
        //     We know that if there exists an integer solution to the original set of constraints,
        //     there must exist a pair of constraints α ≥ az and bz ≥ β on z such that
        //                     ab − a − b ≥ bα − aβ ≥ 0 ∧ bα ≥ abz ≥ aβ
        //                          ab − a − b + aβ ≥ abz ≥ aβ
        //     We check this by determining the largest coefficient a of z in any upper bound on z,
        //     and, for each lower bound bz ≥ β on z, testing if there are integer solutions to the
        //     original problem combined with bz = β + i for each i such that (ab − a − b)/a ≥ i ≥ 0.

        CoeT largest_coe = 0; // the largest coefficient a of z
        for (const auto &n : N_cons)
            largest_coe = std::max(largest_coe, std::abs(n.coeffs.at(pick)));
        Err::gassert(largest_coe != 0, "Bad Constraints: largest_coe == 0");

        // For each lower bound bz ≥ β
        for (const auto &p : P_cons) {
            CoeT b = p.coeffs.at(pick);                         // > 0
            CoeT numerator = largest_coe * b - largest_coe - b; // ab - a - b
            CoeT i_upper_bound = numerator / largest_coe;       // (ab - a - b) / a
            for (CoeT i = 0; i <= i_upper_bound; ++i) {
                OmegaSolver sub_solver = *this;

                // Construct subproblem: original constraints + "b * pick == beta + i"
                Constraint eq = p;
                eq.kind = ConstraintKind::EQ;
                // shift constant to construct "beta + i"
                eq.constant -= i;

                sub_solver.S.push_back(eq);
                if (!sub_solver.normalize())
                    continue;
                if (sub_solver.mayHasIntSolutions())
                    return true;
            }
        }

        if (debug_dump_stream)
            *debug_dump_stream << "No integer solution found.\n";
        // If none of the above found a solution, the problem has no integer solution.
        return false;
    }

    return true;
}
} // namespace CSTR