#pragma once
#ifndef GNALC_MIR_BASE_HPP
#define GNALC_MIR_BASE_HPP
#include "../ir/type.hpp"
#include <string>

namespace MIR {

enum class ValueTrait {
    Unknown,
    Module,
    Function,
    BasicBlock,
    MachineInst,
    Operand,
};

template <typename T, typename... Args> std::shared_ptr<T> make(Args &&...args) {
    return std::make_shared<T>(std::forward<Args>(args)...);
}

class Value : public IR::NameC, public std::enable_shared_from_this<Value> {
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