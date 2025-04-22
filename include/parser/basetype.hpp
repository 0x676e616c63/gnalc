/**
 * @brief dtype, num
 * @todo dtype 设计为类？考虑到诸如 PrintType 等可能封装起来更好些
 * @todo num 重新设计...总觉得用起来别扭
 */

#ifndef GNALC_PARSER_BASETYPE_HPP
#define GNALC_PARSER_BASETYPE_HPP
#pragma once

#include <cstdint>
#include <string>
#include <variant>

namespace AST {

using int32 = int32_t;
using float32 = float;
using string = std::string;

enum class dtype { INT, FLOAT, VOID, UNDEFINED };

class num {
    std::variant<int, float> value;

public:
    num(float32 f) : value(f) {}
    num(int32 i) : value(i) {}

    bool isFloat() const { return value.index() == 1; }
    bool isInt() const { return value.index() == 0; }

    auto getInt() const { return std::get<int>(value); }
    auto getFloat() const { return std::get<float>(value); }

    ~num() = default;
};

} // namespace AST

#endif
