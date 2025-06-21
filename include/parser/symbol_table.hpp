#pragma once
#ifndef GNALC_PARSER_SYMBOL_TABLE_HPP
#define GNALC_PARSER_SYMBOL_TABLE_HPP

#include "ir/base.hpp"
#include "utils/exception.hpp"

#include <map>
#include <string>
#include <utility>
#include <vector>

namespace Parser {
class SymbolTable {
    struct Scope {
        std::string name;
        std::map<std::string, std::shared_ptr<IR::Value>> scope;
    };

    std::vector<Scope> table;

public:
    SymbolTable() = default;

    void initScope(std::string name = "__default_scope_name") { table.emplace_back(Scope{std::move(name), {}}); }

    void finishScope() { table.pop_back(); }

    void insert(std::string name, std::shared_ptr<IR::Value> value) {
        Err::gassert(!table.empty());
        table.back().scope.emplace(std::move(name), std::move(value));
    }

    IR::pVal lookup(const std::string &name) const {
        for (auto it = table.rbegin(); it != table.rend(); ++it) {
            if (auto f = it->scope.find(name); f != it->scope.end())
                return f->second;
        }
        return nullptr;
    }

    size_t getDepth() const { return table.size(); }
};
} // namespace Parser

#endif
