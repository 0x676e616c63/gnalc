#pragma once
#ifndef GNALC_EXPR_SOLVER_EXPR_MATCH_HPP
#define GNALC_EXPR_SOLVER_EXPR_MATCH_HPP

#include "expr.hpp"

#include <functional>

namespace ExprSolver {

template <typename Pattern> bool match(Expr *e, const Pattern &p) { return p.match(e); }

template <typename Pattern, typename... Patterns> bool match(Expr *e, const Pattern &p0, const Patterns &...ps) {
    return match(e, p0) || match(e, ps...);
}

namespace detail {
struct AnyMatch {
    bool match(Expr *) const { return true; }
};

template <typename LHSPattern, typename RHSPattern> struct BinaryMatch {
    LHSPattern lhs;
    RHSPattern rhs;
    Op op;

    BinaryMatch(Op op_, LHSPattern lhs_, RHSPattern rhs_) : lhs(lhs_), rhs(rhs_), op(op_) {}

    bool match(Expr *e) const {
        if (!e->isBinary())
            return false;

        if (e->op() != op)
            return false;

        return lhs.match(e->getLHS()) && rhs.match(e->getRHS());
    }
};

struct PredMatch {
private:
    std::function<bool(Expr *)> predicate;

public:
    explicit PredMatch(std::function<bool(Expr *)> predicate_) : predicate(predicate_) {}

    bool match(Expr *e) const { return predicate(e); }
};

struct Identity {
    template <typename T> auto operator()(T &&v) const { return std::forward<T>(v); }
};

template <typename Result = Expr *, typename Proj = Identity> struct BindMatch {
private:
    Result &expr;
    std::function<bool(Expr *)> predicate;

public:
    explicit BindMatch(Result &expr_) : expr(expr_) {}

    BindMatch(Result &expr_, std::function<bool(Expr *)> predicate_) : expr(expr_), predicate(predicate_) {}

    bool match(Expr *e) const {
        if (predicate && !predicate(e))
            return false;
        expr = Proj()(e);
        return true;
    }
};

template <typename T> struct ConstantProj {
    T operator()(Expr *e) const { return e->getConstVal(); }
};
} // namespace detail

inline auto Bind(Expr *&expr) { return detail::BindMatch(expr); }

inline auto CBind(Expr *&expr) {
    return detail::BindMatch(expr, [](Expr *e) { return e->isConstant(); });
}
inline auto CBind(int &i) {
    return detail::BindMatch<int, detail::ConstantProj<int>>(i, [](Expr *e) { return e->isConstant(); });
}

inline auto Is(const int &i) {
    return detail::PredMatch([&i](Expr *e) { return e->isConstant() && e->getConstVal() == i; });
}

inline auto Is(const Expr *const &e) {
    return detail::PredMatch([&e](Expr *cand) { return cand == e; });
}

inline auto Const() {
    return detail::PredMatch([](Expr *e) { return e->isConstant(); });
}

inline auto Any() { return detail::AnyMatch(); }

#define MAKE_BINARY_MATCH(pattern_name, opcode)                                                                        \
    template <typename LHSP, typename RHSP> auto pattern_name(const LHSP &lhs, const RHSP &rhs) {                      \
        return detail::BinaryMatch(opcode, lhs, rhs);                                                                  \
    }

MAKE_BINARY_MATCH(Add, Op::Add)
MAKE_BINARY_MATCH(Sub, Op::Sub)
MAKE_BINARY_MATCH(Mul, Op::Mul)
MAKE_BINARY_MATCH(Div, Op::Div)
MAKE_BINARY_MATCH(Mod, Op::Mod)

#undef MAKE_BINARY_MATCH

} // namespace ExprSolver

#endif