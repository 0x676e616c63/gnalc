#pragma once
#ifndef GNALC_MIR_BASE_HPP
#define GNALC_MIR_BASE_HPP
#include "../ir/type.hpp"
#include <list>
#include <memory>
#include <string>

namespace MIR {

enum class ValueTrait {
    Unknown,
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
    Value(ValueTrait _vtrait) : IR::NameC(), vtrait(_vtrait){};
    Value(ValueTrait _vtrait, std::string _name)
        : IR::NameC(_name), vtrait(_vtrait){};
    ValueTrait getValueTrait() { return vtrait; };

    virtual std::string toString() = 0;
    ~Value() = default;
};

} // namespace MIR

#endif