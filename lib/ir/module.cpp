#include "../../include/ir/module.hpp"
#include "../../include/ir/visitor.hpp"

#include <algorithm>

namespace IR {

void Module::addGlobalVar(pGlobalVar global_var) { global_vars.emplace_back(std::move(global_var)); }

const std::vector<pGlobalVar> &Module::getGlobalVars() const { return global_vars; }

bool Module::delGlobalVar(const pGlobalVar &target) {
    for (auto it = global_vars.begin(); it != global_vars.end(); ++it) {
        if (*it == target) {
            global_vars.erase(it);
            return true;
        }
    }
    return false;
}

void Module::addFunction(pFunc func) { funcs.emplace_back(std::move(func)); }

const std::vector<pFunc> &Module::getFunctions() const { return funcs; }

bool Module::delFunction(const pFunc &target) {
    for (auto it = funcs.begin(); it != funcs.end(); ++it) {
        if (*it == target) {
            funcs.erase(it);
            return true;
        }
    }
    return false;
}

void Module::addFunctionDecl(pFuncDecl func_decl) { func_decls.emplace_back(std::move(func_decl)); }

const std::vector<pFuncDecl> &Module::getFunctionDecls() const { return func_decls; }

bool Module::delFunctionDecl(const pFuncDecl &target) {
    for (auto it = func_decls.begin(); it != func_decls.end(); ++it) {
        if (*it == target) {
            func_decls.erase(it);
            return true;
        }
    }
    return false;
}

ConstantPool &Module::getConstantPool() { return constant_pool; }

void Module::removeUnusedFuncDecls() {
    func_decls.erase(
        std::remove_if(func_decls.begin(), func_decls.end(), [](auto &&p) { return p->getUseCount() == 0; }),
        func_decls.end());
}
void Module::removeUnusedFuncs() {
    funcs.erase(std::remove_if(funcs.begin(), funcs.end(),
                               [](auto &&p) { return p->getUseCount() == 0 && p->getName() != "@main"; }),
                funcs.end());
}

Module::const_iterator Module::begin() const { return funcs.begin(); }
Module::const_iterator Module::end() const { return funcs.end(); }
Module::iterator Module::begin() { return funcs.begin(); }
Module::iterator Module::end() { return funcs.end(); }
Module::const_iterator Module::cbegin() const { return funcs.cbegin(); }
Module::const_iterator Module::cend() const { return funcs.cend(); }

void Module::accept(IRVisitor &visitor) { visitor.visit(*this); }
}; // namespace IR
