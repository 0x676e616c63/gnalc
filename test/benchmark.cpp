// Pass benchmark Util
#include <algorithm>
#include <csignal>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "benchmark_support.hpp"
#include "config.hpp"
#include "runner.hpp"

using namespace Test;
using namespace std::filesystem;

BenchmarkData benchmark_data;
std::vector<TestData> failed_tests;

void sighandler(int) {
    write_benchmark_result_to(benchmark_data, std::cout, failed_tests);
    auto path = format("{}/{}_vs_{}", cfg::global_benchmark_temp_dir, make_pathname(benchmark_data.mode2),
                       make_pathname(benchmark_data.mode1));
    std::ofstream output_file(path);
    write_benchmark_result_to(benchmark_data, output_file, failed_tests);
    println("Benchmark result saved to {}", path);
    exit(-1);
}

int main(int argc, char *argv[]) {
    signal(SIGINT, sighandler);

    register_all_benchmarks();

    auto print_help = [&argv]() {
        println("Usage: {} [options]", argv[0]);
        println("Options:");
        println("  -1, --mode1   [Mode ID]     Set Mode 1.");
        println("  -2, --mode2   [Mode ID]     Set Mode 2.");
        println("  -t, --times   [Times = 3]   Run every test [Times] times, and get an average.");
        println("  -a, --all                   Run all tests, regardless of failure.");
        println("  -b, --backend               With backend.");
        println("  -s, --skip    [Name Prefix] Skip test whose name has such prefix.");
        println("  -r, --run     [Name Prefix] Only run test whose name has such prefix.");
        println("  -e, --resume  [Name Prefix] Start from test whose name have such prefix.");
        println("  -l, --list                  List all tests.");
        println("  -h, --help                  Print this help and exit.");
        std::string modes_str;
        auto all_modes = BenchmarkRegistry::entries();
        for (const auto &id : all_modes)
            modes_str += id + ", ";
        Err::gassert(!modes_str.empty(), "No mode found.");
        modes_str.pop_back();
        modes_str.pop_back();
        println("Available Modes: {}", modes_str);
    };

    std::string mode1, mode2;
    std::string resume_pattern;
    RunSet run;
    SkipSet skip;
    bool stop_on_error = true;
    bool only_frontend = true;
    bool only_list = false;
    size_t times = 3;
    for (int i = 1; i < argc; i++) {
        std::string arg = argv[i];
        if (arg == "--mode1" || arg == "-1") {
            if (i + 1 >= argc || argv[i + 1][0] == '-') {
                println("Error: Expected a Mode ID.");
                print_help();
                return -1;
            }
            mode1 = argv[i + 1];
            ++i;
        } else if (arg == "--mode2" || arg == "-2") {
            if (i + 1 >= argc || argv[i + 1][0] == '-') {
                println("Error: Expected a Mode ID.");
                print_help();
                return -1;
            }
            mode2 = argv[i + 1];
            ++i;
        } else if (arg == "--times" || arg == "-t") {
            if (i + 1 >= argc || argv[i + 1][0] == '-') {
                println("Error: Expected a number.");
                print_help();
                return -1;
            }
            times = std::stoi(argv[i + 1]);
            Err::gassert(times < 100, "Too many times.");
            ++i;
        } else if (arg == "--all" || arg == "-a")
            stop_on_error = false;
        else if (arg == "--backend" || arg == "-b")
            only_frontend = false;
        else if (arg == "--list" || arg == "-l")
            only_list = true;
        else if (arg == "--skip" || arg == "-s") {
            if (!run.empty()) {
                println("Error: '--run' conflicts with '--skip'.");
                return -1;
            }
            if (i + 1 >= argc || argv[i + 1][0] == '-') {
                println("Error: Expected a name.");
                print_help();
                return -1;
            }
            skip.emplace_back(Rule{argv[i + 1], {}});
            ++i;
        } else if (arg == "--run" || arg == "-r") {
            if (!skip.empty()) {
                println("Error: '--run' conflicts with '--skip'.");
                return -1;
            }
            if (i + 1 >= argc || argv[i + 1][0] == '-') {
                println("Error: Expected a name.");
                print_help();
                return -1;
            }
            run.emplace_back(Rule{argv[i + 1], {}});
            ++i;
        } else if (arg == "--resume" || arg == "-e") {
            if (i + 1 >= argc || argv[i + 1][0] == '-') {
                println("Error: Expected a name.");
                print_help();
                return -1;
            }
            resume_pattern = argv[i + 1];
            ++i;
        } else if (arg == "--help" || arg == "-h") {
            print_help();
            return 0;
        } else {
            println("Error: Unrecognized option '{}'", arg);
            print_help();
            return -1;
        }
    }

    if (!only_list) {
        if (mode1.empty() || mode2.empty()) {
            println("Error: Please specify two modes.");
            print_help();
            return -1;
        }
        if (mode1 == mode2) {
            println("Error: Mode1 and Mode2 cannot be the same.");
            print_help();
            return -1;
        }
        println("Pass benchmark started.");
        println("Mode1: '{}'", mode1);
        println("Mode2: '{}'", mode2);
        benchmark_data.mode1 = mode1;
        benchmark_data.mode2 = mode2;
    }

    size_t passed = 0;
    size_t curr_test_cnt = 0;
    bool have_resumed = resume_pattern.empty();

    create_directories(cfg::global_benchmark_temp_dir);

    std::string sylib_to_link;
    if (!only_list)
        sylib_to_link = prepare_sylib(cfg::global_benchmark_temp_dir, only_frontend); // .ll or .a

    for (auto &&curr_test_dir : cfg::benchmark_subdirs) {
        auto test_files = gather_test_files(curr_test_dir, run, skip);
        if (test_files.empty())
            continue;

        auto curr_temp_dir = cfg::global_benchmark_temp_dir + "/" + curr_test_dir;
        create_directories(curr_temp_dir);

        for (const auto &sy : test_files) {
            if (!have_resumed) {
                if (!begins_with(sy.path().stem(), resume_pattern))
                    continue;
                have_resumed = true;
            }

            print("<{}> Test {}", curr_test_cnt++, sy.path().stem());

            if (only_list) {
                println(": {}", sy.path());
                continue;
            }

            // Expected
            auto testcase_out = sy.path().parent_path().string() + "/" + sy.path().stem().string() + ".out";
            auto expected_syout = read_file(testcase_out);
            fix_newline(expected_syout);

            // Run
            BenchmarkRegistry::TestInfo test_info1{.mode_id = mode1,
                                                   .sy = sy,
                                                   .sylib = sylib_to_link,
                                                   .temp_dir = curr_temp_dir,
                                                   .only_frontend = only_frontend};
            BenchmarkRegistry::TestInfo test_info2{.mode_id = mode2,
                                                   .sy = sy,
                                                   .sylib = sylib_to_link,
                                                   .temp_dir = curr_temp_dir,
                                                   .only_frontend = only_frontend};
            auto data1 = BenchmarkRegistry::get_test_data(test_info1);
            auto data2 = BenchmarkRegistry::get_test_data(test_info2);

            auto res1 = run_test(data1, only_frontend, times);
            auto res2 = run_test(data2, only_frontend, times);

            bool success_1 = res1.output == expected_syout;
            bool success_2 = res2.output == expected_syout;

            if (!success_1) {
                println("\n|  [\033[0;32;31mFAILED\033[m] Expected '{}' but got "
                        "'{}'. | mode: {}",
                        expected_syout.size() > 1024 ? "<too long to display>" : expected_syout,
                        res1.output.size() > 1024 ? "<too long to display>" : res1.output, data1.mode_id);
                println("| expected: {}", testcase_out);
                println("| actual:   {}", res1.output_file);
                failed_tests.emplace_back(data1);
            }
            if (!success_2) {
                println("\n|  [\033[0;32;31mFAILED\033[m] Expected '{}' but got "
                        "'{}'. | mode: {}",
                        expected_syout.size() > 1024 ? "<too long to display>" : expected_syout,
                        res2.output.size() > 1024 ? "<too long to display>" : res2.output, data2.mode_id);
                println("| expected: {}", testcase_out);
                println("| actual:   {}", res2.output_file);
                failed_tests.emplace_back(data2);
            }

            benchmark_data.results1.emplace_back(BenchmarkData::Item{.data = data1, .res = res1, .success = success_1});
            benchmark_data.results2.emplace_back(BenchmarkData::Item{.data = data2, .res = res2, .success = success_2});

            if (success_1 && success_2) {
                println("     [\033[0;32;32mFINISHED\033[m]");
                ++passed;
            } else {
                println("----------");
                if (stop_on_error)
                    goto finish;
            }
        }
    }

    if (only_list)
        return 0;

finish:
    println("Finished running {} tests.", curr_test_cnt);

    print_run_skip_status(run, skip);

    if (failed_tests.empty()) {
        println("[\033[0;32;32mTEST PASSED\033[m] {} tests passed!", passed);
    } else {
        println("Failed tests: ");
        for (const auto &f : failed_tests) {
            println("| testcase: {} | mode: {}", f.sy.path().string(), f.mode_id);
        }
        println("[\033[0;32;31mTEST FAILED\033[m] {} tests failed!", failed_tests.size());
    }

    println("");
    write_benchmark_result_to(benchmark_data, std::cout, failed_tests);
    auto path = format("{}/{}_vs_{}", cfg::global_benchmark_temp_dir, make_pathname(benchmark_data.mode2),
                       make_pathname(benchmark_data.mode1));
    std::ofstream output_file(path);
    write_benchmark_result_to(benchmark_data, output_file, failed_tests);
    println("Benchmark result saved to {}", path);
    return 0;
}