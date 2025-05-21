#pragma once
#ifndef GNALC_TEST_CONFIG_HPP
#define GNALC_TEST_CONFIG_HPP

#include "utils.hpp"

#include <string>

namespace Test::cfg {
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
//              | functional_25
//              | h_functional_25
//              | performance_arm_25
//              | performance_rv_25
//
// Note that all the path is relative to the executing path
// gnalc(project dir) -> cmake-build-debug(CLion's build dir) -> test -> gnalc_test(executable)

static const std::string gnalc_path = "../gnalc";

// backend
// static const std::string gcc_arm_command = "arm-linux-gnueabihf-gcc";
static const std::string gcc_arm_command = "aarch64-linux-gnu-gcc-13"; // 13.3.0

// static const std::string qemu_arm_command = "LD_LIBRARY_PATH=/usr/arm-linux-gnueabihf/lib qemu-arm";
static const std::string qemu_arm_command = "LD_LIBRARY_PATH=/usr/aarch64-linux-gnu/lib qemu-aarch64";

static const std::string global_temp_dir = "./gnalc_test_temp/" + generate_unique_temp_dir();

static const std::string global_benchmark_temp_dir = "./gnalc_benchmark_temp/" + generate_unique_temp_dir();

static const std::string sylibc = "../../test/sylib/sylib.c";
// static const std::string sylibc = "sylib.c";

static const std::string test_data = "../../test/contest";
static const std::vector subdirs = {
    "functional",    "performance",       "h_functional",        "functional_25",      "h_functional_25",
    "h_performance", "final/performance", "final/h_performance", "performance_arm_25", "performance_rv_25"};
// const std::vector subdirs = {"functional", "performance"};
static const std::vector benchmark_subdirs = {"performance",         "h_performance",      "final/performance",
                                              "final/h_performance", "performance_arm_25", "performance_rv_25"};
} // namespace Test::cfg

#endif // GNALC_CONFIG_HPP
