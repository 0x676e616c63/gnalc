/**
 * @brief 常量字面值包装到Value
 * @todo 实现方式优化
 */

#pragma once
#ifndef GNALC_IR_CONSTANT_HPP
#define GNALC_IR_CONSTANT_HPP
#include "base.hpp"

namespace IR {
// const的name就是它的值toString
class ConstantInt : public Value {
private:
    int val;
public:
    ConstantInt(int _val);

    int getVal();

    void accept(IRVisitor& visitor) override { visitor.visit(*this); }
};

class ConstantFloat : public Value {
private:
    float val;
public:
    ConstantFloat(float _val);

    float getVal();

    void accept(IRVisitor& visitor) override { visitor.visit(*this); }
};

using CI32 = ConstantInt;
using CF32 = ConstantFloat;

}

#endif