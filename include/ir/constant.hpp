// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

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
    using inner_type = ValueT;

    explicit BasicConstant(ValueT value_)
        : Value(toIRString(value_), makeBType(IRType), ValueTrait::CONSTANT_LITERAL), inner_value(value_) {}

    ValueT getVal() const { return inner_value; }

    bool operator==(const BasicConstant &rhs) const { return inner_value == rhs.inner_value; }

    void accept(IRVisitor &visitor) override;
};

template <typename ValueT, IRBTYPE IRType> class BasicConstantVector : public Value {
    std::vector<ValueT> inner_values;

public:
    using inner_type = std::vector<ValueT>;
    using value_type = ValueT;
    using iterator = typename std::vector<ValueT>::iterator;
    using const_iterator = typename std::vector<ValueT>::const_iterator;
    using reverse_iterator = typename std::vector<ValueT>::reverse_iterator;
    using const_reverse_iterator = typename std::vector<ValueT>::const_reverse_iterator;

    explicit BasicConstantVector(const std::vector<ValueT> &value_)
        : Value(toIRString(value_), makeVectorType(makeBType(IRType), value_.size()),
            ValueTrait::CONSTANT_LITERAL), inner_values(value_) {}

    const auto &getVector() const { return inner_values; }

    value_type operator[](size_t index) const { return inner_values[index]; }

    bool operator==(const BasicConstantVector &rhs) const { return inner_values == rhs.inner_values; }

    const_iterator begin() const { return inner_values.begin(); }
    const_iterator end() const { return inner_values.end(); }
    iterator begin() { return inner_values.begin(); }
    iterator end() { return inner_values.end(); }
    const_iterator cbegin() const { return inner_values.cbegin(); }
    const_iterator cend() const { return inner_values.cend(); }

    const_reverse_iterator rbegin() const { return inner_values.rbegin(); }
    const_reverse_iterator rend() const { return inner_values.rend(); }
    reverse_iterator rbegin() { return inner_values.rbegin(); }
    reverse_iterator rend() { return inner_values.rend(); }
    const_reverse_iterator crbegin() const { return inner_values.crbegin(); }
    const_reverse_iterator crend() const { return inner_values.crend(); }

    auto size() const { return inner_values.size(); }

    void accept(IRVisitor &visitor) override;
};
} // namespace detail

using ConstantI1 = detail::BasicConstant<bool, IRBTYPE::I1>;
using ConstantI8 = detail::BasicConstant<char, IRBTYPE::I8>;
using ConstantInt = detail::BasicConstant<int, IRBTYPE::I32>;
using ConstantI64 = detail::BasicConstant<int64_t, IRBTYPE::I64>;
using ConstantFloat = detail::BasicConstant<float, IRBTYPE::FLOAT>;
using ConstantIntVector = detail::BasicConstantVector<int, IRBTYPE::I32>;
using ConstantFloatVector = detail::BasicConstantVector<float, IRBTYPE::FLOAT>;

using pConstI1 = std::shared_ptr<ConstantI1>;
using pConstI8 = std::shared_ptr<ConstantI8>;
using pConstI32 = std::shared_ptr<ConstantInt>;
using pConstI64 = std::shared_ptr<ConstantI64>;
using pConstF32 = std::shared_ptr<ConstantFloat>;
using pConstI32Vec = std::shared_ptr<ConstantIntVector>;
using pConstF32Vec = std::shared_ptr<ConstantFloatVector>;

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
    else if constexpr (std::is_same_v<U, int64_t>)
        return ConstantI64(0);
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