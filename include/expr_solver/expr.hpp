#pragma once
#ifndef GNALC_EXPR_SOLVER_EXPR_HPP
#define GNALC_EXPR_SOLVER_EXPR_HPP

#include "utils/misc.hpp"

#include <iostream>
#include <memory>
#include <unordered_set>
#include <variant>
#include <vector>

namespace ExprSolver {

enum class Op { Add, Sub, Mul, Div, Mod };

enum class ExprType { Constant, Symbol, Binary };

using SymID = size_t;

class Expr {
    friend std::ostream &operator<<(std::ostream &os, const Expr &expr);

public:
    struct Binary {
        Op op;
        Expr *lhs;
        Expr *rhs;

        bool operator==(const Binary &other) const { return op == other.op && lhs == other.lhs && rhs == other.rhs; }
    };
    struct Symbol {
        // Unique
        std::string id;
        bool operator==(const Symbol &other) const { return id == other.id; }
    };

    struct Constant {
        int value;
        bool operator==(const Constant &other) const { return value == other.value; }
    };

private:
    std::variant<Constant, Symbol, Binary> value;
    ExprType type;

public:
    bool operator==(const Expr &other) const { return type == other.type && value == other.value; }

    bool isConstant() const { return type == ExprType::Constant; }
    bool isSym() const { return type == ExprType::Symbol; }
    bool isBinary() const { return type == ExprType::Binary; }
    // Constant Only
    int getConstVal() const { return std::get<Constant>(value).value; }
    const Constant &getConst() const { return std::get<Constant>(value); }
    // Symbol Only
    std::string getSymID() const { return std::get<Symbol>(value).id; }
    const Symbol &getSymbol() const { return std::get<Symbol>(value); }
    // Binary Only
    Expr *getLHS() const { return std::get<Binary>(value).lhs; }
    Expr *getRHS() const { return std::get<Binary>(value).rhs; }
    Op op() const { return std::get<Binary>(value).op; }

    explicit Expr(int value) : value(Constant{value}), type(ExprType::Constant) {}
    explicit Expr(const std::string &id) : value(Symbol{id}), type(ExprType::Symbol) {}
    explicit Expr(Op op, Expr *lhs, Expr *rhs) : value(Binary{op, lhs, rhs}), type(ExprType::Binary) {}
};

class ExprPool {
    struct ExprHasher {
        size_t operator()(Expr *expr) const {
            if (expr->isSym())
                return std::hash<std::string>()(expr->getSymID());

            size_t seed = std::hash<Expr *>()(expr->getLHS());
            Util::hashSeedCombine(seed, std::hash<Expr *>()(expr->getRHS()));
            Util::hashSeedCombine(seed, std::hash<Op>()(expr->op()));
            return seed;
        }
    };
    struct ExprCmp {
        bool operator()(Expr *a, Expr *b) const { return *a == *b; }
    };
    std::vector<std::unique_ptr<Expr>> pool;
    std::unordered_set<Expr *, ExprHasher, ExprCmp> index;

public:
    Expr *getConstant(int value);
    Expr *getSymbol(const std::string &id);
    Expr *getBinary(Op op, Expr *lhs, Expr *rhs);

private:
    Expr *getFromPool(Expr *e);
};

} // namespace ExprSolver

#endif