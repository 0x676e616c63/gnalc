#include "ir/module.h"

namespace IR {
    void Module::addFunction(std::unique_ptr<Function> func) {
        funcs.push_back(std::move(func));
    }

    Function *Module::getFunction(const NameParam& name) const {
        for (auto &func: funcs) {
            if (func->isName(name)) {
                return func.get();
            }
        }
        return nullptr;
    }

    /**
     * @brief Delete by name
     * @attention no repeat delete, may be optimizable
     */
    void Module::delFunction(const NameParam& name) {
        for (auto it = funcs.begin(); it != funcs.end(); ++it) {
            if ((*it)->isName(name)) {
                funcs.erase(it);
                return;
            }
        }
    }

    const std::vector<std::unique_ptr<Function> > &Module::getFunctions() const {
        return funcs;
    }

    void Module::addGlobalVar(std::unique_ptr<GlobalVariable> global_var) {
        global_vars.push_back(std::move(global_var));
    }

    GlobalVariable *Module::getGlobalVar(const NameParam& name) {
        for (auto &global_var: global_vars) {
            if (global_var->isName(name)) {
                return global_var.get();
            }
        }
        return nullptr;
    }

    /**
     * @todo same as delFunction
     */
    void Module::delGlobalVar(const NameParam& name) {
        for (auto it = global_vars.begin(); it != global_vars.end(); ++it) {
            if ((*it)->isName(name)) {
                global_vars.erase(it);
                return;
            }
        }
    }

    const std::vector<std::unique_ptr<GlobalVariable> > &Module::getGlobalVars() const {
        return global_vars;
    }

    /**
     * @todo
     */
    Module::~Module() {
    }
};
