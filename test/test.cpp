#include <algorithm>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <map>
#include <string>
#include <vector>

#include "include/config.hpp"
#include "include/runner.hpp"

using namespace Test;
using namespace std::filesystem;

int main(int argc, char *argv[]) {
    auto print_help = [&argv] {
        println("Usage: {} [options]", argv[0]);
        println("Options:");
        println("  -a, --all                  Run all tests, regardless of failure.");
        println("  -b, --backend              Test backend.");
        println("  -s, --skip   [name_prefix] Skip test whose name has such prefix.");
        println("  -r, --run    [name_prefix] Only run test whose name has such prefix.");
        println("  -e, --resume [name_prefix] Start from test whose name have such prefix.");
        println("  -p, --para [param]         Run with gnalc parameter.");
        println("  -h, --help                 Print this help and exit.");
    };
    RunSet skip;
    SkipSet run;
    std::string resume_pattern;
    std::string gnalc_params;
    for (int i = 1; i < argc; i++) {
        std::string arg = argv[i];
        if (arg == "--all" || arg == "-a")
            cfg::stop_on_error = false;
        else if (arg == "--backend" || arg == "-b")
            cfg::only_frontend = false;
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
        } else if (arg == "--para" || arg == "-p") {
            gnalc_params += " " + std::string(argv[++i]);
        } else {
            println("Error: Unrecognized option '{}'", arg);
            print_help();
            return -1;
        }
    }

    println("GNALC test started.");
    size_t passed = 0;
    size_t curr_test_cnt = 0;
    bool have_resumed = resume_pattern.empty();
    std::vector<std::string> failed_tests;

    create_directories(cfg::global_temp_dir);

    std::string sylib_to_link = prepare_sylib(cfg::global_temp_dir); // .ll or .a

    for (auto &&curr_test_dir : cfg::subdirs) {
        auto test_files = gather_test_files(curr_test_dir, run, skip);
        if (test_files.empty())
            continue;

        auto curr_temp_dir = cfg::global_temp_dir + "/" + curr_test_dir;
        create_directories(curr_temp_dir);

        for (const auto &sy : test_files) {
            if (!have_resumed) {
                if (!begins_with(sy.path().stem(), resume_pattern))
                    continue;
                have_resumed = true;
            }

            print("<{}> Test {}", curr_test_cnt++, sy.path().stem());
            // Expected
            auto testcase_out = sy.path().parent_path().string() + "/" + sy.path().stem().string() + ".out";
            auto expected_syout = read_file(testcase_out);
            fix_newline(expected_syout);

            // Run
            TestData data{.sy = sy, .sylib = sylib_to_link, .temp_dir = curr_temp_dir, .mode_id = "gnalc_test"};

            if (cfg::only_frontend) {
                auto gnalc_irgen = [&gnalc_params](const std::string &newsy, const std::string &outll) {
                    return format("{} -S {} -o {} -emit-llvm{}", cfg::gnalc_path, newsy, outll, gnalc_params);
                };
                data.ir_asm_gen = gnalc_irgen;

            } else {
                auto gnalc_asmgen = [&gnalc_params](const std::string &newsy, const std::string &outs) {
                    return format("{} -S{} -o {} {}", cfg::gnalc_path, gnalc_params, outs, newsy);
                    // Test
                    // return format("arm-linux-gnueabihf-gcc -S -o {} -xc {}", outs, newsy);
                };
                data.ir_asm_gen = gnalc_asmgen;
            }

            // Check
            auto res = run_test(data);

            if (res.output != expected_syout) {
                println("|  [\033[0;32;31mFAILED\033[m] Expected '{}' but got "
                        "'{}'.",
                        expected_syout, res.output);
                failed_tests.emplace_back(sy.path().string());
                if (cfg::stop_on_error) {
                    println("----------");
                    goto finish;
                }
            } else {
                println("|  [\033[0;32;32mPASSED\033[m]");
                ++passed;
            }
            println("----------");
        }
    }

finish:
    println("Finished running {} tests.", curr_test_cnt);

    print_run_skip_status(run, skip);

    if (failed_tests.empty()) {
        println("[\033[0;32;32mTEST PASSED\033[m] {} tests passed!", passed);
        return 0;
    } else {
        println("Failed tests: ");
        for (const auto &f : failed_tests)
            println("|  {}", f);
        println("[\033[0;32;31mTEST FAILED\033[m] {} tests failed!", failed_tests.size());
        return -1;
    }
    return 0;
}