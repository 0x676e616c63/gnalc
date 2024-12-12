#include "../../include/ir/constant.hpp"

namespace IR {
    ConstantInt::ConstantInt(int _val) : Value("", IRTYPE::I32), val(_val) {}

    int ConstantInt::getVal() { return val; }

    ConstantFloat::ConstantFloat(float _val) : Value("", IRTYPE::FLOAT), val(_val) {}

    float ConstantFloat::getVal() { return val; }
}