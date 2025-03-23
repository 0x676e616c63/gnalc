#pragma once
#ifndef GNALC_CONFIG_HPP
#define GNALC_CONFIG_HPP

#include <string>

#include "utils.hpp"

namespace Test::cfg {
// Commandline args
inline bool stop_on_error = true;
inline bool only_frontend = true;

// See `docs/gnalc-test.md` to get prepared.

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
//
// Note that all the path is relative to the executing path
// gnalc(project dir) -> cmake-build-debug(CLion's build dir) -> test -> gnalc_test(executable)

const std::string gnalc_path = "../gnalc";

// backend
const std::string gcc_arm_command = "arm-linux-gnueabihf-gcc";
const std::string qemu_arm_command = "LD_LIBRARY_PATH=/usr/arm-linux-gnueabihf/libc/lib qemu-arm";

const std::string global_temp_dir = "./gnalc_test_temp/" + generate_unique_temp_dir();

const std::string global_benchmark_temp_dir = "./gnalc_benchmark_temp/" + generate_unique_temp_dir();

const std::string sylibc = "../../test/sylib/sylib.c";

const std::string test_data = "../../test/contest";
const std::vector subdirs = {"functional",    "performance",       "h_functional",
                             "h_performance", "final/performance", "final/h_performance"};
const std::vector benchmark_subdirs = {"performance", "h_performance", "final/performance", "final/h_performance"};
} // namespace Test::cfg

#endif // GNALC_CONFIG_HPP
