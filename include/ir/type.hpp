/**
 * @brief 包含通用的TypeC, NameC类
 * @attention 只做了一些类型，其他类型尚未考虑
 * 
 * @note 考虑到VALUE似乎没有ARRAY的情景，ARRAY只在ALLOCA和GLOBLEVAR中用到，还是暂时不用TYPEC来表示ARRAY
 */

#pragma once
#ifndef GNALC_IR_TYPE_HPP
#define GNALC_IR_TYPE_HPP

#include <string>
#include <vector>

namespace IR {
// enum _type { INT, FLOAT, VOID, UNDEFINED };

/**
 * @todo 考虑BOOL, VECTOR? PTRARRAY?
 */
enum class IRTYPE {
    I1, // For br's cond, icmp and fcmp return
    I32,
    FLOAT,
    VOID,
    PTR,
    // I32ARRAY,
    // FLOATARRAY,
    UNDEFINED
};

// 用于与IRTYPE结合判断是否为ARRAY，避免后续新加ARRAY类型改动地方过多
// bool IRTypeIsArray(IRTYPE ty) { return ty==IRTYPE::I32ARRAY || ty==IRTYPE::FLOATARRAY; }

using NameRef = const std::string&; // 赋值名字时改为str::string, 用move传值；引用名字时使用该类型别名

/**
 * @brief C是class的意思，以便区分，添加了array类型以解决[2 x i32]的问题
 * @attention array_size若被赋值，其对应的类型必须为ARRAY
 */
class TypeC {
protected:
    IRTYPE ty = IRTYPE::UNDEFINED;
    // std::vector<int> array_size; // [3 x [4 x i32]] 就是 {3, 4} 和语言中的数组大小顺序一致
public:
    TypeC() = default;
    TypeC(IRTYPE _ty) : ty(_ty) {}
    // TypeC(IRTYPE _ty, const std::vector<int>& _array_size) : array_size(_array_size), ty(_ty) {} // for [2 x i32]

    void setType(IRTYPE _ty) { ty = _ty; }
    // void setType(IRTYPE _ty, const std::vector<int>& _array_size) { array_size = _array_size; ty = _ty; }
    // bool isArray() const { return IRTypeIsArray(ty); }
    IRTYPE getType() const { return ty; }
    // std::vector<int> getArraySize() const { return array_size; };
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