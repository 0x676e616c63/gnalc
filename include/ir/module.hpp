/**
 * @todo may need symbol table
 */
#pragma once
#ifndef GNALC_IR_MODULE_HPP
#define GNALC_IR_MODULE_HPP

#include <memory>
#include "base.hpp"
#include "function.hpp"
#include "global_var.hpp"


namespace IR {

/**
 * @brief 此处默认无需考虑全局变量与函数之间的相对位置
 * 
 * @todo 更改容器类型！
 */
class Module : public NameC {
private:
    std::vector<GlobalVariable*> global_vars;
    std::vector<Function*> funcs;

public:
    Module() = default;
    Module(std::string _name) : NameC(std::move(_name)) {}

    void addGlobalVar(GlobalVariable* global_var);
    const std::vector<GlobalVariable*>& getGlobalVars() const;
    void delGlobalVar(NameRef name); // by name

    void addFunction(Function* func);
    const std::vector<Function*>& getFunctions() const;
    void delFunction(NameRef name); // by name

    void accept(IRVisitor& visitor) { visitor.visit(*this); }
    ~Module();
};
}

#endif