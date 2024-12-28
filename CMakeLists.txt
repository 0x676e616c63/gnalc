cmake_minimum_required(VERSION 3.10)
project(gnalc)

set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_STANDARD 17)

option(ENABLE_ASAN "Enable AddressSanitizer" OFF)

if (ENABLE_ASAN)
        message(STATUS "AddressSanitizer enabled")
        add_compile_options(-fsanitize=address -fno-omit-frame-pointer)
        add_link_options(-fsanitize=address)
endif()

include_directories(include)

aux_source_directory(lib/ir GNALC_IR_SRC)
aux_source_directory(lib/ir/instructions GNALC_IR_SRC)
aux_source_directory(lib/lexer GNALC_LEXER_SRC)
aux_source_directory(lib/opt GNALC_OPT_SRC)
aux_source_directory(lib/parser GNALC_PARSER_SRC)
aux_source_directory(lib/utils GNALC_UTILS_SRC)

add_executable(printast
        debug/printast.cpp
        lib/parser/parser.cpp
        lib/lexer/lexer.cpp
        lib/parser/ast_printer.cpp)

add_executable(irgen debug/irgen.cpp lib/irvisitors/irprinter.cpp ${GNALC_PARSER_SRC} ${GNALC_IR_SRC} ${GNALC_LEXER_SRC} ${GNALC_UTILS_SRC})

add_executable(printir debug/irprintertest.cpp lib/irvisitors/irprinter.cpp ${GNALC_IR_SRC} ${GNALC_UTILS_SRC})
