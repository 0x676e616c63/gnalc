cmake_minimum_required(VERSION 3.10)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_STANDARD 17)

project(gnalc)

option(ENABLE_ASAN "Enable AddressSanitizer" OFF)

# add `-fstandalone-debug` to fix CLion's bundled LLDB
# See:
#      - https://github.com/vadimcn/codelldb/issues/415
#      - https://bugzilla.redhat.com/show_bug.cgi?id=1740927
# Well, there are still some bugs, but fewer than before.
add_compile_options("-g" "-fstandalone-debug")

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

# MIR
aux_source_directory(lib/mir GNALC_MIR_SRC)
aux_source_directory(lib/mir/builder GNALC_MIR_SRC)
# aux_source_directory(lib/mirtools GNALC_MIR_SRC)
aux_source_directory(lib/mir/instruction GNALC_MIR_SRC)
aux_source_directory(lib/mir/passes GNALC_MIR_SRC)
# aux_source_directory(lib/mir/passes/analysis GNALC_MIR_SRC)
aux_source_directory(lib/mir/passes/transforms GNALC_MIR_SRC)
aux_source_directory(lib/mir/passes/utilities GNALC_MIR_SRC)

# Pass Manager
aux_source_directory(lib/pass_manager GNALC_PM_SRC)

# Utilities
aux_source_directory(lib/utils GNALC_UTILS_SRC)

# BrainFk Extension
aux_source_directory(lib/codegen/brainfk GNALC_EXT_BFBKD_SRC)

# ALL
set(GNALC_SRC ${GNALC_LEXER_SRC} ${GNALC_PARSER_SRC} ${GNALC_IR_SRC} ${GNALC_MIR_SRC} ${GNALC_PM_SRC} ${GNALC_EXT_BFBKD_SRC} ${GNALC_UTILS_SRC})

# debug driver
add_executable(pmtest tools/driver/debug/pmtest.cpp ${GNALC_SRC})
add_executable(generic_visitor_test tools/driver/debug/generic_visitor_test.cpp ${GNALC_SRC})
add_executable(bfhelper tools/driver/debug/bfhelper.cpp)

# main driver
add_executable(gnalc tools/driver/driver.cpp ${GNALC_SRC})

enable_testing()
add_subdirectory(test)