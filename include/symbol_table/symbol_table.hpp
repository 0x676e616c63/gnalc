#pragma once
#ifndef GNALC_SYMBOL_TABLE_HPP
#define GNALC_SYMBOL_TABLE_HPP

#include <functional>

#include "../ir/base.hpp"
#include "../utils/exception.hpp"

#include <utility>
#include <stack>
#include <map>
#include <string>
#include <vector>

namespace Sym
{
class SymbolTable {
    struct Scope {
        std::string name;
        std::map<std::string, std::shared_ptr<IR::Value>> scope;
    };

    std::vector<Scope> table;
public:
    SymbolTable() {}

    void initScope(std::string name = "__default_scope_name") {
        table.emplace_back(Scope{std::move(name), {}});
    }

    void finishScope() {
        table.pop_back();
    }

    void insert(std::string name, std::shared_ptr<IR::Value> value) {
        Err::assert(!table.empty());
        table.back().scope.emplace(std::move(name), std::move(value));
    }

    std::shared_ptr<IR::Value> lookup(const std::string& name) const {
        for (auto it = table.rbegin(); it != table.rend(); ++it)
        {
            if (auto f = it->scope.find(name); f != it->scope.end())
                return f->second;
        }
        return nullptr;
    }
};
}

#endif
