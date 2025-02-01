// Proxy for IR Constants, providing easy interface through type erasure.
#pragma once
#ifndef GNALC_IR_CONSTANT_PROXY_HPP
#define GNALC_IR_CONSTANT_PROXY_HPP

#include "base.hpp"
#include "constant.hpp"

#include <functional>
#include <variant>
#include <memory>

#include "../utils/misc.hpp"

namespace IR {
class ConstantPool;
class ConstantProxyHash;
// Proxy for IR Constants, providing easy interface through type erasure.
// Warning:
//   1. This is not a part of the IR, due to its "dynamic" type. (NOT a derived class from `IR::Value`)
//   2. It throws an exception in operation between different type.
//   3. It depends on ConstantPool only in operators that generates new constant.
class ConstantProxy {
    friend class ConstantProxyHash;
private:
    std::variant<std::shared_ptr<ConstantI1>,
    std::shared_ptr<ConstantI8>,
    std::shared_ptr<ConstantInt>,
    std::shared_ptr<ConstantFloat>> value;

    ConstantPool* pool;
public:
    ConstantProxy() = delete;
    ConstantProxy(const ConstantProxy&) = default;
    ConstantProxy& operator=(const ConstantProxy&) = default;
    ConstantProxy(ConstantProxy&&) = default;
    ConstantProxy& operator=(ConstantProxy&&) = default;

    explicit ConstantProxy(ConstantPool* pool_, std::shared_ptr<ConstantI1> value_);
    explicit ConstantProxy(ConstantPool* pool_, std::shared_ptr<ConstantI8> value_);
    explicit ConstantProxy(ConstantPool* pool_, std::shared_ptr<ConstantInt> value_);
    explicit ConstantProxy(ConstantPool* pool_, std::shared_ptr<ConstantFloat> value_);

    explicit ConstantProxy(ConstantPool* pool_, const std::shared_ptr<Value>& value_);

    explicit ConstantProxy(ConstantPool* pool_, bool value_);
    explicit ConstantProxy(ConstantPool* pool_, char value_);
    explicit ConstantProxy(ConstantPool* pool_, int value_);
    explicit ConstantProxy(ConstantPool* pool_, float value_);

    ConstantProxy operator+(const ConstantProxy& rhs) const;
    ConstantProxy operator-(const ConstantProxy& rhs) const;
    ConstantProxy operator*(const ConstantProxy& rhs) const;
    ConstantProxy operator/(const ConstantProxy& rhs) const;
    ConstantProxy operator%(const ConstantProxy& rhs) const;
    ConstantProxy operator&&(const ConstantProxy& rhs) const;
    ConstantProxy operator||(const ConstantProxy& rhs) const;

    ConstantProxy operator&&(bool rhs) const;
    ConstantProxy operator||(bool rhs) const;

    ConstantProxy operator+(char rhs) const;
    ConstantProxy operator-(char rhs) const;
    ConstantProxy operator*(char rhs) const;
    ConstantProxy operator/(char rhs) const;
    ConstantProxy operator%(char rhs) const;

    ConstantProxy operator+(int rhs) const;
    ConstantProxy operator-(int rhs) const;
    ConstantProxy operator*(int rhs) const;
    ConstantProxy operator/(int rhs) const;
    ConstantProxy operator%(int rhs) const;

    ConstantProxy operator+(float rhs) const;
    ConstantProxy operator-(float rhs) const;
    ConstantProxy operator*(float rhs) const;
    ConstantProxy operator/(float rhs) const;

    bool operator==(const ConstantProxy& rhs) const;
    bool operator==(bool rhs) const;
    bool operator==(char rhs) const;
    bool operator==(int rhs) const;
    bool operator==(float rhs) const;

    std::shared_ptr<ConstantI1> getConstantI1() const;
    std::shared_ptr<ConstantI8> getConstantI8() const;
    std::shared_ptr<ConstantInt> getConstantInt() const;
    std::shared_ptr<ConstantFloat> getConstantFloat() const;

    std::shared_ptr<Value> getConstant() const;

    bool get_i1() const;
    char get_i8() const;
    int get_int() const;
    float get_float() const;

    void setPool(ConstantPool* pool_);
};

class ConstantProxyHash {
public:
    std::size_t operator()(const ConstantProxy& constant) const;
};
}

#endif