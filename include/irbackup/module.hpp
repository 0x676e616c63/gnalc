/**
 * @todo may need symbol table
 */
#ifndef GNALC_IR_MODULE_HPP
#pragma once

#include <list>
#include <stack>
#include <map>
#include <string>
#include <memory>
#include "../utils/exception.hpp"
#include "base.hpp"
#include "function.hpp"
#include "global_var.hpp"

namespace IR {

class SymbolTable {
    std::vector<std::map<std::string, std::vector<Value*>>> table;
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

    void insert(const std::string &name, Value* value) {
        table.back()[name].emplace_back(value);
    }

    Value* lookup(const std::string& name) const {
        for(auto scope = table.rbegin(); scope != table.rend(); ++scope) {
            if(auto it = scope->find(name); it != scope->end()) {
                Err::assert(!it->second.empty());
                return it->second.back();
            }
        }
        return nullptr;
    }
};

class Module : public Name {
private:
    std::vector<std::unique_ptr<Function> > funcs;
    std::vector<std::unique_ptr<GlobalVariable> > global_vars;
    SymbolTable symbol_table;
public:
    Module() = default;

    explicit Module(NameParam name) : Name(std::move(name)) { }

    void addFunction(std::unique_ptr<Function> func);

    Function *getFunction(const NameParam& name) const;

    void delFunction(const NameParam& name);

    const std::vector<std::unique_ptr<Function> > &getFunctions() const;

    void addGlobalVar(std::unique_ptr<GlobalVariable> global_var);

    GlobalVariable *getGlobalVar(const NameParam& name);

    void delGlobalVar(const NameParam& name);

    const std::vector<std::unique_ptr<GlobalVariable> > &getGlobalVars() const;

    void initScope();

    void finishScope();

    void registerSymbol(const std::string &name, Value* value);

    Value* lookupSymbol(const std::string &name);

    ~Module();
};
}
#endif
