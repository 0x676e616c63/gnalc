/**
 * @brief 常量字面值包装到Value
 * @todo 实现方式优化
 */

#pragma once
#ifndef IR_CONSTANT_HPP
#define IR_CONSTANT_HPP
#include "base.hpp"

namespace IR {


class ConstantInt : public Value {
private:
    int val;
public:
    ConstantInt(int _val);

    int getVal();
};

class ConstantFloat : public Value {
private:
    float val;
public:
    ConstantFloat(float _val);

    float getVal();
};

using CI32 = ConstantInt;
using CF32 = ConstantFloat;

}

#endif