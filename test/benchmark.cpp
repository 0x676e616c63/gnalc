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

#include "include/config.hpp"
#include "include/runner.hpp"

#include <numeric>

using namespace Test;
using namespace std::filesystem;

struct BenchmarkData {
    std::string mode1;
    std::string mode2;
    std::vector<std::pair<TestData, TestResult>> results1;
    std::vector<std::pair<TestData, TestResult>> results2;
};

struct RatioData {
    std::string testcase;
    size_t time1;
    size_t time2;
    double ratio;
};

void write_benchmark_result_to(const BenchmarkData& data, std::ostream& out) {
    println(out, "Benchmark results:");
    std::vector<RatioData> times;
    size_t total1 = 0;
    size_t total2 = 0;

    auto ratio = [](auto a, auto b) {
        return static_cast<double>(a) / static_cast<double>(b);
    };

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

        times.emplace_back(RatioData{
            .testcase = test1.sy.path(),
            .time1 = res1.time_elapsed,
            .time2 = res2.time_elapsed,
            .ratio = ratio(res1.time_elapsed, res2.time_elapsed)
        });
        total1 += res1.time_elapsed;
        total2 += res2.time_elapsed;

        println(out, "<{}> {}:", i, test1.sy.path().stem().string());
        println(out, "'{}': {}us", test1.mode_id, res1.time_elapsed);
        println(out, "'{}': {}us", test2.mode_id, res2.time_elapsed);
        println(out, "'{}' is {}x faster than '{}'.",
            test2.mode_id, ratio(res1.time_elapsed, res2.time_elapsed), test1.mode_id);
        println(out, "----------");
    }

    auto [min, max]
    = std::minmax_element(times.begin(), times.end(),
        [](const RatioData& a, const RatioData& b) { return a.ratio < b.ratio; });

    auto average_ratio = ratio(total1, total2);
    println(out,"Total time:");
    println(out,"'{}': {}us", data.mode1, total1);
    println(out,"'{}': {}us", data.mode2, total2);
    println(out, "On average, '{}' is {}x faster than '{}'.",
        data.mode2, average_ratio, data.mode1);

    println(out, "Faster:");
    println(out,"{}: {}x", max->testcase, max->ratio);

    println(out, "Slower:");
    println(out,"{}: {}x", min->testcase, min->ratio);
}

BenchmarkData benchmark_data;

void sighandler(int)
{
    write_benchmark_result_to(benchmark_data, std::cout);
    std::ofstream output_file(cfg::global_benchmark_temp_dir + "/benchmark_result");
    write_benchmark_result_to(benchmark_data, output_file);
    exit(-1);
}

auto a_tmp = benchmark_data.mode1 = "clangO0";
TestData get_mode1_data(const directory_entry& sy, const std::string& sylib_to_link, const std::string& curr_temp_dir) {
    auto clang_irgen = [](const std::string& newsy, const std::string& outll) {
        auto ret = format("sed -i '1i\\int getint(),getch(),getarray(int a[]);float getfloat();int getfarray(float a[]);void putint(int a),putch(int a),putarray(int n,int a[]);void putfloat(float a);void putfarray(int n, float a[]);void putf(char a[], ...);void _sysy_starttime(int);void _sysy_stoptime(int);\\n#define starttime() _sysy_starttime(__LINE__)\\n#define stoptime()  _sysy_stoptime(__LINE__)' {}"
                                " && clang -O0 -xc {} -emit-llvm -S -o {} -I ../../test/sylib/ 2>/dev/null",
                                newsy,
                                newsy, outll);

        // ret += format(
        //     "&& opt {} -S {} -o {} && ",
        //        "-O0", outll, outll);

        return ret;
    };

    return TestData{
        .sy = sy,
        .sylib = sylib_to_link,
        .temp_dir = curr_temp_dir,
        .mode_id = benchmark_data.mode1,
        .irgen = clang_irgen
    };
}

auto b_tmp = benchmark_data.mode2 = "gnalc";
TestData get_mode2_data(const directory_entry& sy, const std::string& sylib_to_link, const std::string& curr_temp_dir) {
    auto gnalc_irgen = [](const std::string& newsy, const std::string& outll) {
        return format("../gnalc -S {} -o {} -emit-llvm",
                                newsy, outll);
    };

    return TestData{
        .sy = sy,
        .sylib = sylib_to_link,
        .temp_dir = curr_temp_dir,
        .mode_id = benchmark_data.mode2,
        .irgen = gnalc_irgen
    };
}

int main() {
    signal(SIGINT, sighandler);

    auto real_test_data = cfg::test_data;
    std::vector<std::pair<std::string, std::vector<std::string>>> skip;
    std::vector<std::pair<std::string, std::vector<std::string>>> run;

    println("Pass benchmark started.");
    println("Mode1: '{}'", benchmark_data.mode1);
    println("Mode2: '{}'", benchmark_data.mode2);

    size_t passed = 0;
    size_t curr_test_cnt = 0;
    // Well, there shouldn't be any "failed" tests for clang, but just in case.
    std::vector<TestData> failed_tests;

    create_directories(cfg::global_benchmark_temp_dir);

    std::string sylib_to_link; // .ll or .a
    if (cfg::only_frontend) {
        sylib_to_link = cfg::global_benchmark_temp_dir + "/sylib.ll";

        // Just a quick and dirty trick to silence llvm-link.
        // llvm-link will emit a warning if we link two modules of different
        // data layouts Given that the LLVM IR we generate contains no target
        // data layout, we use `sed` to delete 'target datalayout' from the
        // sylib.ll
        std::string lib_command =
            format("clang -S -emit-llvm {} -o {} "
                   "&& sed '/^target datalayout/d' {} -i",
                   cfg::sylibc, sylib_to_link, sylib_to_link);

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

            auto clang_irgen = [](const std::string& newsy, const std::string& outll) {
                return format("sed -i '1i\\int getint(),getch(),getarray(int a[]);float getfloat();int getfarray(float a[]);void putint(int a),putch(int a),putarray(int n,int a[]);void putfloat(float a);void putfarray(int n, float a[]);void putf(char a[], ...);void _sysy_starttime(int);void _sysy_stoptime(int);\\n#define starttime() _sysy_starttime(__LINE__)\\n#define stoptime()  _sysy_stoptime(__LINE__)' {}"
                                        " && clang -O0 -xc {} -emit-llvm -S -o {} -I ../../test/sylib/ 2>/dev/null",
                                        newsy,
                                        newsy, outll);
            };

            // Run
            auto data1 = get_mode1_data(sy, sylib_to_link, curr_temp_dir);
            auto data2 = get_mode2_data(sy, sylib_to_link, curr_temp_dir);

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
            println("| testcase: {} | mode: {}",
                f.sy.path().string(), f.mode_id);
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