/**
 * @brief dtype, num
 * @todo dtype设计为类？考虑到诸如PrintType等可能封装起来更好些
 * @todo num重新设计...总觉得用起来别扭
 */

#ifndef GNALC_PARSER_BASETYPE_HPP
#define GNALC_PARSER_BASETYPE_HPP
#pragma once

#include <cstdint>
#include <string>


namespace AST {

using int32 = int32_t;
using float32 = float;
using string = std::string;

enum class dtype_type {
    INT,
    FLOAT,
    VOID,
    UNDEFINED
};

using dtype = enum dtype_type;

class num {
private:
    union {
        float32 f;
        int32 i;
    } _value;
    bool _float = false;
    bool _int = false;

public:
    num(float32 f) : _value{.f = f}, _float(true) {}
    num(int32 i) : _value{.i = i}, _int(true) {}

    bool isFloat() const { return _float; }
    bool isInt() const { return _int; }

    auto getInt() const { return _value.i; }
    auto getFloat() const { return _value.f; }

    ~num() = default;
};

}

#endif
