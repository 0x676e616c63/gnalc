#pragma once
#ifndef GNALC_MIR_TOOL_HPP
#define GNALC_MIR_TOOL_HPP
#include "../mirtools/magic_enum.hpp"

struct variant_visitor {
    template <typename T_enum> std::string operator()(T_enum emVal) {
        return static_cast<std::string>(magic_enum::enum_name(emVal));
    }
}; // for std::visit() when come into an enum type

#endif