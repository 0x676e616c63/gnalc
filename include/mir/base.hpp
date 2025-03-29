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

class Value : public IR::NameC {
private:
    ValueTrait vtrait;

public:
    Value() = delete;
    explicit Value(ValueTrait _vtrait);

    Value(ValueTrait _vtrait, std::string _name);

    ValueTrait getValueTrait() const;

    virtual std::string toString() const = 0;
    virtual ~Value() = default;
};

} // namespace MIR

#endif