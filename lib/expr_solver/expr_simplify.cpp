#include "expr_solver/expr_simplify.hpp"
#include "expr_solver/expr.hpp"
#include "expr_solver/expr_match.hpp"

#include <ir/pattern_match.hpp>

namespace ExprSolver {

Expr *ExprSimplifier::simplify(Expr *expr) {

    Expr *before = expr;
    Expr *res = rewrite(expr);
    int cnt = 0;
    while (res != before && cnt <= 20) {
        //FIXME can we reach the fix point?
        before = res;
        res = rewrite(res);
        cnt += 1;
    }
    return res;
}

Expr *ExprSimplifier::rewrite(Expr *expr) {
    Expr *x, *y;
    // variable
    Expr *t1, *t2, *t3, *t4;
    // constant
    Expr *c1, *c2;
    int a, b;

    // 0 + t = t
    // t + 0 = t
    if (match(expr, Add(Is(0), Bind(x)), Add(Bind(x), Is(0))))
        return x;

    // t - 0 = t
    if (match(expr, Sub(Bind(x), Is(0))))
        return x;

    // t / 1 = t
    if (match(expr, Div(Bind(x), Is(1))))
        return x;

    // t * 1 = t
    // 1 * t = t
    if (match(expr, Mul(Bind(x), Is(1)), Mul(Is(1), Bind(x))))
        return x;

    // t - t = 0
    if (match(expr, Sub(Bind(x), Bind(y))) && x == y) {
        return pool->getConstant(0);
    }
    // t * 0 = 0
    // 0 * t = 0
    if (match(expr, Mul(Bind(x), Is(0)), Mul(Is(0), Bind(x))))
        return pool->getConstant(0);
    // 0 / t = 0
    // 0 % t = 0
    // t % 1 = 0
    if (match(expr, Div(Is(0), Bind(x)), Mod(Is(0), Bind(x)), Mod(Bind(x), Is(1))))
        return pool->getConstant(0);
    // R1: c1 + c2 = (c1+c2)
    if (match(expr, Add(Bind(c1), Bind(c2))) && c1->isConstant() && c2->isConstant()) {
        return pool->getConstant(c1->getConstVal() + c2->getConstVal());
    }
    // R2: t + c = c + t
    if (match(expr, Add(Bind(x), Bind(c1))) && c1->isConstant()) {
        return pool->getBinary(Op::Add, c1, x);
    }
    // R3: c1 * c2 = (c1*c2)
    if (match(expr, Mul(Bind(c1), Bind(c2))) && c1->isConstant() && c2->isConstant()) {
        return pool->getConstant(c1->getConstVal() * c2->getConstVal());
    }
    // R4: t * c = c * t
    if (match(expr, Mul(Bind(x), Bind(c1))) && c1->isConstant()) {
        return pool->getBinary(Op::Mul, c1, x);
    }
    // R5: c1 - c2 = (c1-c2)
    if (match(expr, Sub(Bind(c1), Bind(c2))) && c1->isConstant() && c2->isConstant()) {
        return pool->getConstant(c1->getConstVal() - c2->getConstVal());
    }
    // R6: t - c = -c + t
    if (match(expr, Sub(Bind(x), Bind(c1))) && c1->isConstant()) {
        return pool->getBinary(Op::Add, pool->getConstant(-c1->getConstVal()), x);
    }

    // R7: t1 + (t2 + t3) = (t1 + t2) + t3
    if (match(expr, Add(Bind(t1), Add(Bind(t2), Bind(t3))))) {
        Expr *lhs = pool->getBinary(Op::Add, t1, t2);
        return pool->getBinary(Op::Add, lhs, t3);
    }

    // R8: t1 * (t2 * t3) = (t1 * t2) * t3
    // if (match(expr, Mul(Bind(t1), Mul(Bind(t2), Bind(t3))))) {
    //     Expr *lhs = pool->getBinary(Op::Mul, t1, t2);
    //     return pool->getBinary(Op::Mul, lhs, t3);
    // }

    // R9: (c1 + t) + c2 = (c1+c2) + t
    if (match(expr, Add(Add(Bind(c1), Bind(x)), Bind(c2))) && c1->isConstant() && c2->isConstant()) {
        return pool->getBinary(Op::Add, pool->getConstant(c1->getConstVal() + c2->getConstVal()), x);
    }

    // R10: (c1 * t) * c2 = (c1*c2) * t
    if (match(expr, Mul(Mul(Bind(c1), Bind(x)), Bind(c2))) && c1->isConstant() && c2->isConstant()) {
        return pool->getBinary(Op::Mul, pool->getConstant(c1->getConstVal() * c2->getConstVal()), x);
    }
    // ex: c1 * (c2 * t) = (c1*c2) * t
    if (match(expr, Mul(Bind(c1), Mul(Bind(c2), Bind(x)))) && c1->isConstant() && c2->isConstant()) {
        return pool->getBinary(Op::Mul, pool->getConstant(c1->getConstVal() * c2->getConstVal()), x);
    }

    // R11: (c1 + t) * c2 = (c1*c2) + (c2*t)
    if (match(expr, Mul(Add(Bind(c1), Bind(x)), Bind(c2))) && c1->isConstant() && c2->isConstant()) {
        Expr *lhs = pool->getConstant(c1->getConstVal() * c2->getConstVal());
        Expr *rhs = pool->getBinary(Op::Mul, c1, x);
        return pool->getBinary(Op::Add, lhs, rhs);
    }

    // R12: c1 * (c2 + t) = (c1*c2) + (c1*t)
    if (match(expr, Mul(Bind(c1), Add(Bind(c2), Bind(x)))) && c1->isConstant() && c2->isConstant()) {
        Expr *lhs = pool->getConstant(c1->getConstVal() * c2->getConstVal());
        Expr *rhs = pool->getBinary(Op::Mul, c1, x);
        return pool->getBinary(Op::Add, lhs, rhs);
    }

    // R13: (t1 + t2) * c = (c * t1) + (c * t2)
    if (match(expr, Mul(Add(Bind(x), Bind(y)), Bind(c1))) && c1->isConstant()) {
        Expr *lhs = pool->getBinary(Op::Mul, c1, x);
        Expr *rhs = pool->getBinary(Op::Mul, c1, y);
        return pool->getBinary(Op::Add, lhs, rhs);
    }

    // R14: c * (t1 + t2) = (c * t1) + (c * t2)
    if (match(expr, Mul(Bind(c1), Add(Bind(x), Bind(y)))) && c1->isConstant()) {
        Expr *lhs = pool->getBinary(Op::Mul, c1, x);
        Expr *rhs = pool->getBinary(Op::Mul, c1, y);
        return pool->getBinary(Op::Add, lhs, rhs);
    }

    // R15: (t1 - t2) * c = (c * t1) - (c * t2)
    if (match(expr, Mul(Sub(Bind(x), Bind(y)), Bind(c1))) && c1->isConstant()) {
        Expr *lhs = pool->getBinary(Op::Mul, c1, x);
        Expr *rhs = pool->getBinary(Op::Mul, c1, y);
        return pool->getBinary(Op::Sub, lhs, rhs);
    }

    // R16: c * (t1 - t2) = (c * t1) - (c * t2)
    if (match(expr, Mul(Bind(c1), Sub(Bind(x), Bind(y)))) && c1->isConstant()) {
        Expr *lhs = pool->getBinary(Op::Mul, c1, x);
        Expr *rhs = pool->getBinary(Op::Mul, c1, y);
        return pool->getBinary(Op::Sub, lhs, rhs);
    }

    // R17: (t1 + t2) * t3 = (t1 * t3) + (t2 * t3)
    if (match(expr, Mul(Add(Bind(t1), Bind(t2)), Bind(t3)))) {
        Expr *lhs = pool->getBinary(Op::Mul, t1, t3);
        Expr *rhs = pool->getBinary(Op::Mul, t2, t3);
        return pool->getBinary(Op::Add, lhs, rhs);
    }

    // R18: t1 * (t2 + t3) = (t1 * t2) + (t1 * t3)
    if (match(expr, Mul(Bind(t1), Add(Bind(t2), Bind(t3))))) {
        Expr *lhs = pool->getBinary(Op::Mul, t1, t2);
        Expr *rhs = pool->getBinary(Op::Mul, t1, t3);
        return pool->getBinary(Op::Add, lhs, rhs);
    }

    // R19: (t1 - t2) * t3 = (t1 * t3) - (t2 * t3)
    if (match(expr, Mul(Sub(Bind(t1), Bind(t2)), Bind(t3)))) {
        Expr *lhs = pool->getBinary(Op::Mul, t1, t3);
        Expr *rhs = pool->getBinary(Op::Mul, t2, t3);
        return pool->getBinary(Op::Sub, lhs, rhs);
    }

    // R20: t1 * (t2 - t3) = (t1 * t2) - (t1 * t3)
    if (match(expr, Mul(Bind(t1), Sub(Bind(t2), Bind(t3))))) {
        Expr *lhs = pool->getBinary(Op::Mul, t1, t2);
        Expr *rhs = pool->getBinary(Op::Mul, t1, t3);
        return pool->getBinary(Op::Sub, lhs, rhs);
    }

    // (c1 + t1) + (c2 + t2) = (c1+c2) + (t1+t2)
    if (match(expr, Add(Add(Bind(c1), Bind(t1)), Add(Bind(c2), Bind(t2)))) && c1->isConstant() && c2->isConstant()) {
        Expr *lhs = pool->getConstant(c1->getConstVal() + c2->getConstVal());
        Expr *rhs = pool->getBinary(Op::Add, t1, t2);
        return pool->getBinary(Op::Add, lhs, rhs);
    }

    // (c * t1) * t2 = c * (t1 * t2)
    if (match(expr, Mul(Mul(Bind(c1), Bind(t1)), Bind(t2))) && c1->isConstant()) {
        return pool->getBinary(Op::Mul, c1, pool->getBinary(Op::Mul, t1, t2));
    }

    // (c1 * t) / c2 = t / (c2/c1) only when c2/c1 is integer
    if (match(expr, Div(Mul(Bind(c1), Bind(x)), Bind(c2))) && c1->isConstant() && c2->isConstant() && (
            c2->getConstVal() % c1->getConstVal()) == 0) {
        return pool->getBinary(Op::Div, x, pool->getConstant(c2->getConstVal() / c1->getConstVal()));
    }

    // ((t * c2) + c1 ) / c2 -> t + c1 / c2
    if (match(expr, Div(Add(Mul(Bind(x), Bind(c2)), Bind(c1)), Bind(t2))) && c2 == t2 && c2->isConstant() && c1->
        isConstant()) {
        return pool->getBinary(Op::Add, x, pool->getConstant(c1->getConstVal() / c2->getConstVal()));
    }
    // (c1 - t) + c2 = (c1 + c2) - t
    if (match(expr, Add(Sub(Bind(c1), Bind(x)), Bind(c2))) && c1->isConstant() && c2->isConstant()) {
        return pool->getBinary(Op::Sub, pool->getConstant(c1->getConstVal() + c2->getConstVal()), x);
    }

    // c1 - (t + c2) -> (c1 - c2) - t
    if (match(expr, Sub(Bind(c1), Add(Bind(x), Bind(c2)))) && c1->isConstant() && c2->isConstant()) {
        return pool->getBinary(Op::Sub, pool->getConstant(c1->getConstVal() - c2->getConstVal()), x);
    }

    // t + ( _ - t) = _
    if (match(expr, Add(Bind(t1), Sub(Bind(x), Bind(t2)))) && t1 == t2) {
        return x;
    }

    // ( _ - t) + t = _
    if (match(expr, Add(Sub(Bind(x), Bind(t1)), Bind(t2))) && t1 == t2) {
        return x;
    }

    // t1 / (t1 * _ ) -> 1 / _
    if (match(expr, Div(Bind(t1), Mul(Bind(t2), Bind(x)))) && t1 == t2) {
        return pool->getBinary(Op::Div, pool->getConstant(1), x);
    }

    // t1 / ( _ * t1 ) -> 1 / _
    if (match(expr, Div(Bind(t1), Mul(Bind(x), Bind(t2)))) && t1 == t2) {
        return pool->getBinary(Op::Div, pool->getConstant(1), x);
    }

    // (t / c1) / c2  -> t / (c1 * c2)
    if (match(expr, Div(Div(Bind(x), Bind(c1)), Bind(c2))) && c1->isConstant() && c2->isConstant()) {
        return pool->getBinary(Op::Div, x, pool->getConstant(c1->getConstVal() * c2->getConstVal()));
    }

    // (t1 - (t1 % t2)) / t2 -> t1 / t2
    if (match(expr, Div(Sub(Bind(t1), Mod(Bind(x), Bind(t2))), Bind(y))) && t1 == x && t2 == y) {
        return pool->getBinary(Op::Div, t1, t2);
    }

    // (c1 * x) + (c2 * x) -> (c1+c2) * x
    if (match(expr, Add(Mul(Bind(c1), Bind(x)), Mul(Bind(c2), Bind(y)))) && x == y && c1->isConstant() && c2->
        isConstant()) {
        return pool->getBinary(Op::Mul, pool->getConstant(c1->getConstVal() + c2->getConstVal()), x);
    }
    // x + x = 2 * x
    if (match(expr, Add(Bind(x), Bind(y))) && x == y) {
        return pool->getBinary(Op::Mul, pool->getConstant(2), x);
    }
    // c * x + x -> (c+1) * x
    if (match(expr, Add(Mul(Bind(c1), Bind(x)), Bind(y))) && x == y && c1->isConstant()) {
        return pool->getBinary(Op::Mul, pool->getConstant(c1->getConstVal() + 1), x);
    }

    // x + c * x -> (c+1) * x
    if (match(expr, Add(Bind(x), Mul(Bind(c1), Bind(y)))) && x == y && c1->isConstant()) {
        return pool->getBinary(Op::Mul, pool->getConstant(c1->getConstVal() + 1), x);
    }
    // (a + b) - (b + a) = 0
    if (match(expr, Sub(Add(Bind(t1), Bind(t2)), Add(Bind(t3), Bind(t4)))) && t1 == t4 && t2 == t3) {
        return pool->getConstant(0);
    }
    // (x - y) + (y - x) = 0
    if (match(expr, Add(Sub(Bind(t1), Bind(t2)), Sub(Bind(t3), Bind(t4)))) && t1 == t4 && t2 == t3) {
        return pool->getConstant(0);
    }
    //
    // if (match(expr, Mul(Mul(Bind(c1), Bind(x)), Bind(y))) && c1->isConstant()) {
    //     return pool->getBinary(Op::Mul, c1, pool->getBinary(Op::Mul, x, y));
    // }
    // otherwise
    if (expr->isBinary()) {
        t1 = rewrite(expr->getLHS());
        t2 = rewrite(expr->getRHS());
        std::cout << *t1 << " " << *t2 << std::endl;
        return pool->getBinary(expr->op(), t1, t2);
    }
    return expr;
}
} // namespace ExprSolver