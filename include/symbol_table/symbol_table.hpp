#pragma once
#ifndef GNALC_SYMBOL_TABLE_HPP
#define GNALC_SYMBOL_TABLE_HPP

#include "../ir/base.hpp"
#include "../utils/exception.hpp"

#include <vector>
#include <map>
#include <string>

namespace Sym {
    class SymbolTable {
        std::vector<std::map<std::string, std::vector<IR::Value*>>> table;
        // Scope { name, {value or overloaded functions}}
        // The most recent name is in the last one.

    public:
        SymbolTable() = default;
        void initScope() {
            table.emplace_back();
        }

        void finishScope() {
            table.pop_back();
        }

        void insert(const std::string &name, IR::Value* value) {
            table.back()[name].emplace_back(value);
        }

        IR::Value* lookup(const std::string& name) const {
            for(auto scope = table.rbegin(); scope != table.rend(); ++scope) {
                if(auto it = scope->find(name); it != scope->end()) {
                    Err::assert(!it->second.empty());
                    return it->second.back();
                }
            }
            return nullptr;
        }
    };
}

#endif
