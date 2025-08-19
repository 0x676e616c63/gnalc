cmake_minimum_required(VERSION 3.10)
project(gnalc)

set(CMAKE_CXX_STANDARD 17)
include_directories(include)
include_directories(../include)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

if(${CMAKE_BUILD_TYPE} MATCHES Debug)
    # add `-fstandalone-debug` to fix CLion's bundled LLDB
    # See:
    #      - https://github.com/vadimcn/codelldb/issues/415
    #      - https://bugzilla.redhat.com/show_bug.cgi?id=1740927
    # Well, there are still some bugs, but fewer than before.
    add_compile_options("-g" "-fstandalone-debug")
    add_link_options("-rdynamic")
endif()

add_executable(pass_benchmark benchmark.cpp benchmark_registry.cpp config.cpp runner.cpp)
add_executable(gnalc_test test.cpp config.cpp runner.cpp)
add_executable(ghaction ghaction_no_multithreading.cpp config.cpp runner.cpp)
add_executable(timer timer.cpp config.cpp runner.cpp)

add_executable(ggc_test test.cpp config.cpp runner.cpp)
target_compile_definitions(ggc_test PRIVATE GNALC_TEST_GGC)

add_test(NAME base COMMAND gnalc_test)
add_test(NAME std COMMAND gnalc_test -p -std-pipeline)
add_test(NAME fixedpoint COMMAND gnalc_test -p -fixed-point)
add_test(NAME fuzz COMMAND gnalc_test -p -fuzz)

add_test(NAME backend_o1 COMMAND gnalc_test -p -O1 -b --gh-action)