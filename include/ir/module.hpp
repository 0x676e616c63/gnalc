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

namespace Parser {
class CFGBuilder;
class IRGenerator;
}

namespace IR {

/**
 * @brief 此处默认无需考虑全局变量与函数之间的相对位置
 *
 * @todo 更改容器类型！
 */
class Module : public NameC {
    friend class Parser::CFGBuilder;
    friend class Parser::IRGenerator;
private:
    // Keep `constant_pool` the first member to make it destructs last
    // See: https://en.cppreference.com/w/cpp/language/destructor
    IR::ConstantPool constant_pool;

    std::vector<std::shared_ptr<GlobalVariable>> global_vars;
    std::vector<std::shared_ptr<Function>> funcs;
    std::vector<std::shared_ptr<FunctionDecl>> func_decls;

public:
    using const_iterator = decltype(funcs)::const_iterator;
    using iterator = decltype(funcs)::iterator;

    Module() = default;
    explicit Module(std::string _name) : NameC(std::move(_name)) {}

    void addGlobalVar(std::shared_ptr<GlobalVariable> global_var);
    const std::vector<std::shared_ptr<GlobalVariable>> &getGlobalVars() const;
    bool delGlobalVar(const std::shared_ptr<GlobalVariable>& target);

    void addFunction(std::shared_ptr<Function> func);
    const std::vector<std::shared_ptr<Function>> &getFunctions() const;
    bool delFunction(const std::shared_ptr<Function>& target);

    void addFunctionDecl(std::shared_ptr<FunctionDecl> func);
    const std::vector<std::shared_ptr<FunctionDecl>> &getFunctionDecls() const;
    bool delFunctionDecl(const std::shared_ptr<FunctionDecl>& target);

    ConstantPool &getConstantPool();

    const_iterator begin() const;
    const_iterator end() const;
    iterator begin();
    iterator end();
    const_iterator cbegin() const;
    const_iterator cend() const;

    void accept(IRVisitor &visitor);
    ~Module() = default;
};
} // namespace IR

#endif