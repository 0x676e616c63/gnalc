#pragma once
#ifndef GNALC_EXPR_SOLVER_EXPR_SIMPLIFY_HPP
#define GNALC_EXPR_SOLVER_EXPR_SIMPLIFY_HPP

#include "expr.hpp"

namespace ExprSolver {

class ExprSimplifier {
    ExprPool *pool;

public:
    explicit ExprSimplifier(ExprPool *pool) : pool(pool) {}

    Expr *rewrite(Expr *expr);

    Expr *simplify(Expr *expr);
};

} // namespace ExprSolver

#endif