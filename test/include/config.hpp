// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_TEST_CONFIG_HPP
#define GNALC_TEST_CONFIG_HPP

#include "utils.hpp"

#include <string>

namespace Test::cfg {
// See `docs/testsuite.md` to get prepared.

//
//  gnalc -> test -> contest
//  contest ->
//              |  functional
//              |  h_functional
//              |  performance
//              |  h_performance
//              |  final ->
//                         |  performance
//                         |  h_performance
//              | functional_25
//              | h_functional_25
//              | performance_arm_25
//              | performance_rv_25
//
// Note that all the path is relative to the executing path
// gnalc(project dir) -> cmake-build-debug(CLion's build dir) -> test -> gnalc_test(executable)

extern std::string gnalc_path;
extern std::string gcc_arm_command;
extern std::string qemu_arm_command;
extern std::string gcc_rv_command;
extern std::string qemu_rv_command;

extern std::string global_temp_dir;
       
extern std::string global_benchmark_temp_dir;
       
extern std::string sylibc;
       
extern std::string test_data;
extern std::vector<std::string> subdirs;
extern std::vector<std::string> benchmark_subdirs;
extern void init();
} // namespace Test::cfg

#endif // GNALC_CONFIG_HPP
