#pragma once
#ifndef GNALC_MIRTOOLS_TOOL_HPP
#define GNALC_MIRTOOLS_TOOL_HPP

#include "../../include/ir/instruction.hpp"
#include "../../include/mir/instruction.hpp"
#include "enum_name.hpp"

#include <map>
#include <string>
#include <variant>

namespace MIR {

struct variant_toString {
    std::string operator()(int val) { return std::to_string(val); }
    std::string operator()(size_t val) { return std::to_string(val); }
    std::string operator()(float val) { return std::to_string(val); }
};

struct variant_visitor {

    template <typename T_enum> std::string operator()(T_enum emVal) {
        return enum_name(emVal);
    }

}; // for std::visit() when come into an enum type

extern std::map<IR::OP, MIR::OpCode> OPmap;

} // namespace MIR

#endif