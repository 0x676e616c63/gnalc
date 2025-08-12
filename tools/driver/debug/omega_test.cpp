// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "constraint/omega_test.hpp"

#include "constraint/parser.hpp"

#include <fstream>
#include <iostream>
#include <memory>
#include <string>

using namespace CSTR;

void dump(OmegaSolver &solver) {
    solver.enableDebugDump(std::cout);

    auto ret = solver.mayHasIntSolutions();

    std::cout << "May Has Integer Solutions: " << std::boolalpha << ret << std::endl;
    std::cout << "------------ Done ------------" << std::endl;
}

// Example from 'Figure 1: Example of elimination resulting constraints of equality constraints'
void figure_1() {
    OmegaSolver solver;
    ExprParser expr_parser(&solver.VH);
    ConstraintParser parser(&expr_parser);

    // 7x + 12y + 31z = 17
    // 3x + 5y + 14z = 7
    // -1 <= x <= 40
    // -50 <= y <= 50

    auto figure_1 =
        parser.parse({"7x + 12y + 31z = 17", "3x + 5y + 14z = 7", "-1 <= x", "x <= 40", "-50 <= y", "y <= 50"});

    solver.addConstraints(figure_1);

    dump(solver);
}

// Example from '2.3.3 An Omega test nightmare'
void nightmare() {
    OmegaSolver solver;
    ExprParser expr_parser(&solver.VH);
    ConstraintParser parser(&expr_parser);

    // 27 <= 11x + 13y <= 45
    // 10 <= 7x - 9y <= 4

    auto nightmare = parser.parse({"27 <= 11x + 13y", "11x + 13y <= 45", "-10 <= 7x - 9y", "7x - 9y <= 4"});

    solver.addConstraints(nightmare);

    dump(solver);
}

int main() {
    Logger::setLogLevel(LogLevel::DEBUG);
    figure_1();
    nightmare();
    return 0;
}
