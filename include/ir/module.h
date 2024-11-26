/**
 * @todo may need symbol table
 */
#ifndef GNALC_IR_MODULE_H
#pragma once

#include <memory>
#include "base.h"
#include "function.h"
#include "global_var.h"


namespace IR {
    class Module : public Name {
    private:
        std::vector<std::unique_ptr<Function> > funcs;
        std::vector<std::unique_ptr<GlobalVariable> > global_vars;

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

        ~Module();
    };
}
#endif
