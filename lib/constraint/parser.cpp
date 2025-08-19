// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "constraint/parser.hpp"

#include <map>
#include <stack>
#include <string>

namespace CSTR {
Expr ExprParser::parse(const std::string &s) {
    text = &s;
    pos = 0;
    Expr e = parseExpr();
    skipSpaces();
    Err::gassert(pos == s.size(), "ExprParser: trailing characters at pos " + std::to_string(pos));
    return e;
}

void ExprParser::skipSpaces() {
    while (pos < text->size() && std::isspace((*text)[pos]))
        ++pos;
}

bool ExprParser::eat(char c) {
    skipSpaces();
    if (pos < text->size() && (*text)[pos] == c) {
        ++pos;
        return true;
    }
    return false;
}

char ExprParser::peekChar() {
    skipSpaces();
    if (pos < text->size())
        return (*text)[pos];
    return '\0';
}

CoeT ExprParser::parseNumber() {
    skipSpaces();
    size_t start = pos;
    bool negative = false;
    if (pos < text->size() && ((*text)[pos] == '+' || (*text)[pos] == '-')) {
        if ((*text)[pos] == '-')
            negative = true;
        ++pos;
    }
    Err::gassert(pos < text->size() && std::isdigit((*text)[pos]),
                 "ExprParser: expected number at pos " + std::to_string(start));
    CoeT val = 0;
    while (pos < text->size() && std::isdigit((*text)[pos])) {
        int d = (*text)[pos] - '0';
        val = val * 10 + d;
        ++pos;
    }
    return negative ? -val : val;
}

std::string ExprParser::parseIdent() {
    skipSpaces();
    size_t start = pos;
    if (pos < text->size() && (std::isalpha((*text)[pos]) || (*text)[pos] == '_')) {
        ++pos;
        while (pos < text->size() && (std::isalnum((*text)[pos]) || (*text)[pos] == '_'))
            ++pos;
        return text->substr(start, pos - start);
    }
    Err::unreachable("ExprParser: expected identifier at pos " + std::to_string(start));
}

VarID ExprParser::varIdForName(const std::string &name) {
    auto it = name_map.find(name);
    if (it != name_map.end())
        return it->second;
    VarID id = VH->newVar(name);
    name_map.emplace(name, id);
    return id;
}

// parse factor: number | ident | '(' expr ')' | unary
Expr ExprParser::parseFactor() {
    skipSpaces();
    if (eat('+'))
        return parseFactor();
    if (eat('-')) {
        Expr f = parseFactor();
        return f * -1;
    }

    char c = peekChar();
    if (c == '(') {
        eat('(');
        Expr e = parseExpr();
        if (!eat(')'))
            Err::error("ExprParser: expected ')' at pos " + std::to_string(pos));
        return e;
    }

    // number or identifier
    if (std::isdigit(c) || c == '+' || c == '-') {
        // parseNumber consumes optional sign handled above, but here we might reach
        // a leading + or - because peekChar returns after skipSpaces. To avoid
        // double-sign handling, we check digit explicitly here unless earlier
        // unary consumed it. We'll attempt to parse number using parseNumber, but
        // if it fails we let it throw.
        CoeT val = parseNumber();
        Expr e;
        e.constant = val;
        return e;
    }

    if (std::isalpha(c) || c == '_') {
        std::string name = parseIdent();
        VarID id = varIdForName(name);
        Expr e;
        e.coeffs[id] = 1;
        return e;
    }

    Err::unreachable(std::string{"ExprParser: unexpected char '"} + c + "' at pos " + std::to_string(pos));
}

// term := factor { ('*' | implicit) factor }
Expr ExprParser::parseTerm() {
    Expr left = parseFactor();
    while (true) {
        skipSpaces();
        if (eat('*')) {
            Expr right = parseFactor();
            left = multiplyLinear(left, right);
            continue;
        }
        // implicit multiplication: next non-space char immediately starts a factor
        char c = peekChar();
        if (c == '(' || std::isdigit(c) || std::isalpha(c) || c == '_') {
            // treat as multiplication without explicit '*'
            Expr right = parseFactor();
            left = multiplyLinear(left, right);
            continue;
        }
        break;
    }
    return left;
}

// expr := term { ('+'|'-') term }
Expr ExprParser::parseExpr() {
    Expr left = parseTerm();
    while (true) {
        skipSpaces();
        if (eat('+')) {
            Expr r = parseTerm();
            left = left + r;
            continue;
        }
        if (eat('-')) {
            Expr r = parseTerm();
            left = left - r;
            continue;
        }
        break;
    }
    return left;
}

// Multiply two Exprs but enforce linearity: at least one operand must be constant.
Expr ExprParser::multiplyLinear(const Expr &a, const Expr &b) {
    bool a_var = !a.coeffs.empty();
    bool b_var = !b.coeffs.empty();
    Err::gassert(!a_var || !b_var, "ExprParser: non-linear multiplication (product of two var-containing terms)");

    // If one side is constant
    if (!a_var) {
        // a is constant
        CoeT k = a.constant;
        Expr r = b;
        for (auto &p : r.coeffs)
            p.second *= k;
        r.constant *= k;
        return r;
    }
    // else b must be constant
    CoeT k = b.constant;
    Expr r = a;
    for (auto &p : r.coeffs)
        p.second *= k;
    r.constant *= k;
    return r;
}

void ltrim(std::string &s) {
    s.erase(s.begin(), std::find_if(s.begin(), s.end(), [](unsigned char ch) { return !std::isspace(ch); }));
}
void rtrim(std::string &s) {
    s.erase(std::find_if(s.rbegin(), s.rend(), [](unsigned char ch) { return !std::isspace(ch); }).base(), s.end());
}
void trim(std::string &s) {
    ltrim(s);
    rtrim(s);
}

Constraint ConstraintParser::parse(const std::string &input) {
    std::string s = input;
    trim(s);

    Err::gassert(!s.empty(), "ConstraintParser: Empty input.");

    // Find top-level relational operator (one of: >=, <=, >, <, ==, =)
    size_t op_pos = std::string::npos;
    std::string op;
    int depth = 0;
    for (size_t i = 0; i < s.size(); ++i) {
        char c = s[i];
        if (c == '(') {
            ++depth;
            continue;
        }
        if (c == ')') {
            --depth;
            continue;
        }
        if (depth != 0)
            continue;

        // check two-char ops first
        if (c == '>' || c == '<') {
            if (i + 1 < s.size() && s[i + 1] == '=') {
                op_pos = i;
                op = s.substr(i, 2);
                break;
            }
            op_pos = i;
            op = s.substr(i, 1);
            break;
        }
        if (c == '=') {
            // allow both '=' and '=='
            if (i + 1 < s.size() && s[i + 1] == '=') {
                op_pos = i;
                op = "==";
                break;
            }
            op_pos = i;
            op = "=="; // treat single '=' as equality
            break;
        }
    }

    std::string lhs = s.substr(0, op_pos);
    std::string rhs = s.substr(op_pos + op.size());
    trim(lhs);
    trim(rhs);
    Err::gassert(!lhs.empty() && !rhs.empty(), "ConstraintParser: missing LHS or RHS");

    // Parse LHS first and reset name map, then parse RHS without resetting
    // so that identifiers map to the same VarIDs across both sides.
    Expr L = EP->parse(lhs);
    Expr R = EP->parse(rhs);

    Constraint c;
    if (op == "==")
        c = Constraint::newEqual(L, R);
    else if (op == ">=")
        c = Constraint::newGreaterEqual(L, R);
    else if (op == "<=")
        c = Constraint::newLessEqual(L, R);
    else if (op == ">")
        c = Constraint::newGreaterThan(L, R);
    else if (op == "<")
        c = Constraint::newLessThan(L, R);
    else
        Err::unreachable("ConstraintParser: unsupported operator '" + op + "'");

    return c;
}
std::vector<Constraint> ConstraintParser::parse(const std::vector<std::string> &inputs) {
    std::vector<Constraint> ret;
    ret.reserve(inputs.size());
    for (auto &input : inputs)
        ret.push_back(parse(input));
    return ret;
}

} // namespace CSTR