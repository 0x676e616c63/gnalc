// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/type.hpp"

#include "ir/base.hpp"

#include <algorithm>

namespace IR {

bool Type::isI1() const {
    auto a = as_raw<BType>();
    return a && a->getInner() == IRBTYPE::I1;
}
bool Type::isI8() const {
    auto a = as_raw<BType>();
    return a && a->getInner() == IRBTYPE::I8;
}
bool Type::isI32() const {
    auto a = as_raw<BType>();
    return a && a->getInner() == IRBTYPE::I32;
}
bool Type::isI64() const {
    auto a = as_raw<BType>();
    return a && a->getInner() == IRBTYPE::I64;
}
bool Type::isF32() const {
    auto a = as_raw<BType>();
    return a && a->getInner() == IRBTYPE::FLOAT;
}
bool Type::isInteger() const { return isI1() || isI8() || isI32() || isI64(); }
bool Type::isFloatingPoint() const { return isF32(); }
bool Type::isVec() const { return as_raw<VectorType>(); }
bool Type::isIntVec() const {
    auto vec = as_raw<VectorType>();
    return vec && vec->getElmType()->isInteger();
}
bool Type::isFPVec() const {
    auto vec = as_raw<VectorType>();
    return vec && vec->getElmType()->isFloatingPoint();
}
bool Type::is128BitVec() const {
    auto vec = as_raw<VectorType>();
    return vec && vec->getBytes() == 16;
}
bool Type::isVoid() const {
    auto a = as_raw<BType>();
    return a && a->getInner() == IRBTYPE::VOID;
}
bool Type::isUndef() const {
    auto a = as_raw<BType>();
    return a && a->getInner() == IRBTYPE::UNDEFINED;
}
pBType makeBType(IRBTYPE bty) { return std::make_shared<BType>(bty); }

pPtrType makePtrType(pType ele_ty) {
    Err::gassert(ele_ty != nullptr, "makePtrType(): Element type is nullptr.");
    return std::make_shared<PtrType>(std::move(ele_ty));
}

pArrayType makeArrayType(pType ele_ty, size_t size) {
    Err::gassert(ele_ty != nullptr, "makeArrayType(): Element type is nullptr.");
    return std::make_shared<ArrayType>(std::move(ele_ty), size);
}

pVecType makeVectorType(pType ele_ty, size_t size) {
    Err::gassert(ele_ty != nullptr, "makeArrayType(): Element type is nullptr.");
    return std::make_shared<VectorType>(std::move(ele_ty), size);
}

pFuncType makeFunctionType(std::vector<pType> params, pType ret, bool is_va_arg) {
    Err::gassert(!std::any_of(params.begin(), params.end(), [](auto &&p) { return p == nullptr; }),
                 "makeFunctionType(): Param type is nullptr");
    Err::gassert(ret != nullptr, "makeFunctionType(): Return type is nullptr.");
    return std::make_shared<FunctionType>(std::move(params), std::move(ret), is_va_arg);
}

pBType toBType(const pType &ty) { return ty->as<BType>(); }

pPtrType toPtrType(const pType &ty) { return ty->as<PtrType>(); }

pArrayType toArrayType(const pType &ty) { return ty->as<ArrayType>(); }

pVecType toVectorType(const pType &ty) { return ty->as<VectorType>(); }

pFuncType toFunctionType(const pType &ty) { return ty->as<FunctionType>(); }

pType getElm(const pType &ty) {
    switch (ty->getTrait()) {
    case IRCTYPE::ARRAY:
        return ty->as<ArrayType>()->getElmType();
    case IRCTYPE::VECTOR:
        return ty->as<VectorType>()->getElmType();
    case IRCTYPE::PTR:
        return ty->as<PtrType>()->getElmType();
    default:
        return nullptr;
    }
}

bool isSameType(const pType &a, const pType &b) {
    if (a->getTrait() != b->getTrait())
        return false;

    if (a->getTrait() == IRCTYPE::BASIC) {
        auto a_bty = a->as_raw<BType>();
        auto b_bty = b->as_raw<BType>();
        return a_bty->getInner() == b_bty->getInner();
    }
    if (a->getTrait() == IRCTYPE::ARRAY) {
        auto a_arrty = a->as_raw<ArrayType>();
        auto b_arrty = b->as_raw<ArrayType>();
        return isSameType(a_arrty->getElmType(), b_arrty->getElmType()) &&
               a_arrty->getArraySize() == b_arrty->getArraySize();
    }
    if (a->getTrait() == IRCTYPE::VECTOR) {
        auto a_arrty = a->as_raw<VectorType>();
        auto b_arrty = b->as_raw<VectorType>();
        return isSameType(a_arrty->getElmType(), b_arrty->getElmType()) &&
               a_arrty->getVectorSize() == b_arrty->getVectorSize();
    }
    if (a->getTrait() == IRCTYPE::PTR) {
        auto a_pty = a->as_raw<PtrType>();
        auto b_pty = b->as_raw<PtrType>();
        return isSameType(a_pty->getElmType(), b_pty->getElmType());
    }
    if (a->getTrait() == IRCTYPE::FUNCTION) {
        auto a_fnty = a->as_raw<FunctionType>();
        auto b_fnty = b->as_raw<FunctionType>();
        if (a_fnty->getParams().size() != b_fnty->getParams().size())
            return false;
        for (size_t i = 0; i < a_fnty->getParams().size(); ++i) {
            if (!isSameType(a_fnty->getParams()[i], b_fnty->getParams()[i]))
                return false;
        }
        return isSameType(a_fnty->getRet(), b_fnty->getRet());
    }
    return false;
}
bool isSameType(const pVal &v1, const pVal &v2) {
    return isSameType(v1->getType(), v2->getType());
}
} // namespace IR
