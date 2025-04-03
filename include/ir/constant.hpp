/**
 * @brief 常量字面值的 IR Value 表示
 */

#pragma once
#ifndef GNALC_IR_CONSTANT_HPP
#define GNALC_IR_CONSTANT_HPP

#include "base.hpp"

#include <variant>

namespace IR {
namespace detail {
// For the sake of convenience, the name of a constant is the string
// representation of its value.
template <typename ValueT, IRBTYPE IRType> class BasicConstant : public Value {
    ValueT inner_value;

public:
    using value_type = ValueT;

    explicit BasicConstant(ValueT value_)
        : Value(toIRString(value_), makeBType(IRType), ValueTrait::CONSTANT_LITERAL), inner_value(value_) {}

    ValueT getVal() const { return inner_value; }

    bool operator==(const BasicConstant &rhs) const { return inner_value == rhs.inner_value; }

    void accept(IRVisitor &visitor) override;
};
} // namespace detail

using ConstantI1 = detail::BasicConstant<bool, IRBTYPE::I1>;
using ConstantI8 = detail::BasicConstant<char, IRBTYPE::I8>;
using ConstantInt = detail::BasicConstant<int, IRBTYPE::I32>;
using ConstantFloat = detail::BasicConstant<float, IRBTYPE::FLOAT>;

using pConstI1 = std::shared_ptr<ConstantI1>;
using pConstI8 = std::shared_ptr<ConstantI8>;
using pConstI32 = std::shared_ptr<ConstantInt>;
using pConstF32 = std::shared_ptr<ConstantFloat>;

namespace detail {
template <typename T> auto getIRConstantTypeHelper() {
    using U = std::remove_reference_t<std::remove_cv_t<T>>;
    static_assert(std::is_same_v<U, bool> || std::is_same_v<U, char> || std::is_same_v<U, int> ||
                      std::is_same_v<U, float>,
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
} // namespace detail

// Get IR representation for a cpp basic type:
// getIRConstantType<int>   -> ConstantInt
// getIRConstantType<float> -> ConstantFloat
// ...
template <typename ValueT> using getIRConstantType = decltype(detail::getIRConstantTypeHelper<ValueT>());
} // namespace IR

#endif