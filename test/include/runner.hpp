// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_TEST_RUNNER_HPP
#define GNALC_TEST_RUNNER_HPP

#include "utils.hpp"
#include "config.hpp"

#include <algorithm>
#include <filesystem>
#include <functional>
#include <string>

namespace Test {
enum class Target {
    LLVM, ARMv8, RISCV64
};

struct TestResult {
    std::string source_output; // .ll or .s
    std::string output;
    std::string output_file;
    size_t time_elapsed;
};

struct TestData {
    std::filesystem::directory_entry sy;
    std::string sylib;
    std::string temp_dir;
    std::string mode_id;

    // (newsy, output ll)  -> irgen command
    // (newsy, output s)   -> asmgen command
    std::function<std::string(const std::string &, const std::string &)> ir_asm_gen;
};

extern TestResult run_test(const TestData &data, Target target, size_t times = 1, bool only_compile_no_exec = false);
struct CheckIRBinData {
    std::string id;
    std::string ir_or_bin; // .bc or .bin
    std::string temp_dir;
    std::string input;
};

struct CheckResult {
    std::string output;
    std::string output_file;
    size_t time_elapsed;
};

extern CheckResult check_ir_or_bin(const CheckIRBinData &data, Target target);

extern std::string prepare_sylib(const std::string &global_tmp_dir, Target target, const std::string &sylibc = cfg::sylibc);
struct Rule {
    std::string pattern;
    std::vector<std::string> matched_results;
};

// (Pattern, matched results)
using RunSet = std::vector<Rule>;
using SkipSet = std::vector<Rule>;
extern std::vector<std::filesystem::directory_entry> gather_test_files(const std::string &curr_test_dir, RunSet &run,
                                                                       SkipSet &skip);

extern void print_run_skip_status(const RunSet &run, const SkipSet &skip);

} // namespace Test

#endif //RUNNER_HPP
