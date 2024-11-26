/**
 * @todo may need symbol table
 */
#pragma once

#include <memory>
#include "base.hpp"
#include "function.hpp"
#include "global_var.hpp"


namespace IR {
class Module : public Name {
private:
    std::vector<std::unique_ptr<Function>> funcs;
    std::vector<std::unique_ptr<GlobalVariable>> global_vars;

public:
    Module() {}
    Module(NameParam name) : Name(name) {}

    void addFunction(std::unique_ptr<Function> func);
    Function* getFunction(NameParam name);
    void delFunction(NameParam name);
    const std::vector<std::unique_ptr<Function>>& getFunctions() const;

    void addGlobalVar(std::unique_ptr<GlobalVariable> global_var);
    GlobalVariable* getGlobalVar(NameParam name);
    void delGlobalVar(NameParam name);
    const std::vector<std::unique_ptr<GlobalVariable>>& getGlobalVars() const;

    ~Module();
};
}
