cmake_minimum_required(VERSION 3.10)
project(gnalc)

set(CMAKE_CXX_STANDARD 17)
include_directories(../include)

add_executable(pass_benchmark benchmark.cpp)
add_executable(gnalc_test test.cpp)
add_test(NAME gnalc_test COMMAND gnalc_test --no-lfs)
