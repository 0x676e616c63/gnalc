// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Timer
#include <algorithm>
#include <csignal>
#include <filesystem>
#include <string>

#include "include/config.hpp"
#include "include/runner.hpp"

using namespace Test;
using namespace std::filesystem;

int main(int argc, char *argv[]) {
    auto print_help = [&argv]() {
        println("Usage: {} <sylib.c> <in file> <ir file> <times = 1>", argv[0]);
    };
    if (argc != 4 && argc != 5) {
        print_help();
        return 1;
    }

    std::string sylibc = argv[1];
    std::string in_file = argv[2];
    std::string ir_file = argv[3];
    size_t times = argc == 5 ? std::stoi(argv[4]) : 1;

    create_directories("./timer");

    const auto outtime = format("./timer/{}.time", ir_file);
    const auto output = format("./timer/{}.out", ir_file);
    const auto outbc = format("./timer/{}.bc", ir_file);
    const std::string sylib_to_link = "./timer/sylib.ll";

    auto lib_command = format("clang -S -emit-llvm {} -o {} "
                                 "&& sed '/^target datalayout/d' {} -i",
                                 sylibc, sylib_to_link, sylib_to_link);

    auto link_command = format("llvm-link 2>&1 {} {} -o {}", sylib_to_link, ir_file, outbc);

    auto exec_command = format("lli {} < {} > {} 2>{}", outbc, in_file, output, outtime);

    println("|  Running sylib command: '{}'", lib_command);
    std::system(lib_command.c_str());
    println("|  Running link command: '{}'", link_command);
    std::system(link_command.c_str());
    println("|  Running execute command: '{}'", exec_command);

    std::string syout;
    size_t time_elapsed = 0;
    for (int i = 0; i < times; i++) {
        std::system(exec_command.c_str());
        syout = read_file(output);
        fix_newline(syout);
        time_elapsed += parse_time(read_file(outtime));
    }
    time_elapsed /= times;

    // println("|  Output: {}", syout);
    println("|  Average time: {}", time_elapsed);

    return 0;
}