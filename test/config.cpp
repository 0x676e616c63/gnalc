// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "config.hpp"
#include "utils.hpp"
#include <string>

namespace Test::cfg {
std::string gnalc_path;
std::string gcc_arm_command;
std::string qemu_arm_command;
std::string gcc_rv_command;
std::string qemu_rv_command;

std::string global_temp_dir;

std::string global_benchmark_temp_dir;

std::string sylibc;

std::string test_data;
std::vector<std::string> subdirs;
std::vector<std::string> benchmark_subdirs;

void init() {
    // Fallback Config
#if defined(__aarch64__)
    // For Raspberry Pi
    gcc_arm_command = "gcc";
    qemu_arm_command = "";
#else
    gcc_arm_command = "aarch64-linux-gnu-gcc --sysroot=/usr/aarch64-redhat-linux/sys-root/fc42";
    qemu_arm_command = "qemu-aarch64 -cpu cortex-a53 -L /usr/aarch64-redhat-linux/sys-root/fc42/usr/";
#endif

    gcc_rv_command = "riscv64-linux-gnu-gcc";
    qemu_rv_command = "LD_LIBRARY_PATH=/usr/riscv64-linux-gnu/lib qemu-riscv64";

    gnalc_path = "../gnalc";
    global_temp_dir = "./gnalc_test_temp/" + generate_unique_temp_dir();
    global_benchmark_temp_dir = "./gnalc_benchmark_temp/" + generate_unique_temp_dir();

    sylibc = "../../test/sylib/sylib.c";

    test_data = "../../test/contest";

    // Functional first
    subdirs = {"functional",    "h_functional",      "functional_25",       "h_functional_25",    "performance",
               "h_performance", "final/performance", "final/h_performance", "performance_arm_25", "performance_rv_25"};

    benchmark_subdirs = {"performance",         "h_performance",      "final/performance",
                         "final/h_performance", "performance_arm_25", "performance_rv_25"};

    // Updating from env
    auto env_arm_gcc = getenv("GNALC_TEST_GCC_AARCH64");
    auto env_arm_qemu = getenv("GNALC_TEST_QEMU_AARCH64");
    auto env_rv_gcc = getenv("GNALC_TEST_GCC_RISCV64");
    auto env_rv_qemu = getenv("GNALC_TEST_QEMU_RISCV64");
    auto env_gnalc = getenv("GNALC_TEST_GNALC");
    auto env_test_data = getenv("GNALC_TEST_TEST_DATA");
    auto env_sylibc = getenv("GNALC_TEST_SYLIBC");
    auto env_temp_dir = getenv("GNALC_TEST_TEST_TEMP_DIR");
    auto env_benchmark_temp_dir = getenv("GNALC_TEST_BENCHMARK_TEMP_DIR");

    if (env_arm_gcc)
        gcc_arm_command = env_arm_gcc;
    if (env_arm_qemu)
        qemu_arm_command = env_arm_qemu;
    if (env_rv_gcc)
        gcc_rv_command = env_rv_gcc;
    if (env_rv_qemu)
        qemu_rv_command = env_rv_qemu;
    if (env_gnalc)
        gnalc_path = env_gnalc;
    if (env_test_data)
        test_data = env_test_data;
    if (env_sylibc)
        sylibc = env_sylibc;
    if (env_temp_dir)
        global_temp_dir = std::string{env_temp_dir} + "/" + generate_unique_temp_dir();
    if (env_benchmark_temp_dir)
        global_benchmark_temp_dir = std::string{env_benchmark_temp_dir} + "/" + generate_unique_temp_dir();
}
} // namespace Test::cfg