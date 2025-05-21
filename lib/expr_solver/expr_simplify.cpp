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
    if (match(expr, Add(CBind(a), CBind(b)))) {
        return pool->getConstant(a + b);
    }
    // R2: t + c = c + t
    if (match(expr, Add(Bind(x), CBind(y)))) {
        return pool->getBinary(Op::Add, y, x);
    }
    // R3: c1 * c2 = (c1 * c2)
    if (match(expr, Mul(CBind(a), CBind(b)))) {
        return pool->getConstant(a * b);
    }
    // R4: t * c = c * t
    if (match(expr, Mul(Bind(x), CBind(c1)))) {
        return pool->getBinary(Op::Mul, c1, x);
    }
    // R5: c1 - c2 = (c1-c2)
    if (match(expr, Sub(CBind(a), CBind(b)))) {
        return pool->getConstant(a - b);
    }
    // R6: t - c = -c + t
    if (match(expr, Sub(Bind(x), CBind(a)))) {
        return pool->getBinary(Op::Add, pool->getConstant(-a), x);
    }

    // R7: t1 + (t2 + t3) = (t1 + t2) + t3
    if (match(expr, Add(Bind(t1), Add(Bind(t2), Bind(t3))))) {
        Expr *lhs = pool->getBinary(Op::Add, t1, t2);
        return pool->getBinary(Op::Add, lhs, t3);
    }

    // R8: t1 * (t2 * t3) = (t1 * t2) * t3
    if (match(expr, Mul(Bind(t1), Mul(Bind(t2), Bind(t3))))) {
        Expr *lhs = pool->getBinary(Op::Mul, t1, t2);
        return pool->getBinary(Op::Mul, lhs, t3);
    }

    // R9: (c1 + t) + c2 = (c1 + c2) + t
    if (match(expr, Add(Add(CBind(a), Bind(x)), CBind(b)))) {
        return pool->getBinary(Op::Add, pool->getConstant(a + b), x);
    }

    // R10: (c1 * t) * c2 = (c1 * c2) * t
    if (match(expr, Mul(Mul(CBind(a), Bind(x)), CBind(b)))) {
        return pool->getBinary(Op::Mul, pool->getConstant(a * b), x);
    }
    // ex: c1 * (c2 * t) = (c1 * c2) * t
    if (match(expr, Mul(CBind(a), Mul(CBind(b), Bind(x))))) {
        return pool->getBinary(Op::Mul, pool->getConstant(a * b), x);
    }

    // R11: (c1 + t) * c2 = (c1 * c2) + (c2 * t)
    if (match(expr, Mul(Add(CBind(a), Bind(x)), CBind(b)))) {
        Expr *lhs = pool->getConstant(a * b);
        Expr *rhs = pool->getBinary(Op::Mul, pool->getConstant(a), x);
        return pool->getBinary(Op::Add, lhs, rhs);
    }

    // R12: c1 * (c2 + t) = (c1 * c2) + (c1*t)
    if (match(expr, Mul(CBind(a), Add(CBind(b), Bind(x))))) {
        Expr *lhs = pool->getConstant(a * b);
        Expr *rhs = pool->getBinary(Op::Mul, pool->getConstant(a), x);
        return pool->getBinary(Op::Add, lhs, rhs);
    }

    // R13: (t1 + t2) * c = (c * t1) + (c * t2)
    if (match(expr, Mul(Add(Bind(x), Bind(y)), CBind(c1)))) {
        Expr *lhs = pool->getBinary(Op::Mul, pool->getConstant(a), x);
        Expr *rhs = pool->getBinary(Op::Mul, c1, y);
        return pool->getBinary(Op::Add, lhs, rhs);
    }

    // R14: c * (t1 + t2) = (c * t1) + (c * t2)
    if (match(expr, Mul(CBind(c1), Add(Bind(x), Bind(y))))) {
        Expr *lhs = pool->getBinary(Op::Mul, c1, x);
        Expr *rhs = pool->getBinary(Op::Mul, c1, y);
        return pool->getBinary(Op::Add, lhs, rhs);
    }

    // R15: (t1 - t2) * c = (c * t1) - (c * t2)
    if (match(expr, Mul(Sub(Bind(x), Bind(y)), CBind(c1)))) {
        Expr *lhs = pool->getBinary(Op::Mul, c1, x);
        Expr *rhs = pool->getBinary(Op::Mul, c1, y);
        return pool->getBinary(Op::Sub, lhs, rhs);
    }

    // R16: c * (t1 - t2) = (c * t1) - (c * t2)
    if (match(expr, Mul(CBind(c1), Sub(Bind(x), Bind(y))))) {
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

    // (c1 + t1) + (c2 + t2) = (c1 + c2) + (t1 + t2)
    if (match(expr, Add(Add(CBind(a), Bind(t1)), Add(CBind(b), Bind(t2))))) {
        Expr *lhs = pool->getConstant(a + b);
        Expr *rhs = pool->getBinary(Op::Add, t1, t2);
        return pool->getBinary(Op::Add, lhs, rhs);
    }

    // (c * t1) * t2 = c * (t1 * t2)
    if (match(expr, Mul(Mul(CBind(c1), Bind(t1)), Bind(t2)))) {
        return pool->getBinary(Op::Mul, c1, pool->getBinary(Op::Mul, t1, t2));
    }

    // (c1 * t) / c2 = t * (c2 / c1) only when c2 / c1 is integer
    if (match(expr, Div(Mul(CBind(a), Bind(x)), CBind(b))) && a % b == 0) {
        return pool->getBinary(Op::Mul, x, pool->getConstant(a / b));
    }

    // ((t * c2) + c1 ) / c2 -> t + c1 / c2
    if (match(expr, Div(Add(Mul(Bind(x), CBind(b)), CBind(a)), Is(b)))) {
        return pool->getBinary(Op::Add, x, pool->getConstant(a / b));
    }
    // (c1 - t) + c2 = (c1 + c2) - t
    if (match(expr, Add(Sub(CBind(a), Bind(x)), CBind(b)))) {
        return pool->getBinary(Op::Sub, pool->getConstant(a + b), x);
    }

    // c1 - (t + c2) -> (c1 - c2) - t
    if (match(expr, Sub(CBind(a), Add(Bind(x), CBind(b))))) {
        return pool->getBinary(Op::Sub, pool->getConstant(a - b), x);
    }

    // t + ( _ - t) = _
    if (match(expr, Add(Bind(t1), Sub(Bind(x), Is(t1))))) {
        return x;
    }

    // ( _ - t) + t = _
    if (match(expr, Add(Sub(Bind(x), Bind(t1)), Is(t1)))) {
        return x;
    }

    // t1 / (t1 * _ ) -> 1 / _
    if (match(expr, Div(Bind(t1), Mul(Is(t1), Bind(x))))) {
        return pool->getBinary(Op::Div, pool->getConstant(1), x);
    }

    // t1 / ( _ * t1 ) -> 1 / _
    if (match(expr, Div(Bind(t1), Mul(Bind(x), Is(t1))))) {
        return pool->getBinary(Op::Div, pool->getConstant(1), x);
    }

    // (t / c1) / c2  -> t / (c1 * c2)
    if (match(expr, Div(Div(Bind(x), CBind(a)), CBind(b)))) {
        return pool->getBinary(Op::Div, x, pool->getConstant(a * b));
    }

    // (t1 - (t1 % t2)) / t2 -> t1 / t2
    if (match(expr, Div(Sub(Bind(t1), Mod(Is(t1), Bind(t2))), Is(t2)))) {
        return pool->getBinary(Op::Div, t1, t2);
    }

    // (c1 * x) + (c2 * x) -> (c1 + c2) * x
    if (match(expr, Add(Mul(CBind(a), Bind(x)), Mul(CBind(b), Is(x))))) {
        return pool->getBinary(Op::Mul, pool->getConstant(a + b), x);
    }
    // x + x = 2 * x
    if (match(expr, Add(Bind(x), Is(x)))) {
        return pool->getBinary(Op::Mul, pool->getConstant(2), x);
    }
    // c * x + x -> (c + 1) * x
    if (match(expr, Add(Mul(CBind(a), Bind(x)), Is(x)))) {
        return pool->getBinary(Op::Mul, pool->getConstant(a + 1), x);
    }

    // x + c * x -> (c + 1) * x
    if (match(expr, Add(Bind(x), Mul(CBind(a), Is(x))))) {
        return pool->getBinary(Op::Mul, pool->getConstant(a + 1), x);
    }
    // (a + b) - (b + a) = 0
    if (match(expr, Sub(Add(Bind(t1), Bind(t2)), Add(Is(t2), Is(t1))))) {
        return pool->getConstant(0);
    }
    // (x - y) + (y - x) = 0
    if (match(expr, Add(Sub(Bind(t1), Bind(t2)), Sub(Is(t2), Is(t1))))) {
        return pool->getConstant(0);
    }
    // (c1 * x) / c2 = (c1 / c2) * x when c1 % c2 == 0
    if (match(expr, Div(Mul(CBind(a), Bind(x)), CBind(b))) && a % b == 0) {
        return pool->getBinary(Op::Mul,pool->getConstant(a / b),x);
    }

    // otherwise
    if (expr->isBinary()) {
        t1 = rewrite(expr->getLHS());
        t2 = rewrite(expr->getRHS());
        return pool->getBinary(expr->op(), t1, t2);
    }
    return expr;
}
} // namespace ExprSolver