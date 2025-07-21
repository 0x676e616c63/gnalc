// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../include/ir/module.hpp"
#include "../../include/ir/visitor.hpp"

#include <algorithm>

namespace IR {

void Module::addGlobalVar(pGlobalVar global_var) { global_vars.emplace_back(std::move(global_var)); }

const std::list<pGlobalVar> &Module::getGlobalVars() const { return global_vars; }

bool Module::delGlobalVar(const pGlobalVar &target) {
    for (auto it = global_vars.begin(); it != global_vars.end(); ++it) {
        if (*it == target) {
            global_vars.erase(it);
            return true;
        }
    }
    return false;
}

void Module::addFunction(pFunc func) {
    func->setParent(this);
    funcs.emplace_back(std::move(func));
}

const std::list<pFunc> &Module::getFunctions() const { return funcs; }

bool Module::delFunction(const pFunc &target) {
    for (auto it = funcs.begin(); it != funcs.end(); ++it) {
        if (*it == target) {
            funcs.erase(it);
            target->setParent(nullptr);
            return true;
        }
    }
    return false;
}

void Module::addLinearFunction(pLFunc func) {
    func->setParent(this);
    linear_funcs.emplace_back(std::move(func));
}
const std::list<pLFunc> &Module::getLinearFunctions() const { return linear_funcs; }
bool Module::delLinearFunction(const pLFunc &target) {
    for (auto it = linear_funcs.begin(); it != linear_funcs.end(); ++it) {
        if (*it == target) {
            linear_funcs.erase(it);
            target->setParent(nullptr);
            return true;
        }
    }
    return false;
}

void Module::addFunctionDecl(pFuncDecl func_decl) {
    func_decl->setParent(this);
    func_decls.emplace_back(std::move(func_decl));
}

const std::list<pFuncDecl> &Module::getFunctionDecls() const { return func_decls; }

bool Module::delFunctionDecl(const pFuncDecl &target) {
    for (auto it = func_decls.begin(); it != func_decls.end(); ++it) {
        if (*it == target) {
            func_decls.erase(it);
            target->setParent(nullptr);
            return true;
        }
    }
    return false;
}

pFuncDecl Module::lookupFunction(const std::string &name) const {
    for (const auto &func_decl : func_decls) {
        if (func_decl->isName(name))
            return func_decl;
    }
    for (const auto &func : funcs) {
        if (func->isName(name))
            return func;
    }
    return nullptr;
}
std::vector<pFuncDecl> Module::lookupFunction(FuncAttr attr) const {
    std::vector<pFuncDecl> ret;
    for (const auto &func_decl : func_decls) {
        if (func_decl->hasAttr(attr))
            ret.emplace_back(func_decl);
    }
    for (const auto &func : funcs) {
        if (func->hasAttr(attr))
            ret.emplace_back(func);
    }
    return ret;
}

pGlobalVar Module::lookupGlobalVar(const std::string &name) const {
    for (const auto &gv : global_vars) {
        if (gv->isName(name))
            return gv;
    }
    return nullptr;
}

ConstantPool &Module::getConstantPool() { return constant_pool; }

// No need to set their parent to nullptr since they are going to be released.
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

size_t Module::getInstCount() const {
    size_t count = 0;
    if (!linear_funcs.empty()) {
        for (const auto &func : linear_funcs)
            count += func->getInstCount();
    } else {
        for (const auto &func : funcs)
            count += func->getInstCount();
    }
    return count;
}

std::set<Runtime::RtType> Module::getRuntimeTypes() const {
    std::set<Runtime::RtType> ret;
    for (const auto &func_decl : func_decls) {
        if (func_decl->hasAttr(FuncAttr::ParallelEntry) || func_decl->hasAttr(FuncAttr::isAtomicAddI32) ||
            func_decl->hasAttr(FuncAttr::isAtomicAddF32)) {
            if (func_decl->getUseCount() != 0)
                ret.emplace(Runtime::RtType::Thread);
        }
    }
    return ret;
}

void Module::accept(IRVisitor &visitor) { visitor.visit(*this); }
}; // namespace IR
