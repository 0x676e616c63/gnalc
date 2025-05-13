#include "expr_solver/expr.hpp"
#include "expr_solver/expr_parser.hpp"
#include "expr_solver/expr_simplify.hpp"

#include <iostream>

using namespace ExprSolver;

void test_expr(ExprPool *epool) {

    auto x = epool->getSymbol("x");
    auto y = epool->getSymbol("y");
    auto c1 = epool->getConstant(1);
    auto c2 = epool->getConstant(2);
    auto x_add_1 = epool->getBinary(Op::Add, x, c1);
    auto y_sub_2 = epool->getBinary(Op::Sub, y, c2);
    auto x_add_1_add_y_sub_2 = epool->getBinary(Op::Add, x_add_1, y_sub_2);

    ExprSimplifier esim(epool);

    std::cout << "x + 1 + y - 2:\nBefore Simplify: " << *x_add_1_add_y_sub_2
              << "\nAfter Simplify:" << *esim.simplify(x_add_1_add_y_sub_2) << std::endl;
}

int main() {
    ExprPool epool;

    test_expr(&epool);
    // x,y,z for single-char symbol
    // {pi} for multiple-char symbol
    ExprParser eparser(&epool);
    ExprSimplifier esim(&epool);
    auto parsed = eparser.parse("2x + 3 * yz * {pi} / 6");
    auto simplified = esim.simplify(parsed);
    std::cout << "Parsed Expr: " << *parsed << "\nAfter Simplify: " << *simplified << std::endl;
    auto parsed1 = eparser.parse("2 * x * 3 * y");
    auto simplified1 = esim.simplify(parsed1);
    std::cout << "Parsed Expr: " << *parsed1 << "\nAfter Simplify: " << *simplified1 << std::endl;

    return 0;
}
