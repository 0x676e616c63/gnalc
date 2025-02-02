/**
 * @todo may need symbol table
 */
#pragma once
#ifndef GNALC_IR_MODULE_HPP
#define GNALC_IR_MODULE_HPP

#include "base.hpp"
#include "constant_pool.hpp"
#include "function.hpp"
#include "global_var.hpp"
#include <memory>

namespace IR {

/**
 * @brief 此处默认无需考虑全局变量与函数之间的相对位置
 *
 * @todo 更改容器类型！
 */
class Module : public NameC {
private:
    // Keep `constant_pool` the first member to make it destructs last
    // See: https://en.cppreference.com/w/cpp/language/destructor
    IR::ConstantPool constant_pool;

    std::vector<std::shared_ptr<GlobalVariable>> global_vars;
    std::vector<std::shared_ptr<Function>> funcs;
    std::vector<std::shared_ptr<FunctionDecl>> func_decls;

public:
    Module() = default;
    explicit Module(std::string _name) : NameC(std::move(_name)) {}

    void addGlobalVar(std::shared_ptr<GlobalVariable> global_var);
    const std::vector<std::shared_ptr<GlobalVariable>> &getGlobalVars() const;
    void delGlobalVar(NameRef name); // by name

    void addFunction(std::shared_ptr<Function> func);
    const std::vector<std::shared_ptr<Function>> &getFunctions() const;
    std::vector<std::shared_ptr<Function>> &getFunctions();
    void delFunction(NameRef name); // by name

    void addFunctionDecl(std::shared_ptr<FunctionDecl> func);
    const std::vector<std::shared_ptr<FunctionDecl>> &getFunctionDecls() const;
    std::vector<std::shared_ptr<FunctionDecl>> &getFunctionDecls();
    void delFunctionDecl(NameRef name); // by name

    ConstantPool &getConstantPool();

    void accept(IRVisitor &visitor);
    ~Module();
};
} // namespace IR

#endif