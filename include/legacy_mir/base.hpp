// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_BASE_HPP
#define GNALC_LEGACY_MIR_BASE_HPP

#include <memory>
#include <string>

namespace LegacyMIR {

enum class ValueTrait {
    Unknown,
    Module,
    Function,
    BasicBlock,
    MachineInst,
    Operand,
};

class NameC {
private:
    std::string name;

public:
    NameC() = default;
    explicit NameC(std::string _name) : name(std::move(_name)) {}

    void setName(std::string _name) { name = std::move(_name); }
    bool isName(const std::string& _name) const { return _name == name; }
    std::string getName() const { return name; }
};

template <typename T, typename... Args> std::shared_ptr<T> make(Args &&...args) {
    return std::make_shared<T>(std::forward<Args>(args)...);
}

class Value : public NameC, public std::enable_shared_from_this<Value> {
private:
    ValueTrait vtrait;

public:
    Value() = delete;
    explicit Value(ValueTrait _vtrait);

    Value(ValueTrait _vtrait, std::string _name);

    ValueTrait getValueTrait() const;

    template <typename T> std::shared_ptr<const T> as() const {
        static_assert(std::is_base_of_v<Value, T>, "Expected a derived type.");
        return std::dynamic_pointer_cast<const T>(shared_from_this());
    }

    template <typename T> const T *as_raw() const {
        static_assert(std::is_base_of_v<Value, T>, "Expected a derived type.");
        return dynamic_cast<const T *>(this);
    }

    template <typename T> std::shared_ptr<T> as() {
        static_assert(std::is_base_of_v<Value, T>, "Expected a derived type.");
        return std::dynamic_pointer_cast<T>(shared_from_this());
    }

    template <typename T> T *as_raw() {
        static_assert(std::is_base_of_v<Value, T>, "Expected a derived type.");
        return dynamic_cast<T *>(this);
    }

    virtual std::string toString() const = 0;
    virtual ~Value() = default;
};

} // namespace MIR

#endif
#endif