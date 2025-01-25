#pragma once
#ifndef GNALC_MIRTOOLS_TOOL_HPP
#define GNALC_MIRTOOLS_TOOL_HPP

#include "enum_name.hpp"

#include <string>
#include <variant>

namespace MIR {
struct variant_visitor {
    template <typename T_enum> std::string operator()(T_enum emVal) {
        return static_cast<std::string>(enum_name(emVal));
    }
}; // for std::visit() when come into an enum type
} // namespace MIR

#endif