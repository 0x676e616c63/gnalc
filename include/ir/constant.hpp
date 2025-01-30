/**
 * @brief 常量字面值包装到Value
 * @todo 实现方式优化
 */

#pragma once
#ifndef GNALC_IR_CONSTANT_HPP
#define GNALC_IR_CONSTANT_HPP
#include <complex>

#include "base.hpp"

namespace IR {
namespace detail
{
    // For the sake of convenience, the name of a constant is the string representation of its value.
    template <typename ValueT, IRBTYPE IRType>
    class BasicConstant : public Value {
        ValueT inner_value;
    public:
        using value_type = ValueT;

        explicit BasicConstant(ValueT value_)
            : Value(toIRString(value_), makeBType(IRType), ValueTrait::CONSTANT_LITERAL),
              inner_value(value_) {}

        BasicConstant& operator=(const BasicConstant& rhs) {
            inner_value = rhs.inner_value;
            return *this;
        }

        BasicConstant& operator=(ValueT rhs) {
            inner_value = rhs;
            return *this;
        }

        BasicConstant operator+(const BasicConstant& rhs) const {
            return BasicConstant(inner_value + rhs.inner_value);
        }

        BasicConstant operator-(const BasicConstant& rhs) const {
            return BasicConstant(inner_value - rhs.inner_value);
        }

        BasicConstant operator*(const BasicConstant& rhs) const {
            return BasicConstant(inner_value * rhs.inner_value);
        }

        BasicConstant operator/(const BasicConstant& rhs) const {
            return BasicConstant(inner_value / rhs.inner_value);
        }

        BasicConstant operator&&(const BasicConstant& rhs) const {
            return BasicConstant(inner_value && rhs.inner_value);
        }

        BasicConstant operator||(const BasicConstant& rhs) const {
            return BasicConstant(inner_value || rhs.inner_value);
        }

        ValueT getVal() const { return inner_value; }

        bool operator==(const BasicConstant& rhs) const { return inner_value == rhs.inner_value; }

        void accept(IRVisitor& visitor) override;
    };
}

using ConstantI1 = detail::BasicConstant<bool, IRBTYPE::I1>;
using ConstantI8 = detail::BasicConstant<char, IRBTYPE::I8>;
using ConstantInt = detail::BasicConstant<int, IRBTYPE::I32>;
using ConstantFloat = detail::BasicConstant<float, IRBTYPE::FLOAT>;

namespace detail
{
    template <typename T>
    auto getIRConstantTypeHelper() {
        using U = std::remove_reference_t<std::remove_cv_t<T>>;
        static_assert(std::is_same_v<U, bool> || std::is_same_v<U, char>
            || std::is_same_v<U, int> || std::is_same_v<U, float>,
            "Unexpected type.");

        if constexpr (std::is_same_v<U, bool>)
            return ConstantI1(false);
        else if constexpr (std::is_same_v<U, char>)
            return ConstantI8(0);
        else if constexpr (std::is_same_v<U, int>)
            return ConstantInt(0);
        else if constexpr (std::is_same_v<U, float>)
            return ConstantFloat(0);
    }
}

// Get IR representation for a cpp basic type:
// getIRConstantType<int>   -> ConstantInt
// getIRConstantType<float> -> ConstantFloat
// ...
template <typename ValueT>
using getIRConstantType = decltype(detail::getIRConstantTypeHelper<ValueT>());
}

#endif