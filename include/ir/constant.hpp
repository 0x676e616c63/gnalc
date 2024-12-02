/**
 * @brief 常量字面值
 */

#include "base.hpp"
#include <memory>



namespace IR {


class ConstantInt : public Value {
private:
    i32 val;
public:
    ConstantInt(i32 _val);

    i32 getVal();
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