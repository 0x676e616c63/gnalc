cmake_minimum_required(VERSION 3.10)
project(gnalc)

set(CMAKE_CXX_STANDARD 17)

include_directories(include)

add_executable(printast
        debug/printast.cpp
        lib/parser/parser.cpp
        lib/lexer/lexer.cpp
        lib/parser/ast_printer.cpp)

add_executable(irgen
        debug/irgen.cpp
        lib/parser/parser.cpp
        lib/parser/irgen.cpp
        lib/ir/base.cpp
        lib/ir/function.cpp
        lib/ir/module.cpp
        lib/ir/type.cpp
        lib/lexer/lexer.cpp
)

