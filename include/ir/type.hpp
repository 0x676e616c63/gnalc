/**
 * @brief 包含通用的Type, Name类
 */

#pragma once
#ifndef GNALC_IR_TYPE_HPP
#define GNALC_IR_TYPE_HPP

#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "../utils/exception.hpp"
#include "type_alias.hpp"

namespace IR {
/**
 * @brief IR BASIC TYPE只包含简单Type类型，亦是Value的类型
 */
enum class IRBTYPE {
    I1, // For br's cond, icmp and fcmp return
    I8, // For sylib's putf(char a[], ...)
    I32,
    FLOAT,
    VOID,
    UNDEFINED
};

/**
 * @brief IR COMPOUND TYPE 包含复杂结构类型
 */
enum class IRCTYPE { BASIC, PTR, ARRAY, FUNCTION };

inline size_t getBytes(IRBTYPE type) {
    switch (type) {
    case IRBTYPE::I1:
        return 1;
    case IRBTYPE::I8:
        return 1;
    case IRBTYPE::I32:
        return 4;
    case IRBTYPE::FLOAT:
        return 4;
    default:
        Err::error("In IR::BType::getBytes(): illegal type.");
        return 0;
    }
    return 0;
}

class Type : public std::enable_shared_from_this<Type> {
public:
    virtual ~Type() = default;
    virtual IRCTYPE getTrait() const = 0;
    virtual std::string toString() const = 0;
    virtual size_t getBytes() const = 0;

    template <typename T> std::shared_ptr<const T> as() const {
        static_assert(std::is_base_of_v<Type, T>, "Expected a derived type.");
        return std::dynamic_pointer_cast<const T>(shared_from_this());
    }

    template <typename T> const T *as_raw() const {
        static_assert(std::is_base_of_v<Type, T>, "Expected a derived type.");
        return dynamic_cast<const T *>(this);
    }

    template <typename T> std::shared_ptr<T> as() {
        static_assert(std::is_base_of_v<Type, T>, "Expected a derived type.");
        return std::dynamic_pointer_cast<T>(shared_from_this());
    }

    template <typename T> T *as_raw() {
        static_assert(std::is_base_of_v<Type, T>, "Expected a derived type.");
        return dynamic_cast<T *>(this);
    }

    template <typename T> bool is() const {
        static_assert(std::is_base_of_v<Type, T>, "Expected a derived type.");
        return as_raw<T>() != nullptr;
    }
};

/**
 * @brief 简单结构Type，完全是函数的返回类型
 * @attention bty 不应为 PTR
 */
class BType : public Type {
protected:
    IRBTYPE bty;

public:
    BType() : bty(IRBTYPE::UNDEFINED) {}
    explicit BType(IRBTYPE _bty) : bty(_bty) {}

    IRBTYPE getInner() const { return bty; }

    IRCTYPE getTrait() const override { return IRCTYPE::BASIC; }

    std::string toString() const override {
        switch (bty) {
        case IRBTYPE::I1:
            return "i1";
        case IRBTYPE::I8:
            return "i8";
        case IRBTYPE::I32:
            return "i32";
        case IRBTYPE::FLOAT:
            return "float";
        case IRBTYPE::VOID:
            return "void";
        case IRBTYPE::UNDEFINED:
            return "UNDEFINED TYPE";
        default:
            Err::error("In IR::BType::toString(): illegal type.");
            return "ILLEGAL TYPE";
        }
    }

    size_t getBytes() const override { return IR::getBytes(bty); }
};

class PtrType : public Type {
protected:
    pType element_type;

public:
    PtrType(pType element_type_) : element_type(std::move(element_type_)) {}
    const auto &getElmType() const { return element_type; }

    IRCTYPE getTrait() const override { return IRCTYPE::PTR; }

    std::string toString() const override { return element_type->toString() + "*"; }
    size_t getBytes() const override { return 8; }
};

class ArrayType : public Type {
protected:
    pType element_type;
    size_t size;

public:
    ArrayType(pType element_type_, size_t size) : element_type(std::move(element_type_)), size(size) {}

    const auto &getElmType() const { return element_type; }

    size_t getArraySize() const { return size; }

    IRCTYPE getTrait() const override { return IRCTYPE::ARRAY; }

    std::string toString() const override {
        return "[" + std::to_string(size) + " x " + element_type->toString() + "]";
    }

    size_t getBytes() const override { return size * element_type->getBytes(); }
};

class FunctionType : public Type {
protected:
    pType ret;
    std::vector<pType> params;
    bool is_va_arg;

public:
    FunctionType(std::vector<pType> params_, pType ret_, bool is_va_arg_)
        : params(std::move(params_)), ret(std::move(ret_)), is_va_arg(is_va_arg_) {}

    IRCTYPE getTrait() const override { return IRCTYPE::FUNCTION; }

    bool isVAArg() const { return is_va_arg; }

    const std::vector<pType> &getParams() const { return params; }

    const pType &getRet() const { return ret; }

    std::string toString() const override {
        Err::not_implemented("Function type to string.");
        return {};
    }

    size_t getBytes() const override {
        Err::unreachable("Cannot get bytes of function type.");
        return 0;
    }
};

// 以下为一些辅助函数，类型不匹配会抛出exception

pBType makeBType(IRBTYPE bty);
pPtrType makePtrType(pType ele_ty);
pArrayType makeArrayType(pType ele_ty, size_t size);
pFuncType makeFunctionType(std::vector<pType> params, pType ret, bool is_va_arg);

// 若类型不正确会返回nullptr
pBType toBType(const pType &ty);
pPtrType toPtrType(const pType &ty);
pArrayType toArrayType(const pType &ty);
pFuncType toFunctionType(const pType &ty);

// 返回PTR, ARRAY的element_type; BType 会返回 nullptr
pType getElm(const pType &ty);

bool isSameType(const pType &a, const pType &b);

/***********下列内容为NameClass相关**********/

using NameRef = const std::string &; // 赋值名字时改为str::string, 用move传值；引用名字时使用该类型别名

// move传值
// C means class
class NameC {
private:
    std::string name;

public:
    NameC() = default;
    explicit NameC(std::string _name) : name(std::move(_name)) {}

    void setName(std::string _name) { name = std::move(_name); }
    bool isName(NameRef _name) { return _name == name; }
    std::string getName() const { return name; }
};
} // namespace IR

#endif
