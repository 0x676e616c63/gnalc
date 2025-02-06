cmake_minimum_required(VERSION 3.10)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_STANDARD 17)

project(gnalc)

option(ENABLE_ASAN "Enable AddressSanitizer" OFF)

add_compile_options("-g")

if (ENABLE_ASAN)
        message(STATUS "AddressSanitizer enabled")
        add_compile_options(-fsanitize=address -fno-omit-frame-pointer)
        add_link_options(-fsanitize=address)
endif()

#include_directories(include)

# Frontend
aux_source_directory(lib/lexer GNALC_LEXER_SRC)
aux_source_directory(lib/parser GNALC_PARSER_SRC)

# IR
aux_source_directory(lib/ir GNALC_IR_SRC)
aux_source_directory(lib/ir/instructions GNALC_IR_SRC)
aux_source_directory(lib/ir/passes GNALC_IR_SRC)
aux_source_directory(lib/ir/passes/analysis GNALC_IR_SRC)
aux_source_directory(lib/ir/passes/transforms GNALC_IR_SRC)
aux_source_directory(lib/ir/passes/utilities GNALC_IR_SRC)

# Pass Manager
aux_source_directory(lib/pass_manager GNALC_PM_SRC)

# Utilities
aux_source_directory(lib/utils GNALC_UTILS_SRC)

# BrainFk Extension
aux_source_directory(lib/codegen/brainfk GNALC_EXT_BFBKD_SRC)

# ALL
set(GNALC_SRC ${GNALC_LEXER_SRC} ${GNALC_PARSER_SRC} ${GNALC_IR_SRC} ${GNALC_PM_SRC} ${GNALC_EXT_BFBKD_SRC} ${GNALC_UTILS_SRC})

# debug driver
add_executable(irgen tools/driver/debug/irgen.cpp ${GNALC_SRC})

add_executable(bfhelper tools/driver/debug/bfhelper.cpp)

# main driver
add_executable(gnalc tools/driver/driver.cpp ${GNALC_SRC})

enable_testing()
add_subdirectory(test)