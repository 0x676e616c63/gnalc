// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_MODULE_HPP
#define GNALC_IR_MODULE_HPP

#include "base.hpp"
#include "constant_pool.hpp"
#include "function.hpp"
#include "global_var.hpp"

#include <memory>

namespace Parser {
class IRGenerator;
} // namespace Parser

namespace IR {
class BuildCFGPass;
/**
 * @brief 此处默认无需考虑全局变量与函数之间的相对位置
 */
class Module : public NameC {
    friend class Parser::IRGenerator;
    friend class CFGBuilder;

private:
    // Keep `constant_pool` the first member to make it destructs last
    // See: https://en.cppreference.com/w/cpp/language/destructor
    IR::ConstantPool constant_pool;

    std::list<pGlobalVar> global_vars;
    std::list<pFunc> funcs;
    std::list<pLFunc> linear_funcs;
    std::list<pFuncDecl> func_decls;

public:
    using const_iterator = decltype(funcs)::const_iterator;
    using iterator = decltype(funcs)::iterator;

    Module() = default;
    explicit Module(std::string _name) : NameC(std::move(_name)) {}

    void addGlobalVar(pGlobalVar global_var);
    const std::list<pGlobalVar> &getGlobalVars() const;
    bool delGlobalVar(const pGlobalVar &target);

    void addFunction(pFunc func);
    const std::list<pFunc> &getFunctions() const;
    bool delFunction(const pFunc &target);

    void addLinearFunction(pLFunc func);
    const std::list<pLFunc> &getLinearFunctions() const;
    bool delLinearFunction(const pLFunc &target);


    void addFunctionDecl(pFuncDecl func);
    const std::list<pFuncDecl> &getFunctionDecls() const;
    bool delFunctionDecl(const pFuncDecl &target);

    pFuncDecl lookupFunction(const std::string &name) const;

    pGlobalVar lookupGlobalVar(const std::string &name) const;

    ConstantPool &getConstantPool();

    void removeUnusedFuncDecls();
    void removeUnusedFuncs();

    template <typename T> auto getConst(T &&val) { return constant_pool.getConst(std::forward<T>(val)); }
    pVal getZero(const pType &type) { return constant_pool.getZero(type); }

    const_iterator begin() const;
    const_iterator end() const;
    iterator begin();
    iterator end();
    const_iterator cbegin() const;
    const_iterator cend() const;

    size_t getInstCount() const;

    void accept(IRVisitor &visitor);
    ~Module() = default;
};
} // namespace IR

#endif