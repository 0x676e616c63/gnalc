// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_CONSTRAINT_PARSER_HPP
#define GNALC_CONSTRAINT_PARSER_HPP

#include "constraint/base.hpp"

#include <sstream>
#include <unordered_map>
#include <unordered_set>
#include <variant>
#include <vector>

namespace CSTR {
// Simple parser for linear integer expressions producing Expr
//   expr   := term { ('+' | '-') term }
//   term   := factor { ('*' | implicit) factor }
//   factor := integer | identifier | '(' expr ')' | ('+'|'-') factor
class ExprParser {
    const std::string *text = nullptr;
    size_t pos = 0;
    VarHandle *VH = nullptr;
    std::unordered_map<std::string, VarID> name_map;

public:
    explicit ExprParser(VarHandle *VH_) : VH(VH_) {}

    Expr parse(const std::string &s);

    void skipSpaces();

    bool eat(char c);

    char peekChar();

    CoeT parseNumber();
    std::string parseIdent();

    VarID varIdForName(const std::string &name);

    // parse factor: number | ident | '(' expr ')' | unary
    Expr parseFactor();

    // term := factor { ('*' | implicit) factor }
    Expr parseTerm();

    // expr := term { ('+'|'-') term }
    Expr parseExpr();

    // Multiply two Exprs but enforce linearity: at least one operand must be constant.
    static Expr multiplyLinear(const Expr &a, const Expr &b);
};

// Constraint parser. Uses ExprParser to parse both sides of a relational
// operator and returns a Constraint. Examples:
//   "2x + 1 >= y - 3"
//   "x + y == 0"
//   "3(x+1) < 2y"
class ConstraintParser {
    ExprParser* EP;

public:
    explicit ConstraintParser(ExprParser *EP_) : EP(EP_) {}
    Constraint parse(const std::string &input);
    std::vector<Constraint> parse(const std::vector<std::string> &inputs);
};

} // namespace CSTR

#endif
