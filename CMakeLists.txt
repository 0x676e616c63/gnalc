cmake_minimum_required(VERSION 3.10)
project(gnalc)

set(CMAKE_CXX_STANDARD 20)

include_directories(include)

add_executable(gnalc
        lib/ir/base.cpp
        lib/ir/function.cpp
        lib/ir/module.cpp
        lib/ir/type.cpp)
