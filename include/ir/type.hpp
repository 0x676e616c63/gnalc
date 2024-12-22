/**
 * @brief 包含通用的Type, Name类
 */

#pragma once
#ifndef GNALC_IR_TYPE_HPP
#define GNALC_IR_TYPE_HPP

#include <string>
#include <memory>
#include "../utils/exception.hpp"

namespace IR {

/**
 * @brief IR BASIC TYPE只包含简单Type类型，亦是Value的类型
 */
enum class IRBTYPE {
    I1, // For br's cond, icmp and fcmp return
    I32,
    FLOAT,
    VOID,
    PTR, // 此处仅为方便Value返回自己的类型，PTR类型实际上应当是IRCTYPE::PTR
    UNDEFINED
};

/**
 * @brief IR COMPOUND TYPE 包含复杂结构类型
 */
enum class IRCTYPE {
    BASIC,
    PTR,
    ARRAY
};

class Type;
class BType;
class PtrType;
class ArrayType;

class Type {
public:
    virtual ~Type() = default;
    virtual IRCTYPE getTrait() const = 0;
    virtual std::string toString() const = 0;
};

/**
 * @brief 简单结构Type，完全是函数的返回类型
 * @attention bty 不应为 PTR
 */
class BType : public Type {
protected:
    IRBTYPE bty;
public:
    // BType() = default;
    BType(IRBTYPE _bty) : bty(_bty) { Err::assert(_bty != IRBTYPE::PTR, "Ptr type defined in BType."); }

    // void setBType(IRBTYPE _bty) { Err::assert(_bty != IRBTYPE::PTR, "Ptr type defined in BType."); bty = _bty; }
    IRBTYPE getBType() const { return bty; }

    IRCTYPE getTrait() const override { return IRCTYPE::BASIC; }
    std::string toString() const override {
        switch (bty)
        {
        case IRBTYPE::I1:
            return "i1";
        case IRBTYPE::I32:
            return "i32";
        case IRBTYPE::FLOAT:
            return "float";
        case IRBTYPE::VOID:
            return "void";
        case IRBTYPE::UNDEFINED:
            return "UNDEFINEDTYPE";
        default:
            Err::error("In IR::BType::toString(): illegal type.");
            return "ILLEGALTYPE";
        }
    }
};

class PtrType : public Type {
protected:
    std::shared_ptr<Type> element_type;
public:
    PtrType(std::shared_ptr<Type> _ele_ty) : element_type(_ele_ty) {}
    auto& getElmType() const { return element_type; }

    IRCTYPE getTrait() const override { return IRCTYPE::PTR; }
    std::string toString() const override { return "ptr"; }
};

class ArrayType : public Type {
protected:
    std::shared_ptr<Type> element_type;
    size_t size;
public:
    ArrayType(std::shared_ptr<Type> element_type, size_t size)
        : element_type(element_type), size(size) {}
    auto& getElmType() const { return element_type; }
    size_t getSize() const { return size; }

    IRCTYPE getTrait() const override { return IRCTYPE::ARRAY; }
    std::string toString() const override {
        return "[ " + std::to_string(size) + " x " + element_type->toString() + " ]";
    }
};

// 以下为一些辅助函数，类型不匹配会抛出exception

std::shared_ptr<BType> makeBType(IRBTYPE bty);
std::shared_ptr<PtrType> makePtrType(std::shared_ptr<Type> ele_ty);
std::shared_ptr<ArrayType> makeArrayType(std::shared_ptr<Type> ele_ty, size_t size);

// 若类型不正确会返回nullptr
std::shared_ptr<BType> toBType(std::shared_ptr<Type> ty);
std::shared_ptr<PtrType> toPtrType(std::shared_ptr<Type> ty);
std::shared_ptr<ArrayType> toArrayType(std::shared_ptr<Type> ty);

// PtrType 亦会返回 IRBTYPE::PTR; BType 会返回其bty; 其他类型会返回 UNDEFIND
IRBTYPE getBTy(std::shared_ptr<Type> ty);
// 返回PTR, ARRAY的element_type; BType 会返回 nullptr
std::shared_ptr<Type> getElm(std::shared_ptr<Type> ty);
// 返回数组大小; 除arraytype之外的会返回0
size_t getSize(std::shared_ptr<Type> ty);


/***********下列内容为NameClass相关**********/

using NameRef = const std::string&; // 赋值名字时改为str::string, 用move传值；引用名字时使用该类型别名

// move传值
// C means class
class NameC {
private:
    std::string name;
public:
    NameC() = default;
    NameC(std::string _name) : name(_name) {}

    void setName(std::string _name) { name = _name; }
    bool isName(NameRef _name) { return _name==name; }
    std::string getName() const { return name; }
};
}

#endif