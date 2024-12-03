/**
 * @brief 包含通用的TypeC, NameC类
 * 
 * @attention 只做了一些类型，其他类型尚未考虑
 */

#pragma once
#ifndef IR_TYPE_HPP
#define IR_TYPE_HPP

#include <string>

namespace IR {
// enum _type { INT, FLOAT, VOID, UNDEFINED };

/**
 * @todo 考虑BOOL, VECTOR? PTRARRAY?
 */
enum class IRTYPE {
    I32, FLOAT, VOID, PTR, I32ARRAY, FLOATARRAY, UNDEFINED
};

using NameRef = const std::string&; // 赋值名字时改为str::string, 用move传值；引用名字时使用该类型别名


/**
 * @brief C是class的意思，以便区分，添加了array类型以解决[2 x i32]的问题
 * @attention length若被赋值，其对应的类型必须为ARRAY
 */
class TypeC {
private:
    IRTYPE ty = IRTYPE::UNDEFINED;
    int length = -1; // only for array type
public:
    TypeC() = default;
    TypeC(IRTYPE _ty) : ty(_ty) {}
    TypeC(int _length, IRTYPE _ty) : length(_length), ty(_ty) {} // for [2 x i32]

    void setType(IRTYPE _ty) { length = -1; ty = _ty; }
    void setType(int _length, IRTYPE _ty) { length = _length; ty = _ty; }
    bool isArray() const { return length!=-1; }
    IRTYPE getType() const { return ty; }
    int getLength() const { return length; }
};

// move传值
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