#include "expr_solver/expr_simplify.hpp"
#include "expr_solver/expr.hpp"

namespace ExprSolver {

Expr *ExprSimplifier::simplify(Expr *expr) {

    Expr *before = expr;
    Expr *res = match(expr);
    int cnt = 0;
    while (res != before && cnt <= 20) {
        //FIXME can we reach the fix point?
        before = res;
        res = match(res);
        cnt += 1;
    }
    return res;
}

Expr *ExprSimplifier::match(Expr *expr) {

    // 0 + t = t
    if (expr->isBinary() && expr->op() == Op::Add && expr->getLHS()->isConstant() && expr->getLHS()->getConstVal() ==
        0) {
        return expr->getRHS();
    }
    // t + 0 = t
    if (expr->isBinary() && expr->op() == Op::Add && expr->getRHS()->isConstant() && expr->getRHS()->getConstVal() ==
        0) {
        return expr->getLHS();
    }
    // t - 0 = t
    if (expr->isBinary() && expr->op() == Op::Sub && expr->getRHS()->isConstant() && expr->getRHS()->getConstVal() ==
        0) {
        return expr->getLHS();
    }
    // t / 1 = t
    if (expr->isBinary() && expr->op() == Op::Div && expr->getRHS()->isConstant() && expr->getRHS()->getConstVal() == 1) {
        return expr->getLHS();
    }
    // t * 1 = t
    if (expr->isBinary() && expr->op() == Op::Mul && expr->getRHS()->isConstant() && expr->getRHS()->getConstVal() == 1) {
        return expr->getLHS();
    }
    // 1 * t = t
    if (expr->isBinary() && expr->op() == Op::Mul && expr->getLHS()->isConstant() && expr->getLHS()->getConstVal() == 1) {
        return expr->getRHS();
    }
    // t - t = 0
    if (expr->isBinary() && expr->op() == Op::Sub && expr->getLHS() == expr->getRHS()) {
        return pool->getConstant(0);
    }
    // t * 0 = 0
    if (expr->isBinary() && expr->op() == Op::Mul && expr->getRHS()->isConstant() && expr->getRHS()->getConstVal() == 0) {
        return pool->getConstant(0);
    }
    // 0 * t = 0
    if (expr->isBinary() && expr->op() == Op::Mul && expr->getLHS()->isConstant() && expr->getLHS()->getConstVal() == 0) {
        return pool->getConstant(0);
    }
    // 0 / t = 0
    if (expr->isBinary() && expr->op() == Op::Div && expr->getLHS()->isConstant() && expr->getLHS()->getConstVal() == 0) {
        return pool->getConstant(0);
    }
    // 0 % t = 0
    if (expr->isBinary() && expr->op() == Op::Mod && expr->getLHS()->isConstant() && expr->getLHS()->getConstVal() == 0) {
        return pool->getConstant(0);
    }
    // t % 1 = 0
    if (expr->isBinary() && expr->op() == Op::Div && expr->getRHS()->isConstant() && expr->getRHS()->getConstVal() == 1) {
        return pool->getConstant(0);
    }
    // R1: c1 + c2 = (c1+c2)
    if (expr->isBinary() && expr->getLHS()->isConstant() && expr->getRHS()->isConstant() && expr->op() == Op::Add) {
        return pool->getConstant(expr->getLHS()->getConstVal() + expr->getRHS()->getConstVal());
    }
    // R2: t + c = c + t
    if (expr->isBinary() && expr->getRHS()->isConstant() && expr->op() == Op::Add) {
        return pool->getBinary(Op::Add, expr->getRHS(), expr->getLHS());
    }
    // R3: c1 * c2 = (c1*c2)
    if (expr->isBinary() && expr->getLHS()->isConstant() && expr->getRHS()->isConstant() && expr->op() == Op::Mul) {
        return pool->getConstant(expr->getLHS()->getConstVal() * expr->getRHS()->getConstVal());
    }
    // R4: t * c = c * t
    if (expr->isBinary() && expr->getRHS()->isConstant() && expr->op() == Op::Mul) {
        return pool->getBinary(Op::Mul, expr->getRHS(), expr->getLHS());
    }
    // R5: c1 - c2 = (c1-c2)
    if (expr->isBinary() && expr->getLHS()->isConstant() && expr->getRHS()->isConstant() && expr->op() == Op::Sub) {
        return pool->getConstant(expr->getLHS()->getConstVal() - expr->getRHS()->getConstVal());
    }
    // R6: t - c = -c + t
    if (expr->isBinary() && expr->getRHS()->isConstant() && expr->op() == Op::Sub) {
        return pool->getBinary(Op::Add, pool->getConstant(-expr->getRHS()->getConstVal()), expr->getLHS());
    }
    // R7: t1 + (t2 + t3) = (t1 + t2) + t3
    if (expr->isBinary() && expr->getRHS()->isBinary() && expr->op() == Op::Add && expr->getRHS()->op() == Op::Add) {
        Expr *t3 = match(expr->getRHS()->getRHS());
        Expr *t1_add_t2 = match(pool->getBinary(Op::Add, expr->getLHS(), expr->getRHS()->getLHS()));
        return pool->getBinary(Op::Add, t1_add_t2, t3);
    }

    // R8: t1 * (t2 * t3) = (t1 * t2) * t3
    if (expr->isBinary() && expr->getRHS()->isBinary() && expr->op() == Op::Mul && expr->getRHS()->op() == Op::Mul) {
        Expr *t3 = match(expr->getRHS()->getRHS());
        Expr *t1_mul_t2 = match(pool->getBinary(Op::Mul, expr->getLHS(), expr->getRHS()->getLHS()));
        return pool->getBinary(Op::Mul, t1_mul_t2, t3);
    }

    // R9: (c1 + t) + c2 = (c1+c2) + t
    if (expr->isBinary() && expr->getLHS()->isBinary() && expr->getLHS()->op() == Op::Add && expr->getLHS()->getLHS()->
        isConstant() && expr->getRHS()->isConstant()) {
        Expr *c = pool->getConstant(expr->getLHS()->getLHS()->getConstVal() + expr->getRHS()->getConstVal());
        return pool->getBinary(Op::Add, c, expr->getLHS()->getRHS());
    }

    // R10: (c1 * t) * c2 = (c1*c2) * t
    if (expr->isBinary() && expr->getLHS()->isBinary() && expr->getLHS()->op() == Op::Mul && expr->op() == Op::Mul &&
        expr->getLHS()->getLHS()->
        isConstant() && expr->getRHS()->isConstant()) {
        Expr *c = pool->getConstant(expr->getLHS()->getLHS()->getConstVal() * expr->getRHS()->getConstVal());
        return pool->getBinary(Op::Mul, c, expr->getLHS()->getRHS());
    }

    // R11: (c1 + t) * c2 = (c1*c2) + (c2*t)
    if (expr->isBinary() && expr->getLHS()->isBinary() && expr->getLHS()->op() == Op::Add && expr->getRHS()->
        isConstant()) {
        Expr *c = pool->getConstant(expr->getLHS()->getLHS()->getConstVal() * expr->getRHS()->getConstVal());
        Expr *t = pool->getBinary(Op::Mul, expr->getLHS()->getLHS(), expr->getLHS()->getRHS());
        return pool->getBinary(Op::Add, c, t);
    }
    // R12: c1 * (c2 + t) = (c1*c2) + (c1*t)
    if (expr->isBinary() && expr->getLHS()->isConstant() && expr->getRHS()->isBinary() && expr->getRHS()->op() ==
        Op::Add) {
        Expr *c = pool->getConstant(expr->getLHS()->getConstVal() * expr->getRHS()->getLHS()->getConstVal());
        Expr *t = pool->getBinary(Op::Mul, expr->getLHS(), expr->getRHS()->getRHS());
        return pool->getBinary(Op::Add, c, t);
    }
    // R13: (t1 + t2) * c = (c * t1) + (c * t2)
    if (expr->isBinary() && expr->getLHS()->isBinary() && expr->getLHS()->op() == Op::Add && expr->getRHS()->
        isConstant() && expr->op() == Op::Mul) {
        Expr *lhs_expr = pool->getBinary(Op::Mul, expr->getRHS(), expr->getLHS()->getLHS());
        Expr *rhs_expr = pool->getBinary(Op::Mul, expr->getRHS(), expr->getLHS()->getRHS());
        return pool->getBinary(Op::Add, lhs_expr, rhs_expr);
    }

    // R14: c * (t1 + t2) = (c * t1) + (c * t2)
    if (expr->isBinary() && expr->getLHS()->isConstant() && expr->getRHS()->isBinary() && expr->getRHS()->op() ==
        Op::Add) {
        Expr *lhs_expr = pool->getBinary(Op::Mul, expr->getLHS(), expr->getRHS()->getLHS());
        Expr *rhs_expr = pool->getBinary(Op::Mul, expr->getLHS(), expr->getRHS()->getRHS());
        return pool->getBinary(Op::Add, lhs_expr, rhs_expr);
    }
    // R15: (t1 - t2) * c = (c * t1) - (c * t2)
    if (expr->isBinary() && expr->getLHS()->isBinary() && expr->getLHS()->op() == Op::Sub && expr->getRHS()->
        isConstant()) {
        Expr *lhs_expr = pool->getBinary(Op::Mul, expr->getRHS(), expr->getLHS()->getLHS());
        Expr *rhs_expr = pool->getBinary(Op::Mul, expr->getRHS(), expr->getLHS()->getRHS());
        return pool->getBinary(Op::Sub, lhs_expr, rhs_expr);
    }
    // R16: c * (t1 - t2) = (c * t1) - (c * t2)
    if (expr->isBinary() && expr->getLHS()->isConstant() && expr->getRHS()->isBinary() && expr->getRHS()->op() ==
        Op::Sub) {
        Expr *lhs_expr = pool->getBinary(Op::Mul, expr->getLHS(), expr->getRHS()->getLHS());
        Expr *rhs_expr = pool->getBinary(Op::Mul, expr->getLHS(), expr->getRHS()->getRHS());
        return pool->getBinary(Op::Sub, lhs_expr, rhs_expr);
    }
    // R17: (t1 + t2) * t3 = (t1 * t3) + (t2 * t3)
    if (expr->isBinary() && expr->getLHS()->isBinary() && expr->op() == Op::Mul && expr->getLHS()->op() == Op::Add) {
        Expr *lhs_expr = pool->getBinary(Op::Mul, expr->getLHS()->getLHS(), expr->getRHS());
        Expr *rhs_expr = pool->getBinary(Op::Mul, expr->getLHS()->getRHS(), expr->getRHS());
        return pool->getBinary(Op::Add, lhs_expr, rhs_expr);
    }
    // R18: t1 * (t2 + t3) = (t1 * t2) + (t1 * t3)
    if (expr->isBinary() && expr->getRHS()->isBinary() && expr->op() == Op::Mul && expr->getRHS()->op() == Op::Add) {
        Expr *lhs_expr = pool->getBinary(Op::Mul, expr->getLHS(), expr->getRHS()->getLHS());
        Expr *rhs_expr = pool->getBinary(Op::Mul, expr->getLHS(), expr->getRHS()->getRHS());
        return pool->getBinary(Op::Add, lhs_expr, rhs_expr);
    }
    // R19: (t1 - t2) * t3 = (t1 * t3) - (t2 * t3)
    if (expr->isBinary() && expr->getLHS()->isBinary() && expr->op() == Op::Mul && expr->getLHS()->op() == Op::Sub) {
        Expr *lhs_expr = pool->getBinary(Op::Mul, expr->getLHS()->getLHS(), expr->getRHS());
        Expr *rhs_expr = pool->getBinary(Op::Mul, expr->getLHS()->getRHS(), expr->getRHS());
        return pool->getBinary(Op::Sub, lhs_expr, rhs_expr);
    }
    // R20: t1 * (t2 - t3) = (t1 * t2) - (t1 * t3)
    if (expr->isBinary() && expr->getRHS()->isBinary() && expr->op() == Op::Mul && expr->getRHS()->op() == Op::Sub) {
        Expr *lhs_expr = pool->getBinary(Op::Mul, expr->getLHS(), expr->getRHS()->getLHS());
        Expr *rhs_expr = pool->getBinary(Op::Mul, expr->getLHS(), expr->getRHS()->getRHS());
        return pool->getBinary(Op::Sub, lhs_expr, rhs_expr);
    }
    // (c1 + t1) + (c2 + t2) = (c1+c2) + (t1+t2)
    if (expr->isBinary() && expr->getLHS()->isBinary() && expr->getRHS()->isBinary() && expr->getLHS()->op() == Op::Add
        && expr->getLHS()->getLHS()->isConstant() && expr->getRHS()->getLHS()->isConstant() && expr->getLHS()->op() ==
        Op::Add && expr->getRHS()->op() == Op::Add) {
        Expr *c = pool->getConstant(expr->getLHS()->getLHS()->getConstVal() + expr->getRHS()->getLHS()->getConstVal());
        Expr *t = pool->getBinary(Op::Add, expr->getLHS()->getRHS(), expr->getRHS()->getRHS());
        return pool->getBinary(Op::Add, c, t);
    }

    // (c * t1) * t2 = c * (t1 * t2)
    if (expr->isBinary() && expr->getLHS()->isBinary() && expr->getLHS()->op() == Op::Mul && expr->op() == Op::Mul &&
        expr->getLHS()->getLHS()->isConstant()) {
        return pool->getBinary(Op::Mul, expr->getLHS()->getLHS(),
                               pool->getBinary(Op::Mul, expr->getLHS()->getRHS(), expr->getRHS()));
    }
    // (c * t) / c2 = t / (c2/c1) only when c2/c1 is integer
    if (expr->isBinary() && expr->getLHS()->isBinary() && expr->getLHS()->op() == Op::Mul && expr->op() == Op::Div &&
        expr->getLHS()->getLHS()->isConstant() && expr->getRHS()->isConstant()) {
        if (expr->getRHS()->getConstVal() % expr->getLHS()->getLHS()->getConstVal() == 0) {
            return pool->getBinary(Op::Div, expr->getLHS()->getRHS(),
                                   pool->getConstant(
                                       expr->getRHS()->getConstVal() / expr->getLHS()->getLHS()->getConstVal()));
        }
    }
    // (c1 - t) + c2 = (c1 + c2) - t
    if (expr->isBinary() && expr->op() == Op::Add && expr->getLHS()->isBinary() && expr->getLHS()->op() == Op::Sub &&
        expr->getLHS()->getLHS()->isConstant() && expr->getRHS()->isConstant()) {
        Expr *c = pool->getConstant(expr->getLHS()->getLHS()->getConstVal() + expr->getRHS()->getConstVal());
        return pool->getBinary(Op::Sub, c, expr->getLHS()->getRHS());
    }
    // c1 - (t + c2) -> (c1 - c2) - t
    if (expr->isBinary() && expr->op() == Op::Sub && expr->getRHS()->isBinary() && expr->getRHS()->op() == Op::Add &&
        expr->getLHS()->isConstant() && expr->getRHS()->getRHS()->isConstant()) {
        Expr *c = pool->getConstant(expr->getLHS()->getConstVal() - expr->getRHS()->getRHS()->getConstVal());
        return pool->getBinary(Op::Sub, c, expr->getRHS()->getLHS());
    }
    // t + ( _ - t) = t
    if (expr->isBinary() && expr->op() == Op::Add && expr->getRHS()->isBinary() && expr->getRHS()->op() == Op::Sub &&
        expr->getLHS() == expr->getRHS()->getRHS()) {
        return expr->getRHS()->getLHS();
    }
    // ( _ - t) + t = _
    if (expr->isBinary() && expr->op() == Op::Add && expr->getLHS()->isBinary() && expr->getLHS()->op() == Op::Sub &&
        expr->getRHS() == expr->getLHS()->getRHS()) {
        return expr->getLHS()->getLHS();
    }
    // t1 / (t1 * _ ) -> 1 / _
    if (expr->isBinary() && expr->op() == Op::Div && expr->getRHS()->isBinary() && expr->getRHS()->op() == Op::Mul &&
        expr->getRHS()->getLHS() == expr->getLHS()) {
        return pool->getBinary(Op::Div, pool->getConstant(1), expr->getRHS()->getRHS());
    }
    // t1 / ( _ * t1 ) -> 1 / _
    if (expr->isBinary() && expr->op() == Op::Div && expr->getRHS()->isBinary() && expr->getRHS()->op() == Op::Mul &&
        expr->getRHS()->getRHS() == expr->getLHS()) {
        return pool->getBinary(Op::Div, pool->getConstant(1), expr->getRHS()->getLHS());
    }
    // (t / c1) / c2  -> t / (c1 * c2)
    if (expr->isBinary() && expr->op() == Op::Div && expr->getLHS()->isBinary() && expr->getLHS()->op() == Op::Div &&
        expr->getLHS()->getRHS()->isConstant() && expr->getRHS()->isConstant()) {
        Expr *c = pool->getConstant(expr->getLHS()->getRHS()->getConstVal() * expr->getRHS()->getConstVal());
        return pool->getBinary(Op::Div, expr->getLHS()->getLHS(), c);
    }
    // ((t * c2) + c1 ) / c2 -> t + c1 / c2
    if (expr->isBinary() && expr->op() == Op::Div && expr->getLHS()->isBinary() && expr->getLHS()->op() == Op::Add &&
        expr->getLHS()->getLHS()->isBinary() && expr->getLHS()->getLHS()->op() == Op::Mul
        && expr->getRHS() == expr->getLHS()->getLHS()->getRHS() && expr->getLHS()->getLHS()->getRHS()->isConstant() &&
        expr->getLHS()->getRHS()->isConstant()) {
        Expr *c = pool->getConstant(expr->getLHS()->getRHS()->getConstVal() / expr->getRHS()->getConstVal());
        return pool->getBinary(
            Op::Div, pool->getBinary(Op::Add, expr->getLHS()->getLHS()->getLHS(), expr->getLHS()->getRHS()), c);
    }
    // (t1 - (t1 % t2)) / t2 -> t1 / t2
    if (expr->isBinary() && expr->op() == Op::Div && expr->getLHS()->isBinary() && expr->getLHS()->op() == Op::Sub &&
        expr->getLHS()->getRHS()->isBinary() && expr->getLHS()->getRHS()->op() == Op::Mod && expr->getRHS() == expr->
        getLHS()->getRHS()->getRHS()
        && expr->getLHS()->getLHS() == expr->getLHS()->getRHS()->getLHS()) {
        return pool->getBinary(Op::Div, expr->getLHS()->getLHS(), expr->getRHS());
    }
    // otherwise
    if (expr->isBinary()) {
        Expr *t1 = match(expr->getLHS());
        Expr *t2 = match(expr->getRHS());
        return pool->getBinary(expr->op(), t1, t2);
    }
    return expr;
}
} // namespace ExprSolver