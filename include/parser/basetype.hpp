/**
 * @ast中的数据类型等
 */
#pragma once
#ifndef __PARSER_BASETYPE_HPP__
#define __PARSER_BASETYPE_HPP__

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

// 弃用：内含到 vardecl, funcdef 中
// (const) int, float; void; int[], float[]
// class dtype {
// private:
//     bool _constvar;
//     bool _var;
//     bool _array;
//     bool _func;
//     dtype_type type;

// public:
//     dtype(dtype_type type, bool constvar = false, bool array = false, bool var = false, bool func = false)
//         : type(type), _constvar(constvar), _var(var), _array(array), _func(func) {}

//     dtype set_const() { _constvar = true; return *this; }
//     dtype set_array() { _array = true; return *this; }
//     dtype set_var() { _var = true; return *this; }
//     dtype set_func() { _func = true; return *this; }
//     bool isconst() const { return _constvar; }
//     bool isarray() const { return _array; }
//     bool isvar() const { return _var; }
//     bool isfunc() const { return _func; }
//     dtype_type getdtype() const { return type; }
//     bool isvoid() const { return type == dtype_type::VOID; }
//     bool isint() const { return type == dtype_type::INT; }
//     bool isfloat() const { return type == dtype_type::FLOAT; }
// };

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

    bool isfloat() const { return _float; }
    bool isint() const { return _int; }
    float32 getfloat() const { return _value.f; }
    int32 getint() const { return _value.i; }
};

}

#endif
