// LLVM Pass benchmark
//
// Command: './pass_benchmark -o1 -O0 -o2 -passes=<pipeline>'
//
// For example: './pass_benchmark -o1 -O0 -o2 -passes='loop-unroll-full''
// Note:
// - '-O0' and '-passes=<pipeline>' will be passed to `opt`
// - Use 'opt -print-passes' to see all available passes.
// - See https://llvm.org/docs/NewPassManager.html#invoking-opt for more details
//   on the pass pipeline syntax.

#include <algorithm>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <map>
#include <csignal>
#include <string>
#include <vector>

#include "config.hpp"
#include "gnalc_test.hpp"

using namespace Test;
using namespace std::filesystem;

struct TestResult {
    std::string output;
    size_t time_elapsed;
};

struct TestData {
    directory_entry sy;
    std::string sylib;
    std::string temp_dir;
    std::string cmd_options;
};

std::string make_pathname(const std::string& raw) {
    std::string ret;
    for (const auto& c : raw) {
        if (c == '/' || c == ' ')
            ret += '_';
        else
            ret += c;
    }
    return ret;
}

TestResult run_test(const TestData& data) {
    auto testcase_in = data.sy.path().parent_path().string() + "/" +
            data.sy.path().stem().string() + ".in";

    auto out_file_id = format("{}_{}",
    data.sy.path().stem().string(), data.cmd_options);

    auto output =
        format("{}/{}.out", data.temp_dir, out_file_id);

    std::string compile_command, command;

    auto outtime = format("{}/{}.time", data.temp_dir, out_file_id);
    if (cfg::only_frontend) {
        auto outll = format("{}/{}.ll", data.temp_dir, out_file_id);
        auto opt_outll = format("{}/{}.opt.ll", data.temp_dir, out_file_id);
        auto outbc = format("{}/{}.bc", data.temp_dir, out_file_id);

        // /bin/echo is the one in GNU coreutils
        auto newsy = data.temp_dir + "/" + out_file_id + ".new.sy";
        copy_file(data.sy, newsy);

        compile_command = format(
            "sed -i '1i\\int getint(),getch(),getarray(int a[]);float getfloat();int getfarray(float a[]);void putint(int a),putch(int a),putarray(int n,int a[]);void putfloat(float a);void putfarray(int n, float a[]);void putf(char a[], ...);void _sysy_starttime(int);void _sysy_stoptime(int);\\n#define starttime() _sysy_starttime(__LINE__)\\n#define stoptime()  _sysy_stoptime(__LINE__)' {}"
            " && clang -O0 -xc {} -emit-llvm -S -o {} -I ../../test/sylib/ 2>/dev/null"
            " && opt {} -S   {} -o {}"
            " && llvm-link 2>&1 {} {} -o {}",
            newsy,
            newsy, outll,
            data.cmd_options, outll, opt_outll,
            data.sylib, outll, outbc);

        command = format(
        "lli {} < {} > {} 2>{};"
            "/bin/echo -e \"\\n\"$? >> {}",
            outbc, exists(testcase_in) ? testcase_in : "/dev/null", output, outtime,
            output);
    } else {
        Err::todo("I'll write this when we have a real Raspberry Pi.");
    }

    // println("|  Running '{}':", compile_command);
    std::system(compile_command.c_str());
    // println("|  Running '{}':", command);
    std::system(command.c_str());

    auto syout = read_file(output);
    fix_newline(syout);

    auto time_elased = parse_time(read_file(outtime));

    return {syout, time_elased};
}

struct BenchmarkData {
    std::string option1;
    std::string option2;
    std::vector<std::pair<TestData, TestResult>> results1;
    std::vector<std::pair<TestData, TestResult>> results2;
};

void write_benchmark_result_to(const BenchmarkData& data, std::ostream& out) {
    println(out, "Benchmark results:");
    size_t total1 = 0;
    size_t total2 = 0;
    for (size_t i = 0; i < data.results1.size() && i < data.results2.size(); ++i) {
        const auto &test1 = data.results1[i].first;
        const auto &test2 = data.results2[i].first;
        const auto& res1 = data.results1[i].second;
        const auto& res2 = data.results2[i].second;
        Err::gassert(test1.sy == test2.sy);

        if (res1.time_elapsed == 0 || res2.time_elapsed == 0) {
            println(out, "<{}> {}:", i, test1.sy.path().stem().string());
            println(out, "Skipped failed tests.");
            println(out, "----------");
            continue;
        }

        total1 += res1.time_elapsed;
        total2 += res2.time_elapsed;
        auto ratio = static_cast<double>(res1.time_elapsed)
        / static_cast<double>(res2.time_elapsed);

        println(out, "<{}> {}:", i, test1.sy.path().stem().string());
        println(out, "'{}': {}us", test1.cmd_options, res1.time_elapsed);
        println(out, "'{}': {}us", test2.cmd_options, res2.time_elapsed);
        println(out, "'{}' is {}x faster than '{}'.",
            test2.cmd_options, ratio, test1.cmd_options);
        println(out, "----------");
    }

    auto ratio = static_cast<double>(total1) / static_cast<double>(total2);
    println(out,"Total time:");
    println(out,"'{}': {}us", data.option1, total1);
    println(out,"'{}': {}us", data.option2, total2);
    println(out, "On average, '{}' is {}x faster than '{}'.",
        data.option2, ratio, data.option1);
}

