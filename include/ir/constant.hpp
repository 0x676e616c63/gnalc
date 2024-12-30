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

    int getVal() const;

    void accept(IRVisitor& visitor) override;
};

class ConstantFloat : public Value {
private:
    float val;
public:
    ConstantFloat(float _val);

    float getVal() const;

    void accept(IRVisitor& visitor) override;
};

// using CI32 = ConstantInt;
// using CF32 = ConstantFloat;

}

#endif