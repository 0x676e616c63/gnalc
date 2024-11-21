/**
 * @brief just define int32, float32
 * @attention lexer部分准备全部用C，故注释CPP部分，该文件可能以后被合并
 */

#pragma once
#ifndef PARSER_DATATYPE_H
#define PARSER_DATATYPE_H

// #ifdef __cplusplus

// #include <cstdint>
// #include <string>

// namespace AST
// {
// using int32 = int32_t;
// using float32 = float;
// using string = std::string;   
// }

// #else

#include <stdint.h>

typedef int32_t int32;
typedef float float32;

// #endif

#endif