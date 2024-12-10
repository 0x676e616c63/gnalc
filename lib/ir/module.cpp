#include "../../include/ir/module.hpp"

namespace IR {

void Module::addGlobalVar(std::unique_ptr<GlobalVariable> global_var) {
    global_vars.emplace_back(std::move(global_var));
}

const auto& Module::getGlobalVars() const {
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

void Module::addFunction(std::unique_ptr<Function> func) {
    funcs.emplace_back(std::move(func));
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

/**
 * @todo
 */
Module::~Module() {
}
};
