#include "../../include/ir/module.hpp"
#include "../../include/ir/visitor.hpp"
#include "../../include/symbol_table/symbol_table.hpp"

#include <algorithm>

namespace IR {

void Module::addGlobalVar(std::shared_ptr<GlobalVariable> global_var) {
    global_vars.emplace_back(std::move(global_var));
}

const std::vector<std::shared_ptr<GlobalVariable>> & Module::getGlobalVars() const {
    return global_vars;
}

void Module::delGlobalVar(NameRef name) {
    for (auto it = global_vars.begin(); it != global_vars.end(); ++it) {
        if ((*it)->isName(name)) {
            global_vars.erase(it);
            return;
        }
    }
}

void Module::addFunction(std::shared_ptr<Function> func) {
    funcs.emplace_back(std::move(func));
}

const std::vector<std::shared_ptr<Function>> &Module::getFunctions() const {
    return funcs;
}

/**
 * @brief Delete by name
 */
void Module::delFunction(NameRef name) {
    for (auto it = funcs.begin(); it != funcs.end(); ++it) {
        if ((*it)->isName(name)) {
            funcs.erase(it);
            return;
        }
    }
}

void Module::addFunctionDecl(std::shared_ptr<FunctionDecl> func_decl) {
    func_decls.emplace_back(std::move(func_decl));
}

const std::vector<std::shared_ptr<FunctionDecl>> &
Module::getFunctionDecls() const {
    return func_decls;
}

void Module::delFunctionDecl(NameRef name) {
    for (auto it = func_decls.begin(); it != func_decls.end(); ++it) {
        if ((*it)->isName(name)) {
            func_decls.erase(it);
            return;
        }
    }
}

ConstantPool &Module::getConstantPool() { return constant_pool; }

void Module::removeUnusedFuncDecl() {
    func_decls.erase(
        std::remove_if(func_decls.begin(), func_decls.end(),
                       [](auto &&p) { return p->getUseList().empty(); }),
        func_decls.end());
}
Module::const_iterator Module::cbegin() const {
    return funcs.cbegin();
}
Module::const_iterator Module::cend() const {
    return funcs.cend();
}
Module::iterator Module::begin() {
    return funcs.begin();
}
Module::iterator Module::end() {
    return funcs.end();
}

void Module::accept(IRVisitor &visitor) { visitor.visit(*this); }
}; // namespace IR
