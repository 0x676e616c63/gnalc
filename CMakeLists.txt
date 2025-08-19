cmake_minimum_required(VERSION 3.10)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_STANDARD 17)

set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

project(gnalc)

option(ENABLE_ASAN "Enable AddressSanitizer" OFF)

if(NOT CMAKE_BUILD_TYPE)
        set(CMAKE_BUILD_TYPE Release)
endif()

if(${CMAKE_BUILD_TYPE} MATCHES Debug)
        # add `-fstandalone-debug` to fix CLion's bundled LLDB
        # See:
        #      - https://github.com/vadimcn/codelldb/issues/415
        #      - https://bugzilla.redhat.com/show_bug.cgi?id=1740927
        # Well, there are still some bugs, but fewer than before.
        add_compile_options("-g" "-fstandalone-debug" "-fsanitize=address" "-fno-omit-frame-pointer")
        add_link_options("-rdynamic" "-fsanitize=address")
endif()


if (ENABLE_ASAN)
        message(STATUS "AddressSanitizer enabled")
        add_compile_options(-fsanitize=address -fno-omit-frame-pointer)
        add_link_options(-fsanitize=address)
endif()

set(RUNTIME_ARTIFACTS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/runtime/artifacts)

set(RUNTIME_OUTPUTS ${RUNTIME_ARTIFACTS_DIR}/thread.ll.hpp ${RUNTIME_ARTIFACTS_DIR}/thread.armv8.s.hpp)
add_custom_command(
        OUTPUT ${RUNTIME_OUTPUTS}
        COMMAND python3 ${CMAKE_CURRENT_SOURCE_DIR}/runtime/compile.py
        ${RUNTIME_ARTIFACTS_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/runtime/thread.cpp
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMENT "Generating Gnalc Thread Runtime Header"
        VERBATIM
)
add_custom_target(generate_thread_rt DEPENDS ${RUNTIME_OUTPUTS})

include_directories(include)

# Frontend
aux_source_directory(lib/lexer GNALC_LEXER_SRC)
aux_source_directory(lib/parser GNALC_PARSER_SRC)

# SIR
aux_source_directory(lib/sir GNALC_SIR_SRC)
aux_source_directory(lib/sir/passes GNALC_SIR_SRC)
aux_source_directory(lib/sir/passes/analysis GNALC_SIR_SRC)
aux_source_directory(lib/sir/passes/transforms GNALC_SIR_SRC)
aux_source_directory(lib/sir/passes/utilities GNALC_SIR_SRC)

# IR
aux_source_directory(lib/ir GNALC_IR_SRC)
aux_source_directory(lib/ir/instructions GNALC_IR_SRC)
aux_source_directory(lib/ir/passes GNALC_IR_SRC)
aux_source_directory(lib/ir/passes/analysis GNALC_IR_SRC)
aux_source_directory(lib/ir/passes/helpers GNALC_IR_SRC)
aux_source_directory(lib/ir/passes/transforms GNALC_IR_SRC)
aux_source_directory(lib/ir/passes/utilities GNALC_IR_SRC)

# Legacy MIR
aux_source_directory(lib/legacy_mir GNALC_LEGACY_MIR_SRC)
aux_source_directory(lib/legacy_mir/builder GNALC_LEGACY_MIR_SRC)
aux_source_directory(lib/legacy_mir/instructions GNALC_LEGACY_MIR_SRC)
aux_source_directory(lib/legacy_mir/SIMDinstruction GNALC_LEGACY_MIR_SRC)
aux_source_directory(lib/legacy_mir/passes GNALC_LEGACY_MIR_SRC)
aux_source_directory(lib/legacy_mir/passes/analysis GNALC_LEGACY_MIR_SRC)
aux_source_directory(lib/legacy_mir/passes/transforms GNALC_LEGACY_MIR_SRC)
aux_source_directory(lib/legacy_mir/passes/utilities GNALC_LEGACY_MIR_SRC)

# MIR
aux_source_directory(lib/mir GNALC_MIR_SRC)
aux_source_directory(lib/mir/armv8 GNALC_MIR_SRC)
aux_source_directory(lib/mir/riscv64 GNALC_MIR_SRC)
aux_source_directory(lib/mir/passes GNALC_MIR_SRC)
aux_source_directory(lib/mir/passes/analysis GNALC_MIR_SRC)
aux_source_directory(lib/mir/passes/transforms GNALC_MIR_SRC)
aux_source_directory(lib/mir/passes/utilities GNALC_MIR_SRC)

# Runtime
aux_source_directory(lib/runtime GNALC_RUNTIME_SRC)

# Pass Manager
aux_source_directory(lib/pass_manager GNALC_PM_SRC)

# Match
aux_source_directory(lib/match GNALC_MATCH_SRC)

# Constraint
aux_source_directory(lib/constraint GNALC_CONSTRAINT_SRC)

# Utilities
aux_source_directory(lib/utils GNALC_UTILS_SRC)

# BrainFk Extension
aux_source_directory(lib/codegen/brainfk GNALC_EXT_BFBKD_SRC)

# ARMv7 Codegen
aux_source_directory(lib/codegen/armv7 GNALC_ARMV7BKD_SRC) 

# ARMv8 Codegen
aux_source_directory(lib/codegen/armv8 GNALC_ARMV8BKD_SRC)

# RISCV64 Codegen
aux_source_directory(lib/codegen/riscv64 GNALC_RISCV64BKD_SRC)

# GGC Extension
aux_source_directory(lib/ggc GNALC_EXT_GGC_SRC)

# ALL
set(GNALC_SRC
        ${GNALC_LEXER_SRC}
        ${GNALC_PARSER_SRC}
        ${GNALC_SIR_SRC}
        ${GNALC_IR_SRC}
        ${GNALC_MIR_SRC}
        ${GNALC_PM_SRC}
        ${GNALC_MATCH_SRC}
        ${GNALC_CONSTRAINT_SRC}
        ${GNALC_ARMV8BKD_SRC}
        ${GNALC_RISCV64BKD_SRC}
        ${GNALC_RUNTIME_SRC}
        ${GNALC_UTILS_SRC})

# GGC
set(GGC_SRC
        ${GNALC_EXT_GGC_SRC}
        ${GNALC_SIR_SRC}
        ${GNALC_IR_SRC}
        ${GNALC_MIR_SRC}
        ${GNALC_PM_SRC}
        ${GNALC_MATCH_SRC}
        ${GNALC_CONSTRAINT_SRC}
        ${GNALC_ARMV8BKD_SRC}
        ${GNALC_RISCV64BKD_SRC}
        ${GNALC_RUNTIME_SRC}
        ${GNALC_UTILS_SRC})

# debug driver
add_executable(pmtest tools/driver/debug/pmtest.cpp ${GNALC_SRC})
add_executable(omega_test tools/driver/debug/omega_test.cpp ${GNALC_CONSTRAINT_SRC} ${GNALC_UTILS_SRC})
add_executable(bfhelper tools/driver/debug/bfhelper.cpp)
target_compile_definitions(bfhelper PRIVATE GNALC_EXTENSION_BRAINFK)

# main driver, with ARMv8 and RISCV64, default ARMv8
add_executable(gnalc tools/driver/driver.cpp ${GNALC_SRC})

# RISCV64 driver, with ARMv8 and RISCV64, but default RISCV64
add_executable(gnalc_rv64 tools/driver/driver.cpp ${GNALC_SRC})
target_compile_definitions(gnalc_rv64 PRIVATE GNALC_DEFAULT_RISCV64)

# with GGC Extension
add_executable(ggc tools/driver/driver.cpp ${GGC_SRC})
target_compile_definitions(ggc PRIVATE GNALC_EXTENSION_GGC)

# with BrainFk
add_executable(gnalc_bf tools/driver/driver.cpp ${GNALC_SRC} ${GNALC_EXT_BFBKD_SRC})
target_compile_definitions(gnalc_bf PRIVATE GNALC_EXTENSION_BRAINFK)

# with ARMv7
add_executable(gnalc_armv7 tools/driver/driver.cpp ${GNALC_SRC} ${GNALC_LEGACY_MIR_SRC} ${GNALC_ARMV7BKD_SRC})
target_compile_definitions(gnalc_armv7 PRIVATE GNALC_EXTENSION_ARMv7)

add_dependencies(gnalc generate_thread_rt)
add_dependencies(gnalc_rv64 generate_thread_rt)
add_dependencies(ggc generate_thread_rt)
add_dependencies(gnalc_bf generate_thread_rt)
add_dependencies(gnalc_armv7 generate_thread_rt)

enable_testing()
add_subdirectory(test)