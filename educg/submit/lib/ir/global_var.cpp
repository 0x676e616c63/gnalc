// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../include/ir/global_var.hpp"
#include "../../include/ir/formatter.hpp"
#include "../../include/ir/visitor.hpp"

namespace IR {
GVIniter::GVIniter(pType _ty) : initer_type(std::move(_ty)), is_zero(true) {}

GVIniter::GVIniter(pType _ty, std::shared_ptr<Value> _con)
    : initer_type(std::move(_ty)), is_zero(false), constval(_con) {}

GVIniter::GVIniter(pType _ty, std::vector<GVIniter> _inner_initer)
    : initer_type(std::move(_ty)), is_zero(false), inner_initer(_inner_initer) {}

const pType &GVIniter::getIniterType() const { return initer_type; }

bool GVIniter::isZero() const { return is_zero; }

bool GVIniter::isArray() const { return initer_type->getTrait() == IRCTYPE::ARRAY; }

const pVal &GVIniter::getConstVal() const { return constval; }

GVIniter &GVIniter::addIniter(pType _ty, pVal _con) {
    Err::gassert(isArray());
    is_zero = false;
    inner_initer.emplace_back(std::move(_ty), std::move(_con));
    return inner_initer.back();
}

GVIniter &GVIniter::addIniter(pType _ty) {
    Err::gassert(isArray());
    is_zero = false;
    inner_initer.emplace_back(std::move(_ty));
    return inner_initer.back();
}

void GVIniter::normalizeZero() {
    if (!isArray())
        return;
    // Element is Array
    if (getElm(initer_type)->getTrait() == IRCTYPE::ARRAY) {
        bool inner_is_zero = true;
        for (auto &&r : inner_initer) {
            r.normalizeZero();
            if (!r.isZero()) {
                inner_is_zero = false;
                // Because we want the sub initializer normalized, we should not
                // break break;
            }
        }
        if (inner_is_zero) {
            inner_initer.clear();
            is_zero = true;
        }
    }
    // Element is Number
    else {
        bool inner_is_zero = true;
        for (auto &&r : inner_initer) {
            if (auto ci = r.constval->as<ConstantInt>()) {
                if (ci->getVal() != 0) {
                    inner_is_zero = false;
                    break;
                }
            } else if (auto cf = r.constval->as<ConstantFloat>()) {
                if (cf->getVal() != 0) {
                    inner_is_zero = false;
                    break;
                }
            } else {
                inner_is_zero = false;
                break;
            }
        }
        if (inner_is_zero) {
            inner_initer.clear();
            is_zero = true;
        }
    }
}

GVIniter::~GVIniter() {}

GlobalVariable::GlobalVariable(STOCLASS _sc, pType _ty, std::string _name, GVIniter _initer, int _align)
    : storage_class(_sc), vtype(std::move(_ty)), Value(std::move(_name), makePtrType(_ty), ValueTrait::GLOBAL_VARIABLE),
      initer(_initer), align(_align) {}

STOCLASS GlobalVariable::getStorageClass() const { return storage_class; }

const pType &GlobalVariable::getVarType() const { return vtype; }
void GlobalVariable::setVarType(const pType &ty) { vtype = ty; }

bool GlobalVariable::isArray() const { return vtype->getTrait() == IRCTYPE::ARRAY; }

const std::vector<GVIniter> &GVIniter::getInnerIniter() const { return inner_initer; }

const GVIniter &GlobalVariable::getIniter() const { return initer; }
void GlobalVariable::setIniter(GVIniter _initer) {
    initer = std::move(_initer);
}

int GlobalVariable::getAlign() const { return align; }
void GlobalVariable::setAlign(int a) { align = a; }
void GlobalVariable::setAsConst() {
    storage_class = STOCLASS::CONSTANT;
}

// void GlobalVariable::accept(IRVisitor& visitor) override {
// visitor.visit(*this); }

std::string GVIniter::toString() const {
    std::string ret;

    if (isArray()) {
        ret += initer_type->toString();
        if (isZero()) {
            ret += " zeroinitializer";
        } else {
            ret += " [";
            for (auto it = inner_initer.begin(); it != inner_initer.end(); it++) {
                ret += it->toString();
                if (std::next(it) != inner_initer.end()) {
                    ret += ", ";
                }
            }
            ret += "]";
        }
    } else {
        if (isZero()) {
            ret += initer_type->toString() + " ";
            if (initer_type->is<PtrType>())
                ret += "null";
            else
                ret += "0";
        } else {
            ret += IRFormatter::formatValue(*getConstVal());
        }
    }

    return ret;
}

void GlobalVariable::accept(IRVisitor &visitor) { visitor.visit(*this); }

IR::GlobalVariable::~GlobalVariable() {}
} // namespace IR