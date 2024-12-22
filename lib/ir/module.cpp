#include "../../include/ir/module.hpp"
#include "../../include/ir/visitor.hpp"
#include "../../include/symbol_table/symbol_table.hpp"

namespace IR {

void Module::addGlobalVar(GlobalVariable* global_var) {
    global_vars.emplace_back(global_var);
}

const std::vector<GlobalVariable*>& Module::getGlobalVars() const {
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
    funcs.emplace_back(func);
}

const auto& Module::getFunctions() const {
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


void Module::accept(IRVisitor& visitor) { visitor.visit(*this); }

/**
 * @todo
 */
Module::~Module() {
}
};
