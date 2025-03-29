/**
 * @brief maybe unused
 */
#include "../../include/ir/type.hpp"

#include <algorithm>

namespace IR {

pBType makeBType(IRBTYPE bty) { return std::make_shared<BType>(bty); }

pPtrType makePtrType(pType ele_ty) {
    Err::gassert(ele_ty != nullptr, "makePtrType(): Element type is nullptr.");
    return std::make_shared<PtrType>(std::move(ele_ty));
}

pArrayType makeArrayType(pType ele_ty, size_t size) {
    Err::gassert(ele_ty != nullptr, "makeArrayType(): Element type is nullptr.");
    return std::make_shared<ArrayType>(std::move(ele_ty), size);
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

pFuncType toFunctionType(const pType &ty) { return ty->as<FunctionType>(); }

pType getElm(const pType &ty) {
    switch (ty->getTrait()) {
    case IRCTYPE::ARRAY:
        return ty->as<ArrayType>()->getElmType();
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
        auto a_bty = a->as<BType>();
        auto b_bty = b->as<BType>();
        return a_bty->getInner() == b_bty->getInner();
    }
    if (a->getTrait() == IRCTYPE::ARRAY) {
        auto a_arrty = a->as<ArrayType>();
        auto b_arrty = b->as<ArrayType>();
        return isSameType(a_arrty->getElmType(), b_arrty->getElmType()) &&
               a_arrty->getArraySize() == b_arrty->getArraySize();
    }
    if (a->getTrait() == IRCTYPE::PTR) {
        auto a_pty = a->as<PtrType>();
        auto b_pty = b->as<PtrType>();
        return isSameType(a_pty->getElmType(), b_pty->getElmType());
    }
    if (a->getTrait() == IRCTYPE::FUNCTION) {
        auto a_fnty = a->as<FunctionType>();
        auto b_fnty = b->as<FunctionType>();
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
} // namespace IR
