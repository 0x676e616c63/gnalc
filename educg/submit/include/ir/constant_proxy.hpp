// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Proxy for IR Constants, providing easy interface through type erasure.
// Warning:
//   1. This is not a part of the IR, due to its "dynamic" type. (NOT a derived
//      class from `IR::Value`)
//   2. If type mismatched, ONLY `operator==`/`operator!=` returns false/true,
//      other operators will throw an exception.
//   3. It depends on ConstantPool only in operators that generates new
//   constant.
#pragma once
#ifndef GNALC_IR_CONSTANT_PROXY_HPP
#define GNALC_IR_CONSTANT_PROXY_HPP

#include "base.hpp"
#include "constant.hpp"

#include <functional>
#include <memory>
#include <variant>

namespace IR {
class ConstantPool;
class ConstantProxyHash;
class ConstantProxy {
    friend class ConstantProxyHash;

    std::variant<pConstI1, pConstI8, pConstI32, pConstI64, pConstF32, pConstI32Vec, pConstF32Vec> value;

    ConstantPool *pool;

public:
    ConstantProxy() = delete;
    ConstantProxy(const ConstantProxy &) = default;
    ConstantProxy &operator=(const ConstantProxy &) = default;
    ConstantProxy(ConstantProxy &&) = default;
    ConstantProxy &operator=(ConstantProxy &&) = default;

    explicit ConstantProxy(ConstantPool *pool_, pConstI1 value_);
    explicit ConstantProxy(ConstantPool *pool_, pConstI8 value_);
    explicit ConstantProxy(ConstantPool *pool_, pConstI32 value_);
    explicit ConstantProxy(ConstantPool *pool_, pConstI64 value_);
    explicit ConstantProxy(ConstantPool *pool_, pConstF32 value_);
    explicit ConstantProxy(ConstantPool *pool_, pConstI32Vec value_);
    explicit ConstantProxy(ConstantPool *pool_, pConstF32Vec value_);

    explicit ConstantProxy(ConstantPool *pool_, const pVal &value_);

    explicit ConstantProxy(ConstantPool *pool_, bool value_);
    explicit ConstantProxy(ConstantPool *pool_, char value_);
    explicit ConstantProxy(ConstantPool *pool_, int value_);
    explicit ConstantProxy(ConstantPool *pool_, int64_t value_);
    explicit ConstantProxy(ConstantPool *pool_, float value_);
    explicit ConstantProxy(ConstantPool *pool_, const std::vector<int>& value_);
    explicit ConstantProxy(ConstantPool *pool_, const std::vector<float>& value_);

    ConstantProxy operator+(const ConstantProxy &rhs) const;
    ConstantProxy operator-(const ConstantProxy &rhs) const;
    ConstantProxy operator*(const ConstantProxy &rhs) const;
    ConstantProxy operator/(const ConstantProxy &rhs) const;
    ConstantProxy operator%(const ConstantProxy &rhs) const;
    ConstantProxy operator&&(const ConstantProxy &rhs) const;
    ConstantProxy operator||(const ConstantProxy &rhs) const;
    ConstantProxy operator&(const ConstantProxy &rhs) const;
    ConstantProxy operator|(const ConstantProxy &rhs) const;
    ConstantProxy operator^(const ConstantProxy &rhs) const;
    ConstantProxy operator<<(const ConstantProxy &rhs) const;
    ConstantProxy lshr(const ConstantProxy &rhs) const;
    ConstantProxy ashr(const ConstantProxy &rhs) const;
    ConstantProxy urem(const ConstantProxy &rhs) const;

    ConstantProxy operator+() const;
    ConstantProxy operator-() const;
    ConstantProxy operator!() const;

    // Only Same Type
    bool operator<(const ConstantProxy &rhs) const;
    bool operator>(const ConstantProxy &rhs) const;
    bool operator<=(const ConstantProxy &rhs) const;
    bool operator>=(const ConstantProxy &rhs) const;

    bool operator==(const ConstantProxy &rhs) const;
    bool operator!=(const ConstantProxy &rhs) const;

    bool operator==(bool rhs) const;
    bool operator==(char rhs) const;
    bool operator==(int rhs) const;
    bool operator==(int64_t rhs) const;
    bool operator==(float rhs) const;

    pConstI1 getConstantI1() const;
    pConstI8 getConstantI8() const;
    pConstI32 getConstantInt() const;
    pConstI64 getConstantI64() const;
    pConstF32 getConstantFloat() const;
    pConstI32Vec getConstantIntVector() const;
    pConstF32Vec getConstantFloatVector() const;

    pVal getConstant() const;
    pType getType() const;

    bool get_i1() const;
    char get_i8() const;
    int get_int() const;
    int64_t get_i64() const;
    float get_float() const;
    std::vector<int> get_i32_vector() const;
    std::vector<float> get_f32_vector() const;

    void setPool(ConstantPool *pool_);
};

class ConstantProxyHash {
public:
    std::size_t operator()(const ConstantProxy &constant) const;
};
} // namespace IR

#endif