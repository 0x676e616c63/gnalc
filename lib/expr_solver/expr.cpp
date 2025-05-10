#include "expr_solver/expr.hpp"

namespace ExprSolver {
std::ostream &operator<<(std::ostream &os, const Expr &expr) {
    if (expr.isSym())
        os << expr.getSymID();
    else if (expr.isConstant())
        os << expr.getConstVal();
    else if (expr.isBinary()) {
        std::string opstr;
        switch (expr.op()) {
        case Op::Add:
            opstr = "+";
            break;
        case Op::Sub:
            opstr = "-";
            break;
        case Op::Mul:
            opstr = "*";
            break;
        case Op::Div:
            opstr = "/";
            break;
        case Op::Mod:
            opstr = "%";
            break;
        }
        os << "(" << *expr.getLHS() << " " << opstr << " " << *expr.getRHS() << ")";
    }
    return os;
}

Expr *ExprPool::getConstant(int value) {
    Expr e(value);
    return getFromPool(&e);
}
Expr *ExprPool::getSymbol(const std::string &id) {
    Expr e(id);
    return getFromPool(&e);
}

Expr *ExprPool::getBinary(Op op, Expr *lhs, Expr *rhs) {
    Expr e(op, lhs, rhs);
    return getFromPool(&e);
}

Expr *ExprPool::getFromPool(Expr *e) {
    auto it = index.find(e);
    if (it != index.end())
        return *it;
    pool.emplace_back(std::make_unique<Expr>(*e));
    return pool.back().get();
}
} // namespace ExprSolver