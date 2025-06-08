cmake_minimum_required(VERSION 3.10)
project(gnalc)

set(CMAKE_CXX_STANDARD 17)
include_directories(include)
include_directories(../include)

add_link_options("-rdynamic")

add_executable(pass_benchmark benchmark.cpp benchmark_registry.cpp)
add_executable(gnalc_test test.cpp)
add_executable(timer timer.cpp)
add_test(NAME base COMMAND gnalc_test)
add_test(NAME std COMMAND gnalc_test -p -std-pipeline)
add_test(NAME fixedpoint COMMAND gnalc_test -p -fixed-point)
add_test(NAME fuzz COMMAND gnalc_test -p -fuzz)

add_test(NAME backend_o1 COMMAND gnalc_test -p -O1 -b)

add_executable(ggc_test test.cpp)
target_compile_definitions(ggc_test PRIVATE GNALC_TEST_GGC)