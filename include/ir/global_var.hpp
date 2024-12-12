#pragma once
#ifndef GNALC_IR_GLOBAL_VAR_H
#define GNALC_IR_GLOBAL_VAR_H

#include "base.hpp"

namespace IR {

// storage_class
enum class STOCLASS {
    GLOBAL,
    CONSTANT
};

// IR GlobalVariable Initializer
// int i;
// int ci = 1;
// int arr[2][2] = {{5, 6}};
// int arrz[2][2] = {};
// int arri[2][2] = {{1, 2}, {3, 4}};
class GVIniter {
private:
    IRTYPE initer_type;
    bool is_zero; // is zeroinitializer, 对于array就输出zeroinitializer, 不是array就输出0
    bool is_array;
    std::vector<int> array_size; // [3 x [4 x i32]] 就是 {3, 4} 和语言中的数组大小顺序一致
    Value* constval; // 只针对非array的情况!!! 内容只能是ConstantInt or Float
    std::vector<GVIniter> inner_initer; // isarray == true
public:
    GVIniter() = delete;
    GVIniter(IRTYPE _ty); // zeroinit
    GVIniter(IRTYPE _ty, Value* _con); // i32 1
    GVIniter(IRTYPE _ty, std::vector<int> _array_size); // [2 x i32] zeroinit
    GVIniter(IRTYPE _ty, std::vector<int> _array_size, std::vector<GVIniter> _inner_initer); // [2 x [2 x i32]] [...]

    IRTYPE getIniterType() const;
    bool isZero() const;
    bool isArray() const;
    std::vector<int> getArraySize() const;
    Value* getConstVal(); // 此处暂时先用非const的引用传递
    std::vector<GVIniter>& getInnerIniter(); // 此处暂时先用非const的引用传递

    friend class GlobalVariable;
    ~GVIniter();
};

/**
 * @brief @arr = dso_local global [2 x [2 x i32]] [[2 x i32] [i32 5, i32 6], [2 x i32] zeroinitializer], align 4
 * @brief \@<name> = [linkage] [visibility] [storage_class] [addrspace(<n>)] <type> <initializer>, [align <alignment>]
 * @attention 全局变量的type为ptr
 * @attention 默认linkage 是dso_local
 */
class GlobalVariable : public Value {
private:
    STOCLASS storage_class;
    IRTYPE vtype; // 表示的variable的类型
    bool is_array;
    std::vector<int> array_size; // [3 x [4 x i32]] 就是 {3, 4} 和语言中的数组大小顺序一致
    GVIniter initer;
    int align;
public:
    GlobalVariable(STOCLASS _sc, IRTYPE _ty, std::string _name, GVIniter _initer, int _align = 4); // 对于无初始值的，使用第一种构造方式
    GlobalVariable(STOCLASS _sc, IRTYPE _ty, std::string _name, std::vector<int> _array_size, GVIniter _initer, int _align = 4);

    STOCLASS getStorageClass() const;
    IRTYPE getVarType() const;
    bool isArray() const;
    std::vector<int> getArraySize() const;
    GVIniter& getIniter();
    int getAlign() const;

    void accept(IRVisitor& visitor) override { visitor.visit(*this); }
    ~GlobalVariable();
};
}

#endif