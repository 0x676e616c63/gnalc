// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Constraint Elimination
// This pass removes redundant constraints.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_CONSTRAINT_ELIMINATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_CONSTRAINT_ELIMINATION_HPP

#include "constraint/base.hpp"
#include "constraint/omega_test.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/pass_manager.hpp"

namespace IR {
class ConstraintEliminationPass : public PM::PassInfo<ConstraintEliminationPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

    explicit ConstraintEliminationPass(bool with_range_analysis_ = true)
        : with_range_analysis(with_range_analysis_) {}
private:
    bool with_range_analysis = true;

    CSTR::OmegaSolver solver;
    std::unordered_map<pVal, CSTR::VarID> value_to_var;
    DomTree* domtree{};

    CSTR::Expr asExpr(const pVal& val);

    std::optional<CSTR::Constraint> convertIcmp(const pIcmp& icmp, bool negate);
};

} // namespace IR
#endif
