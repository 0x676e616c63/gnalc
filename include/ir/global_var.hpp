#pragma once
#ifndef GNALC_IR_GLOBAL_VAR_HPP
#define GNALC_IR_GLOBAL_VAR_HPP

#include "base.hpp"
#include <vector>

namespace IR {
// storage_class
enum class STOCLASS { GLOBAL, CONSTANT };

// IR GlobalVariable Initializer
// int i;
// int ci = 1;
// int arr[2][2] = {{5, 6}};
// int arrz[2][2] = {};
// int arri[2][2] = {{1, 2}, {3, 4}};
class GVIniter {
private:
    pType initer_type;
    bool is_zero;                       // is zeroinitializer, 对于array就输出zeroinitializer,
                                        // 不是array就输出0
    pVal constval;                      // 只针对非array的情况!!! 内容只能是ConstantInt or Float
    std::vector<GVIniter> inner_initer; // isarray == true
public:
    GVIniter() = default;
    GVIniter(pType _ty);            // zeroinit
    GVIniter(pType _ty, pVal _con); // i32 1
    GVIniter(pType _ty,
             std::vector<GVIniter> _inner_initer); // [2 x [2 x i32]] [...]

    const pType &getIniterType() const;
    bool isZero() const;
    bool isArray() const;

    pVal &getConstVal(); // 此处暂时先用非const的引用传递
    const pVal &getConstVal() const;

    const std::vector<GVIniter> &getInnerIniter() const;

    GVIniter &addIniter(pType _ty, pVal _con);

    GVIniter &addIniter(pType _ty);

    void normalizeZero();

    std::string toString() const;

    friend class GlobalVariable;
    ~GVIniter();
};

/**
 * @brief @arr = dso_local global [2 x [2 x i32]] [[2 x i32] [i32 5, i32 6], [2
 * x i32] zeroinitializer], align 4
 * @brief \@<name> = [linkage] [visibility] [storage_class] [addrspace(<n>)]
 * <type> <initializer>, [align <alignment>]
 * @attention 全局变量的type为ptr
 * @attention 默认linkage 是dso_local
 */
class GlobalVariable : public Value {
private:
    STOCLASS storage_class;
    pType vtype; // 表示的variable的类型
    GVIniter initer;
    int align;

public:
    GlobalVariable(STOCLASS _sc, pType _ty, std::string _name, GVIniter _initer,
                   int _align = 4); // 对于无初始值的，使用第一种构造方式

    STOCLASS getStorageClass() const;
    const pType &getVarType() const;
    bool isArray() const;
    const GVIniter &getIniter() const;
    int getAlign() const;

    void accept(IRVisitor &visitor) override;
    ~GlobalVariable() override;
};
} // namespace IR

#endif