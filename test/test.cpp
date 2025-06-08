#include <filesystem>
#include <string>
#include <vector>

#include "config.hpp"
#include "runner.hpp"

using namespace Test;
using namespace std::filesystem;

int main(int argc, char *argv[]) {
    auto print_help = [&argv] {
        println("Usage: {} [options]", argv[0]);
        println("Options:");
        println("  -a, --all                  Run all tests, regardless of failure.");
        println("  -b, --backend              Test backend.");
        println("  -d, --diff                 Differential Test with clang.");
        println("  -s, --skip   [Name Prefix] Skip test whose name has such prefix.");
        println("  -r, --run    [Name Prefix] Only run test whose name has such prefix.");
        println("  -e, --resume [Name Prefix] Start from test whose name have such prefix.");
        println("  -p, --para [Param]         Run with gnalc parameter.");
        println("  -l, --list                 List all tests.");
        println("  -h, --help                 Print this help and exit.");
        println("  --gh-action                Github Action mode.");
    };
    RunSet skip;
    SkipSet run;
    std::string resume_pattern;
    std::string gnalc_params;
    bool diff_test = false;
    bool stop_on_error = true;
    bool only_frontend = true;
    bool only_list = false;
    bool in_gh_action = false;
    for (int i = 1; i < argc; i++) {
        std::string arg = argv[i];
        if (arg == "--all" || arg == "-a")
            stop_on_error = false;
        else if (arg == "--backend" || arg == "-b")
            only_frontend = false;
        else if (arg == "--diff" || arg == "-d")
            diff_test = true;
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
        } else if (arg == "--para" || arg == "-p") {
            gnalc_params += " " + std::string(argv[++i]);
        } else if (arg == "--gh-action") {
            in_gh_action = true;
        } else {
            println("Error: Unrecognized option '{}'", arg);
            print_help();
            return -1;
        }
    }

    if (!only_list)
        println("GNALC test started.");
    size_t passed = 0;
    size_t curr_test_cnt = 0;
    bool have_resumed = resume_pattern.empty();
    std::vector<std::string> failed_tests;

    create_directories(cfg::global_temp_dir);

    std::string sylib_to_link;
    if (!only_list)
        sylib_to_link = prepare_sylib(cfg::global_temp_dir, only_frontend); // .ll or .a

    // Differential use frontend mode since it only requires llvm toolset.
    std::string sylib_for_diff_testing;
    if (!only_list && diff_test) {
        if (only_frontend)
            sylib_for_diff_testing = sylib_to_link;
        else
            sylib_for_diff_testing = prepare_sylib(cfg::global_temp_dir, true);
    }

    auto real_test_data = in_gh_action ? cfg::github_action_test_data : cfg::test_data;
    for (auto &&curr_test_dir : cfg::subdirs) {
        auto test_files = gather_test_files(real_test_data + "/" + curr_test_dir, run, skip);
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

            if (only_list) {
                println(": {}", sy.path());
                continue;
            }

            // Run
            TestData data{.sy = sy, .sylib = sylib_to_link, .temp_dir = curr_temp_dir, .mode_id = "gnalc_test"};

            if (only_frontend) {
                auto gnalc_irgen = [&gnalc_params](const std::string &newsy, const std::string &outll) {
#ifndef GNALC_TEST_GGC
                    return format("{} -S {} -o {} -emit-llvm{}", cfg::gnalc_path, newsy, outll, gnalc_params);
#else
                    auto outgg = outll + ".gg";
                    return format("{} -S -emit-llvm {} -o {} && ../ggc -S -emit-llvm {} -o {}{}", cfg::gnalc_path,
                                  newsy, outgg, outgg, outll, gnalc_params);
#endif
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

            auto testcase_out = sy.path().parent_path().string() + "/" + sy.path().stem().string() + ".out";
            std::string expected_syout;
            if (diff_test) {
                TestData clang_data{
                    .sy = sy, .sylib = sylib_for_diff_testing, .temp_dir = curr_temp_dir, .mode_id = "clang_diff_test"};
                auto clang_irgen = [](const std::string &newsy, const std::string &outll) {
                    return format("sed -i '1i\\int getint(),getch(),getarray(int a[]);float getfloat();int "
                                  "getfarray(float a[]);void "
                                  "putint(int a),putch(int a),putarray(int n,int a[]);void putfloat(float a);void "
                                  "putfarray(int n, float "
                                  "a[]);void putf(char a[], ...);void _sysy_starttime(int);void "
                                  "_sysy_stoptime(int);\\n#define starttime() "
                                  "_sysy_starttime(__LINE__)\\n#define stoptime()  _sysy_stoptime(__LINE__)' {}"
                                  " && clang -xc {} -emit-llvm -S -o {} -I ../../test/sylib/ 2>/dev/null",
                                  newsy, newsy, outll);
                };
                clang_data.ir_asm_gen = clang_irgen;
                auto diff_res = run_test(clang_data, true);
                expected_syout = diff_res.output;
            } else {
                expected_syout = read_file(testcase_out);
                fix_newline(expected_syout);
            }

            // Check
            auto res = run_test(data, only_frontend);

            if (res.output != expected_syout) {
                println("|  [\033[0;32;31mFAILED\033[m] Expected '{}' but got "
                        "'{}'.",
                        expected_syout.size() > 1024 ? "<too long to display>" : expected_syout,
                        res.output.size() > 1024 ? "<too long to display>" : res.output);
                println("| expected: {}", testcase_out);
                println("| actual:   {}", res.output_file);
                failed_tests.emplace_back(sy.path().string());
                if (stop_on_error) {
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

    if (only_list)
        return 0;

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