/**
 * @brief maybe unused
 */
#include "../../include/ir/type.hpp"

namespace IR {

    std::shared_ptr<BType> makeBType(IRBTYPE bty) {
        return std::make_shared<BType>(bty);
    }

    std::shared_ptr<PtrType> makePtrType(std::shared_ptr<Type> ele_ty) {
        Err::assert(ele_ty != nullptr, "makePtrType(): Element type is nullptr.");
        return std::make_shared<PtrType>(ele_ty);
    }

    std::shared_ptr<ArrayType> makeArrayType(std::shared_ptr<Type> ele_ty, size_t size) {
        Err::assert(ele_ty != nullptr, "makeArrayType(): Element type is nullptr.");
        return std::make_shared<ArrayType>(ele_ty, size);
    }

    std::shared_ptr<BType> toBType(std::shared_ptr<Type> ty) {
        if (ty->getTrait() != IRCTYPE::PTR) {
            Err::error("Type don't match BType.");
            return nullptr;
        }
        auto p = std::dynamic_pointer_cast<BType>(ty);
        Err::assert(p != nullptr, "Type converse to BType failed.");
        return p;
    }

    std::shared_ptr<PtrType> toPtrType(std::shared_ptr<Type> ty) {
        if (ty->getTrait() != IRCTYPE::PTR) {
            Err::error("Type don't match PtrType.");
            return nullptr;
        }
        auto p = std::dynamic_pointer_cast<PtrType>(ty);
        Err::assert(p != nullptr, "Type converse to PtrType failed.");
        return p;
    }

    std::shared_ptr<ArrayType> toArrayType(std::shared_ptr<Type> ty) {
        if (ty->getTrait() != IRCTYPE::ARRAY) {
            Err::error("Type don't match ArrayType.");
            return nullptr;
        }
        auto p = std::dynamic_pointer_cast<ArrayType>(ty);
        Err::assert(p != nullptr, "Type converse to ArrayType failed.");
        return p;
    }

    IRBTYPE getBTy(std::shared_ptr<Type> ty) {
        switch(ty->getTrait()) {
            case IRCTYPE::BASIC:
                return toBType(ty)->getBType();
            case IRCTYPE::PTR:
                return IRBTYPE::PTR;
            default:
                Err::error("Get BType failed.");
                return IRBTYPE::UNDEFINED;
        }
    }

    std::shared_ptr<Type> getElm(std::shared_ptr<Type> ty) {
        switch(ty->getTrait()) {
            case IRCTYPE::ARRAY:
                return toArrayType(ty)->getElmType();
            case IRCTYPE::PTR:
                return toPtrType(ty)->getElmType();
            default:
                Err::error("Get element failed.");
                return nullptr;
        }
    }

    size_t getSize(std::shared_ptr<Type> ty) {
        switch(ty->getTrait()) {
            case IRCTYPE::ARRAY:
                return toArrayType(ty)->getSize();
            default:
                Err::error("Get size failed.");
                return 0;
        }
   }
}