BenchmarkData benchmark_data;

void sighandler(int)
{
    write_benchmark_result_to(benchmark_data, std::cout);
    std::ofstream output_file(cfg::global_benchmark_temp_dir + "/benchmark_result");
    write_benchmark_result_to(benchmark_data, output_file);
    exit(-1);
}

int main(int argc, char *argv[]) {
    signal(SIGINT, sighandler);
    auto print_help = [&argv]() {
        println("Usage: {} [options]", argv[0]);
        println("Options:");
        println("  -o1, --option1 [opt_option]    : Specify option1.");
        println("  -o2, --option2 [opt_option]    : Specify option2.");
        println("  -b, --backend                    : Compile to elf and benchmark.");
        println("  -s, --skip [name_prefix]         : Skip test whose name has such "
                "prefix.");
        println("  -r, --run  [name_prefix]         : Only run test whose name has "
                "such prefix.");
        println("  -h, --help                       : Print this help and exit.");
    };
    auto real_test_data = cfg::test_data;
    std::vector<std::pair<std::string, std::vector<std::string>>> skip;
    std::vector<std::pair<std::string, std::vector<std::string>>> run;
    for (int i = 1; i < argc; i++) {
        std::string arg = argv[i];
        if (arg == "--backend" || arg == "-b")
            cfg::only_frontend = false;
        else if (arg == "--skip" || arg == "-s") {
            if (!run.empty()) {
                println("Error: '--run' conflicts with '--skip'.");
                return -1;
            }
            if (i + 1 >= argc || argv[i + 1][0] == '-') {
                println("Error: '--skip/-s' expects a name.");
                print_help();
                return -1;
            }
            skip.emplace_back(argv[i + 1], std::vector<std::string>{});
            ++i;
        }
        else if (arg == "--run" || arg == "-r") {
            if (!skip.empty()) {
                println("Error: '--run' conflicts with '--skip'.");
                return -1;
            }
            if (i + 1 >= argc) {
                println("Error: '--run/-r' expects a name.");
                print_help();
                return -1;
            }
            run.emplace_back(argv[i + 1], std::vector<std::string>{});
            ++i;
        }
        else if (arg == "--option1" || arg == "-o1") {
            if (i + 1 >= argc) {
                println("Error: '--option1/-o1' expects a name.");
                print_help();
                return -1;
            }
            benchmark_data.option1 = argv[i + 1];
            ++i;
        }
        else if (arg == "--option2" || arg == "-o2") {
            if (i + 1 >= argc) {
                println("Error: '--option2/-o2' expects a name.");
                print_help();
                return -1;
            }
            benchmark_data.option2 = argv[i + 1];
            ++i;
        }
        else if (arg == "--hfelp" || arg == "-h") {
            print_help();
            return 0;
        }
        else {
            println("Error: Unrecognized option '{}'", arg);
            print_help();
            return -1;
        }
    }

    if (benchmark_data.option1.empty() || benchmark_data.option2.empty()) {
        println("Error: Missing options.");
        print_help();
        return -1;
    }

    println("Pass benchmark started.");
    println("Option1: '{}'", benchmark_data.option1);
    println("Option2: '{}'", benchmark_data.option2);

    size_t passed = 0;
    size_t curr_test_cnt = 0;
    // Well, there shouldn't be any "failed" tests for clang, but just in case.
    std::vector<TestData> failed_tests;

    create_directories(cfg::global_benchmark_temp_dir);

    std::string sylib_to_link; // .ll or .a
    if (cfg::only_frontend) {
        sylib_to_link = cfg::global_benchmark_temp_dir + "/sylib.ll";

        std::string lib_command =
            format("clang -S -emit-llvm {} -o {}",
            cfg::sylibc, sylib_to_link);

        println("Running '{}'.", lib_command);
        std::system(lib_command.c_str());
    } else {
        auto sylibo = cfg::global_benchmark_temp_dir + "/sylib.o";
        sylib_to_link = cfg::global_benchmark_temp_dir + "/sylib.a";

        std::string lib_command =
            format("clang -c {} -o {} && ar rcs {} {}",
                   cfg::sylibc, sylibo, sylib_to_link, sylibo);

        println("Running '{}'.", lib_command);
        std::system(lib_command.c_str());
    }

    for (auto &&curr_test_dir : cfg::benchmark_subdirs) {
        std::vector<directory_entry> test_files;
        for (const auto &p :
             directory_iterator(real_test_data + "/" + curr_test_dir)) {
            if (p.is_regular_file() && p.path().extension() == ".sy") {
                bool need_run = true;

                if (skip.empty() && !run.empty()) {
                    need_run = false;
                    for (auto &&rule : run) {
                        if (begins_with(p.path().stem().string(), rule.first)) {
                            need_run = true;
                            rule.second.emplace_back(p.path().string());
                            break;
                        }
                    }
                } else if (!skip.empty() && run.empty()) {
                    need_run = true;
                    for (auto &&rule : skip) {
                        if (begins_with(p.path().stem().string(), rule.first)) {
                            need_run = false;
                            rule.second.emplace_back(p.path().string());
                            break;
                        }
                    }
                }

                if (need_run)
                    test_files.emplace_back(p);
            }
        }

        std::sort(test_files.begin(), test_files.end());

        auto curr_temp_dir = cfg::global_benchmark_temp_dir + "/" + curr_test_dir;
        create_directories(curr_temp_dir);

        for (const auto &sy : test_files) {
            print("<{}> Test {}", curr_test_cnt++, sy.path().stem());

            // Expected
            auto testcase_out = sy.path().parent_path().string() + "/" +
                    sy.path().stem().string() + ".out";
            auto expected_syout = read_file(testcase_out);
            fix_newline(expected_syout);


            // Run
            TestData data1{
                .sy = sy,
                .sylib = sylib_to_link,
                .temp_dir = curr_temp_dir,
                .cmd_options = benchmark_data.option1
            };
            TestData data2{
                .sy = sy,
                .sylib = sylib_to_link,
                .temp_dir = curr_temp_dir,
                .cmd_options = benchmark_data.option2
            };

            auto res1 = run_test(data1);
            auto res2 = run_test(data2);

            benchmark_data.results1.emplace_back(data1, res1);
            benchmark_data.results2.emplace_back(data2, res2);

            bool failed = false;
            if (res1.output != expected_syout) {
                println("\n|  [\033[0;32;31mFAILED\033[m] Expected '{}' but got "
                        "'{}'.",
                        expected_syout, res1.output);
                failed_tests.emplace_back(data1);
                failed = true;
            }
            if (res2.output != expected_syout) {
                println("\n|  [\033[0;32;31mFAILED\033[m] Expected '{}' but got "
                        "'{}'.",
                        expected_syout, res2.output);
                failed_tests.emplace_back(data2);
                failed = true;
            }

            if (!failed) {
                println("     [\033[0;32;32mFINISHED\033[m]");
                ++passed;
            }
            else {
                println("----------");
                goto finish;
            }
        }
    }

    finish:
    println("Finished running {} tests.", curr_test_cnt);

    if (!skip.empty()) {
        std::vector<std::string> skipped_tests;
        for (auto &&r : skip)
            skipped_tests.insert(skipped_tests.end(), r.second.cbegin(),
                                 r.second.cend());

        if (!skipped_tests.empty()) {
            println("Skipped {} tests: ", skipped_tests.size());
            for (const auto &f : skipped_tests)
                println("|  {}", f);
        }
    } else if (!run.empty()) {
        std::vector<std::string> run_tests;
        for (auto &&r : run)
            run_tests.insert(run_tests.end(), r.second.cbegin(),
                             r.second.cend());

        if (!run_tests.empty()) {
            println("Only run {} tests: ", run_tests.size());
            for (const auto &f : run_tests)
                println("|  {}", f);
        }
    }

    if (failed_tests.empty()) {
        println("[\033[0;32;32mTEST PASSED\033[m] {} tests passed!", passed);
    } else {
        println("Failed tests: ");
        for (const auto &f : failed_tests) {
            println("| testcase: {} | options: {}",
                f.sy.path().string(), f.cmd_options);
        }
        println("[\033[0;32;31mTEST FAILED\033[m] {} tests failed!",
                failed_tests.size());
    }

    println("");
    write_benchmark_result_to(benchmark_data, std::cout);
    std::ofstream output_file(cfg::global_benchmark_temp_dir + "/benchmark_result");
    write_benchmark_result_to(benchmark_data, output_file);
    return 0;
}