#pragma once
#ifndef GNALC_EXPR_SOLVER_EXPR_PARSER_HPP
#define GNALC_EXPR_SOLVER_EXPR_PARSER_HPP

#include "expr.hpp"

#include <map>
#include <string>
#include <variant>

namespace ExprSolver {
enum class ExprTokenType { BEGIN, END, OP, LPAREN, RPAREN, DIGIT, SYMBOL };

class ExprToken {
private:
    std::variant<char, int, std::string> val;
    ExprTokenType expr_type;

public:
    template <typename U> ExprToken(ExprTokenType t, U &&u) : val(std::forward<U>(u)), expr_type(t) {}

    auto type() const { return expr_type; }

    const auto &ch() const { return std::get<char>(val); }
    const auto &symbol() const { return std::get<std::string>(val); }
    const auto &number() const { return std::get<int>(val); }
};

class ExprParser {
private:
    std::string raw;
    std::vector<ExprToken> tokens;
    std::size_t rawpos;
    std::size_t tokenpos;
    ExprPool *pool;

public:
    explicit ExprParser(ExprPool *pool_) : pool(pool_), rawpos(0), tokenpos(1) {}

    Expr *parse(const std::string &);

private:
    void get_all_tokens();

    int parse_a_number();

    ExprToken get_token();

    static bool op_great_or_equal(char a, char b);
};
} // namespace ExprSolver
#endif