#include "expr_solver/expr_parser.hpp"
#include "expr_solver/expr.hpp"

#include <map>
#include <stack>
#include <string>

namespace ExprSolver {
Expr *ExprParser::parse(const std::string &raw_text) {
    Err::gassert(pool != nullptr);
    raw = raw_text;
    tokens.clear();
    rawpos = 0;
    tokenpos = 1;

    get_all_tokens();
    std::stack<Expr *> nodes;
    std::stack<char> op;
    auto eat_binary = [&] {
        Err::gassert(nodes.size() >= 2 && !op.empty(), "Invalid expression.");
        auto rhs = nodes.top();
        nodes.pop();
        auto lhs = nodes.top();
        nodes.pop();
        Op expr_op{};
        switch (op.top()) {
        case '+':
            expr_op = Op::Add;
            break;
        case '-':
            expr_op = Op::Sub;
            break;
        case '*':
            expr_op = Op::Mul;
            break;
        case '/':
            expr_op = Op::Div;
            break;
        case '%':
            expr_op = Op::Mod;
            break;
        default:
            Err::unreachable("Invalid op.");
        }
        nodes.emplace(pool->getBinary(expr_op, lhs, rhs));
        op.pop();
    };

    for (tokenpos = 1; tokenpos + 1 < tokens.size(); ++tokenpos) {
        auto &curr = tokens[tokenpos];
        if (curr.type() == ExprTokenType::OP) {
            while (!op.empty() && op_great_or_equal(op.top(), curr.ch()))
                eat_binary();
            op.push(curr.ch());
            continue;
        }

        if (curr.type() == ExprTokenType::LPAREN) {
            op.push('(');
            continue;
        }

        if (curr.type() == ExprTokenType::RPAREN) {
            Err::gassert(!op.empty(), "Expected '('");
            while (!nodes.empty() && op.top() != '(') {
                eat_binary();
                Err::gassert(!op.empty(), "Expected '('");
            }
            Err::gassert(!op.empty(), "Invaild string.");
            op.pop();
            continue;
        }

        if (curr.type() == ExprTokenType::DIGIT) {
            nodes.emplace(pool->getConstant(curr.number()));
            continue;
        }

        if (curr.type() == ExprTokenType::SYMBOL) {
            nodes.emplace(pool->getSymbol(curr.symbol()));
            continue;
        }

        Err::unreachable("unexpected ExprToken.");
    }
    while (!op.empty()) {
        eat_binary();
    }
    Err::gassert(nodes.size() == 1, "Invalid string.");
    Err::gassert(op.empty(), "Invalid string.");

    return nodes.top();
}

void ExprParser::get_all_tokens() {
    tokens.emplace_back(ExprToken{ExprTokenType::BEGIN, 0});
    while (tokens.back().type() != ExprTokenType::END) {
        auto token = get_token();
        if ((token.type() == ExprTokenType::SYMBOL || token.type() == ExprTokenType::LPAREN) &&
            (tokens.back().type() == ExprTokenType::SYMBOL      // x x -> x * x
             || tokens.back().type() == ExprTokenType::DIGIT    // 2x -> 2 * x
             || tokens.back().type() == ExprTokenType::RPAREN)) // (1 + 1) x -> (1 + 1) *x
        {
            tokens.emplace_back(ExprToken{ExprTokenType::OP, '*'});
            tokens.emplace_back(token);
            continue;
        }
        if ((tokens.back().type() == ExprTokenType::LPAREN || tokens.back().type() == ExprTokenType::BEGIN) &&
            (token.type() == ExprTokenType::OP && (token.ch() == '+' || token.ch() == '-')))
        // +1 -> 0 + 1, -1 -> 0 - 1
        {
            tokens.emplace_back(ExprToken{ExprTokenType::DIGIT, 0});
            tokens.emplace_back(token);
            continue;
        }
        tokens.emplace_back(token);
    }
}

int ExprParser::parse_a_number() {
    std::string temp;
    do {
        temp += raw[rawpos];
        ++rawpos;
    } while (rawpos < raw.size() && std::isdigit(raw[rawpos]));
    return std::stoi(temp);
}

ExprToken ExprParser::get_token() {
    while (rawpos < raw.size() && std::isspace(raw[rawpos])) {
        ++rawpos;
    }
    if (rawpos >= raw.size()) {
        return {ExprTokenType::END, 0};
    }
    auto &ch = raw[rawpos];
    if (std::isdigit(ch))
        return {ExprTokenType::DIGIT, parse_a_number()};

    if (ch == '+' || ch == '-' || ch == '*' || ch == '/' || ch == '^') {
        ++rawpos;
        return {ExprTokenType::OP, ch};
    }

    if (ch == '(') {
        ++rawpos;
        return {ExprTokenType::LPAREN, '('};
    }

    if (ch == ')') {
        ++rawpos;
        return {ExprTokenType::RPAREN, ')'};
    }

    if (std::isalpha(ch) || ch == '{') {
        std::string symbol;
        if (ch == '{') {
            ++rawpos; // skip '{'
            while (rawpos < raw.size() && raw[rawpos] != '}') {
                symbol += raw[rawpos];
                ++rawpos;
            }
        } else
            symbol += ch;

        ++rawpos; // skip single-char symbol or '}'
        return {ExprTokenType::SYMBOL, symbol};
    }
    Err::unreachable("unexpected '" + std::string(1, ch) + "'.");
    return {ExprTokenType::END, 0};
}

bool ExprParser::op_great_or_equal(char a, char b) {
    const static std::map<char, int> priority = {{'(', 0}, {'+', 10}, {'-', 10}, {'*', 100}, {'/', 100}, {'^', 1000}};
    return priority.at(a) >= priority.at(b);
}
} // namespace ExprSolver
