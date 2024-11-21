#pragma once
#ifndef PARSER_DATATYPE_H
#define PARSER_DATATYPE_H

#ifdef __cplusplus

#include <cstdint>
#include <string>

namespace AST
{
using int32 = int32_t;
using float32 = float;
using string = std::string;   
}

#else

#include <stdint.h>
#include <string.h>
#include <stdbool.h>

typedef int32_t int32;
typedef float float32;

#endif

#endif