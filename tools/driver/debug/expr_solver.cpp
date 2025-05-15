#include "expr_solver/expr.hpp"
#include "expr_solver/expr_parser.hpp"
#include "expr_solver/expr_simplify.hpp"

#include <iostream>

using namespace ExprSolver;

struct TestCase {
    std::string raw;
    std::string expected;
};

int main() {
    ExprPool epool;
    // x,y,z for single-char symbol
    // {pi} for multiple-char symbol
    ExprParser eparser(&epool);
    ExprSimplifier esim(&epool);

    std::vector<TestCase> testcases = {
        {"x * 0", "0"},
        {"0 / x", "0"},
        {"x / 1", "x"},
        {"(x + 0) * y", "xy"},
        {"-x + x", "0"},
        {"2 * x + 3 * x", "5x"},
        {"x + x + x", "3x"},
        {"2 * y + 3 * y", "5y"},
        {"3 + 5", "8"},
        {"2 * (3 + 4)", "14"},
        {"(a + b) - (b + a)", "0"},
        {"(x - y) + (y - x)", "0"},
        {"(x * 7) * 9 / 7 - x * 9", "0"},
        {"2 * x * 3 * y", "6(xy)"}, // TODO, (6x)y, 6xy and 6(xy)
        {"x + 1 - 1", "x"},
    };

    size_t failed_cnt = 0;
    for (const auto &[raw, expected] : testcases) {
        auto raw_expr = eparser.parse(raw);
        auto simplified = esim.simplify(raw_expr);
        auto expected_expr = eparser.parse(expected);
        if (simplified != expected_expr) {
            ++failed_cnt;
            std::cout << "Failed on '" << raw << "'" << std::endl;
            std::cout << "Expected: '" << *expected_expr << "'" << std::endl;
            std::cout << "Got: '" << *simplified << "'" << std::endl;
            std::cout << "---------------------------" << std::endl;
        }
    }
    if (failed_cnt > 0) {
        std::cout << failed_cnt << " tests failed" << std::endl;
        return 1;
    }
    std::cout << "All tests passed" << std::endl;
    return 0;
}