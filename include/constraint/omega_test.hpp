// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// The Omega Test
//
// Reference:
//   - "The Omega test: A fast and practical integer programming algorithm for dependence analysis"
//       https://ieeexplore.ieee.org/document/5348959
//       expanded version: https://www.cs.utexas.edu/~pingali/CS380C/2025/papers/pugh92omega.pdf
//   - 《多面体编译理论与深度学习实践》 3.4.4 Omega 测试
//   - The Omega Project: https://github.com/davewathaverford/the-omega-project
//   - Kraks/omega: https://github.com/Kraks/omega
#pragma once
#ifndef GNALC_CONSTRAINT_OMEGA_TEST_HPP
#define GNALC_CONSTRAINT_OMEGA_TEST_HPP

#include "constraint/base.hpp"
#include "utils/exception.hpp"

#include <list>
#include <set>
#include <sstream>
#include <vector>

namespace CSTR {
// This function is extracted from Kraks/omega:
//   https://github.com/Kraks/omega/blob/master/src/main/scala/omega/Omega.scala#L45
// It is not the same as the one in The Omega Project (https://github.com/davewathaverford/the-omega-project)
// But its behavior matches the paper better. (See Figure 1: Example of elimination of equality constraints)
static CoeT int_mod_hat(CoeT a, CoeT b) {
    auto r = a - b * int_div(a, b);
    if (r >= -(r-b))
        return r - b;
    return r;
}

static CoeT floor_div(CoeT a, CoeT b) {
    Err::gassert(b != 0, "division by zero");
    if (b > 0)
        return int_div(a, b);
    return int_div(-a, -b);
}

static CoeT ceil_div(CoeT a, CoeT b) {
    return -floor_div(-a, b);
}

class OmegaSolver {
    std::list<Constraint> S;
    std::set<VarID> V;

    std::ostream *debug_dump_stream = nullptr;

public:
    VarHandle VH;

    void addConstraint(const Constraint &con);

    void addConstraints(const std::vector<Constraint> &constraints);

    bool mayHasIntSolutions();

    void dump(std::ostream &os);
    std::string dump();
    void debugDumpPoint(const std::string &msg = "");
    void enableDebugDump(std::ostream &os);

private:
    bool normalize();

    // Substitute variable v with def
    void substitute(VarID v, const Constraint &def);

    // Substitute variable v by integer value val and remove v from V.
    void substitute(VarID v, CoeT val);

    // Eliminate equality constraints following Pugh's method.
    // Returns false if we detect unsatisfiable constraint during process.
    bool eliminateEqualities();

    bool eliminateInequalities();
};
} // namespace CSTR

#endif
