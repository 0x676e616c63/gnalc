/**
 * @brief maybe unused
 */
#include "../../include/ir/type.hpp"

#include <algorithm>

namespace IR {

    std::shared_ptr<BType> makeBType(IRBTYPE bty) {
        return std::make_shared<BType>(bty);
    }

    std::shared_ptr<PtrType> makePtrType(std::shared_ptr<Type> ele_ty) {
        Err::gassert(ele_ty != nullptr, "makePtrType(): Element type is nullptr.");
        return std::make_shared<PtrType>(ele_ty);
    }

    std::shared_ptr<ArrayType> makeArrayType(std::shared_ptr<Type> ele_ty, size_t size) {
        Err::gassert(ele_ty != nullptr, "makeArrayType(): Element type is nullptr.");
        return std::make_shared<ArrayType>(ele_ty, size);
    }

    std::shared_ptr<FunctionType> makeFunctionType(
        std::vector<std::shared_ptr<Type>> params,
        std::shared_ptr<Type> ret)
    {
        Err::gassert(!std::any_of(params.begin(), params.end(),
            [](auto&& p){return p == nullptr;}),
            "makeFunctionType(): Param type is nullptr");
        Err::gassert(ret != nullptr, "makeFunctionType(): Return type is nullptr.");
        return std::make_shared<FunctionType>(std::move(params), std::move(ret));
    }

    std::shared_ptr<BType> toBType(const std::shared_ptr<Type>& ty) {
        return std::dynamic_pointer_cast<BType>(ty);
    }

    std::shared_ptr<PtrType> toPtrType(const std::shared_ptr<Type>& ty) {
        return std::dynamic_pointer_cast<PtrType>(ty);
    }

    std::shared_ptr<ArrayType> toArrayType(const std::shared_ptr<Type>& ty) {
        return std::dynamic_pointer_cast<ArrayType>(ty);
    }

    std::shared_ptr<FunctionType> toFunctionType(const std::shared_ptr<Type>& ty) {
        return std::dynamic_pointer_cast<FunctionType>(ty);
    }


    std::shared_ptr<Type> getElm(const std::shared_ptr<Type>& ty) {
        switch(ty->getTrait()) {
            case IRCTYPE::ARRAY:
                return toArrayType(ty)->getElmType();
            case IRCTYPE::PTR:
                return toPtrType(ty)->getElmType();
            default:
                return nullptr;
        }
    }

    bool isSameType(std::shared_ptr<Type> a, std::shared_ptr<Type> b) {
        if (a->getTrait() != b->getTrait())
            return false;

        if (a->getTrait() == IRCTYPE::BASIC)
        {
            auto a_bty = toBType(a);
            auto b_bty = toBType(b);
            return a_bty->getInner() == b_bty->getInner();
        }
        if (a->getTrait() == IRCTYPE::ARRAY)
        {
            auto a_arrty = toArrayType(a);
            auto b_arrty = toArrayType(b);
            return isSameType(a_arrty->getElmType(), b_arrty->getElmType())
            && a_arrty->getArraySize() == b_arrty->getArraySize();
        }
        if (a->getTrait() == IRCTYPE::PTR)
        {
            auto a_pty = toPtrType(a);
            auto b_pty = toPtrType(b);
            return isSameType(a_pty->getElmType(), b_pty->getElmType());
        }
        if (a->getTrait() == IRCTYPE::FUNCTION)
        {
            auto a_fnty = toFunctionType(a);
            auto b_fnty = toFunctionType(b);
            if (a_fnty->getParams().size() != b_fnty->getParams().size())
                return false;
            for (size_t i = 0; i < a_fnty->getParams().size(); ++i)
            {
                if (!isSameType(a_fnty->getParams()[i], b_fnty->getParams()[i]))
                    return false;
            }
            return isSameType(a_fnty->getRet(), b_fnty->getRet());
        }
        return false;
    }
}

