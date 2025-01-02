cmake_minimum_required(VERSION 3.10)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_STANDARD 17)

project(gnalc)

option(ENABLE_ASAN "Enable AddressSanitizer" OFF)

if (ENABLE_ASAN)
        message(STATUS "AddressSanitizer enabled")
        add_compile_options(-fsanitize=address -fno-omit-frame-pointer)
        add_link_options(-fsanitize=address)
endif()

include_directories(include)

include_directories(BackEnd/include)

aux_source_directory(lib/ir GNALC_IR_SRC)
aux_source_directory(lib/ir/instructions GNALC_IR_SRC)
aux_source_directory(lib/lexer GNALC_LEXER_SRC)
aux_source_directory(lib/opt GNALC_OPT_SRC)
aux_source_directory(lib/parser GNALC_PARSER_SRC)
aux_source_directory(lib/utils GNALC_UTILS_SRC)

aux_source_directory(BackEnd/lib GNALC_BACKEND_SRC)
aux_source_directory(BackEnd/lib/ArmComplexMIRStruct GNALC_BACKEND_SRC)
aux_source_directory(BackEnd/lib/tools GNALC_BACKEND_SRC)

add_executable(printast
        debug/printast.cpp
        lib/parser/parser.cpp
        lib/lexer/lexer.cpp
        lib/parser/ast_printer.cpp)

add_executable(irgen debug/irgen.cpp lib/irvisitors/irprinter.cpp lib/irvisitors/cfgbuilder.cpp lib/iropt/live_analysis.cpp ${GNALC_PARSER_SRC} ${GNALC_IR_SRC} ${GNALC_LEXER_SRC} ${GNALC_UTILS_SRC})

add_executable(printir debug/irprintertest.cpp lib/irvisitors/irprinter.cpp ${GNALC_IR_SRC} ${GNALC_UTILS_SRC})

enable_testing()
add_subdirectory(test)
