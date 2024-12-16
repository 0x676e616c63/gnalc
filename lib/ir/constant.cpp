#include "../../include/ir/constant.hpp"
#include "../../include/ir/visitor.hpp"
#include <string>

namespace IR {
    ConstantInt::ConstantInt(int _val) : Value(std::to_string(_val), IRTYPE::I32), val(_val) {}

    int ConstantInt::getVal() { return val; }

    ConstantFloat::ConstantFloat(float _val) : Value(std::to_string(_val), IRTYPE::FLOAT), val(_val) {}

    float ConstantFloat::getVal() { return val; }


    void ConstantInt::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void ConstantFloat::accept(IRVisitor& visitor) { visitor.visit(*this); }
}