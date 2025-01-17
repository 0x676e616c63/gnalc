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

aux_source_directory(lib/ir GNALC_IR_SRC)
aux_source_directory(lib/ir/instructions GNALC_IR_SRC)
aux_source_directory(lib/irvisitors GNALC_IRVISITORS_SRC)
aux_source_directory(lib/iropt GNALC_IROPTS_SRC)
aux_source_directory(lib/lexer GNALC_LEXER_SRC)
aux_source_directory(lib/opt GNALC_OPT_SRC)
aux_source_directory(lib/parser GNALC_PARSER_SRC)
aux_source_directory(lib/utils GNALC_UTILS_SRC)
aux_source_directory(lib/codegen/brainfk GNALC_BFBACKEND_SRC)

set(GNALC_SRC ${GNALC_IR_SRC} ${GNALC_IRVISITORS_SRC} ${GNALC_IROPTS_SRC} ${GNALC_LEXER_SRC} ${GNALC_OPT_SRC} ${GNALC_PARSER_SRC} ${GNALC_UTILS_SRC} ${GNALC_BFBACKEND_SRC})

add_executable(printast tools/driver/debug/printast.cpp lib/parser/parser.cpp lib/lexer/lexer.cpp lib/parser/ast_printer.cpp)

add_executable(printir tools/driver/debug/irprintertest.cpp lib/irvisitors/irprinter.cpp ${GNALC_IR_SRC} ${GNALC_UTILS_SRC})

add_executable(irgen tools/driver/debug/irgen.cpp ${GNALC_SRC})

add_executable(bfgen tools/driver/debug/bfgen.cpp ${GNALC_SRC})

add_executable(gnalc tools/driver/driver.cpp ${GNALC_SRC})

enable_testing()
add_subdirectory(test)