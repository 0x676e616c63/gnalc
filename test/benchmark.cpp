// Pass benchmark Util
#include <algorithm>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <map>
#include <csignal>
#include <string>
#include <vector>
#include <numeric>

#include "include/config.hpp"
#include "include/runner.hpp"

using namespace Test;
using namespace std::filesystem;

struct BenchmarkData {
    std::string mode1;
    std::string mode2;

    struct Item {
        TestData data;
        TestResult res;
        std::string source_output;
        bool success{};
    };
    std::vector<Item> results1;
    std::vector<Item> results2;
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
        const auto& [test1, res1, ll1, success1] = data.results1[i];
        const auto& [test2, res2, ll2, success2] = data.results2[i];

        Err::gassert(test1.sy == test2.sy);

        if (!success1 || !success2) {
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
        // println(out, "'{}' ll output: {}", test1.mode_id, res1.source_output);
        println(out, "'{}': {}us", test1.mode_id, res1.time_elapsed);
        // println(out, "'{}' ll output: {}", test2.mode_id, res2.source_output);
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

    println(out, "Fastest:");
    println(out,"{}: {}x", max->testcase, max->ratio);

    println(out, "Slowest:");
    println(out,"{}: {}x", min->testcase, min->ratio);
}

BenchmarkData benchmark_data;

void sighandler(int)
{
    write_benchmark_result_to(benchmark_data, std::cout);
    auto path =
        format("{}/{}_vs_{}",
            cfg::global_benchmark_temp_dir,
            make_pathname(benchmark_data.mode2),
            make_pathname(benchmark_data.mode1));
    std::ofstream output_file(path);
    write_benchmark_result_to(benchmark_data, output_file);
    println("Benchmark result saved to {}", path);
    exit(-1);
}

auto a_tmp = benchmark_data.mode1 = "clang-o2";
TestData get_mode1_data(const directory_entry& sy, const std::string& sylib_to_link, const std::string& curr_temp_dir) {
    auto clang_irgen = [](const std::string& newsy, const std::string& outll) {
        auto ret = format("sed -i '1i\\int getint(),getch(),getarray(int a[]);float getfloat();int getfarray(float a[]);void putint(int a),putch(int a),putarray(int n,int a[]);void putfloat(float a);void putfarray(int n, float a[]);void putf(char a[], ...);void _sysy_starttime(int);void _sysy_stoptime(int);\\n#define starttime() _sysy_starttime(__LINE__)\\n#define stoptime()  _sysy_stoptime(__LINE__)' {}"
                                " && clang -O2 -Xclang -disable-O0-optnone -xc {} -emit-llvm -S -o {} -I ../../test/sylib/ 2>/dev/null",
                                newsy,
                                newsy, outll);

        return ret;
    };

    return TestData{
        .sy = sy,
        .sylib = sylib_to_link,
        .temp_dir = curr_temp_dir,
        .mode_id = benchmark_data.mode1,
        .ir_asm_gen = clang_irgen
    };
}

// auto a_tmp = benchmark_data.mode1 = "clang-o2-llvm";
// TestData get_mode1_data(const directory_entry& sy, const std::string& sylib_to_link, const std::string& curr_temp_dir) {
//     auto clang_asmgen = [](const std::string& newsy, const std::string& outs) {
//         auto ret = format("sed -i '1i\\int getint(),getch(),getarray(int a[]);float getfloat();int getfarray(float a[]);void putint(int a),putch(int a),putarray(int n,int a[]);void putfloat(float a);void putfarray(int n, float a[]);void putf(char a[], ...);void _sysy_starttime(int);void _sysy_stoptime(int);\\n#define starttime() _sysy_starttime(__LINE__)\\n#define stoptime()  _sysy_stoptime(__LINE__)' {}"
//                                 " && clang -O2 -Xclang -disable-O0-optnone -xc {} -S -o {} -I ../../test/sylib/ 2>/dev/null",
//                                 newsy,
//                                 newsy, outs);
//
//         return ret;
//     };
//
//     return TestData{
//         .sy = sy,
//         .sylib = sylib_to_link,
//         .temp_dir = curr_temp_dir,
//         .mode_id = benchmark_data.mode1,
//         .ir_asm_gen = clang_asmgen
//     };
// }

// auto a_tmp = benchmark_data.mode1 = "clang-mem2reg-sccp";
// TestData get_mode1_data(const directory_entry& sy, const std::string& sylib_to_link, const std::string& curr_temp_dir) {
//     auto clang_irgen = [](const std::string& newsy, const std::string& outll) {
//         auto out_o0_ll = outll + ".o0.ll";
//         auto ret = format("sed -i '1i\\int getint(),getch(),getarray(int a[]);float getfloat();int getfarray(float a[]);void putint(int a),putch(int a),putarray(int n,int a[]);void putfloat(float a);void putfarray(int n, float a[]);void putf(char a[], ...);void _sysy_starttime(int);void _sysy_stoptime(int);\\n#define starttime() _sysy_starttime(__LINE__)\\n#define stoptime()  _sysy_stoptime(__LINE__)' {}"
//                                 " && clang -O0 -Xclang -disable-O0-optnone -xc {} -emit-llvm -S -o {} -I ../../test/sylib/ 2>/dev/null",
//                                 newsy,
//                                 newsy, out_o0_ll);
//
//         ret += format("&& opt {} -S {} -o {} -debug-pass-manager",
//                "-passes=mem2reg,sccp", out_o0_ll, outll);
//
//         return ret;
//     };
//     return TestData{
//         .sy = sy,
//         .sylib = sylib_to_link,
//         .temp_dir = curr_temp_dir,
//         .mode_id = benchmark_data.mode1,
//         .ir_asm_gen = clang_irgen
//     };
// }

// auto a_tmp = benchmark_data.mode1 = "gnalc-oldsccp";
// TestData get_mode1_data(const directory_entry& sy, const std::string& sylib_to_link, const std::string& curr_temp_dir) {
//     auto gnalc_irgen = [](const std::string& newsy, const std::string& outll) {
//         return format("../gnalc-old -S {} -o {} -emit-llvm --mem2reg --sccp",
//                                 newsy, outll);
//     };
//
//     return TestData{
//         .sy = sy,
//         .sylib = sylib_to_link,
//         .temp_dir = curr_temp_dir,
//         .mode_id = benchmark_data.mode1,
//         .ir_asm_gen = gnalc_irgen
//     };
// }


auto b_tmp = benchmark_data.mode2 = "gnalc-O1";
TestData get_mode2_data(const directory_entry& sy, const std::string& sylib_to_link, const std::string& curr_temp_dir) {
    auto gnalc_irgen = [](const std::string& newsy, const std::string& outll) {
        return format("../gnalc -S {} -o {} -emit-llvm -O1",
                                newsy, outll);
    };

    return TestData{
        .sy = sy,
        .sylib = sylib_to_link,
        .temp_dir = curr_temp_dir,
        .mode_id = benchmark_data.mode2,
        .ir_asm_gen = gnalc_irgen
    };
}

// auto b_tmp = benchmark_data.mode2 = "gnalc-O1-llvm";
// TestData get_mode2_data(const directory_entry& sy, const std::string& sylib_to_link, const std::string& curr_temp_dir) {
//     auto gnalc_asmgen = [](const std::string& newsy, const std::string& outs) {
//         return format("../gnalc -S {} -o {} -emit-llvm -O1 && llc {} -o {} --relocation-model=pic",
//                                 newsy, outs + ".ll", outs + ".ll", outs);
//     };
//
//     return TestData{
//         .sy = sy,
//         .sylib = sylib_to_link,
//         .temp_dir = curr_temp_dir,
//         .mode_id = benchmark_data.mode2,
//         .ir_asm_gen = gnalc_asmgen
//     };
// }

// auto b_tmp = benchmark_data.mode2 = "clang-dce";
// TestData get_mode2_data(const directory_entry& sy, const std::string& sylib_to_link, const std::string& curr_temp_dir) {
//     auto clang_irgen = [](const std::string& newsy, const std::string& outll) {
//         auto out_o0_ll = outll + ".o0.ll";
//         auto ret = format("sed -i '1i\\int getint(),getch(),getarray(int a[]);float getfloat();int getfarray(float a[]);void putint(int a),putch(int a),putarray(int n,int a[]);void putfloat(float a);void putfarray(int n, float a[]);void putf(char a[], ...);void _sysy_starttime(int);void _sysy_stoptime(int);\\n#define starttime() _sysy_starttime(__LINE__)\\n#define stoptime()  _sysy_stoptime(__LINE__)' {}"
//                                 " && clang -O0 -Xclang -disable-O0-optnone -xc {} -emit-llvm -S -o {} -I ../../test/sylib/ 2>/dev/null",
//                                 newsy,
//                                 newsy, out_o0_ll);
//
//         ret += format("&& opt {} -S {} -o {}",
//                "-passes=mem2reg,dce", out_o0_ll, outll);
//
//         return ret;
//     };
//     return TestData{
//         .sy = sy,
//         .sylib = sylib_to_link,
//         .temp_dir = curr_temp_dir,
//         .mode_id = benchmark_data.mode2,
//         .ir_asm_gen = clang_irgen
//     };
// }

int main(int argc, char *argv[]) {
    signal(SIGINT, sighandler);

    auto print_help = [&argv]() {
        println("Usage: {} [options]", argv[0]);
        println("Options:");
        println("  -s, --skip   [name_prefix] Skip test whose name has such prefix.");
        println("  -r, --run    [name_prefix] Only run test whose name has such prefix.");
        println("  -e, --resume [name_prefix] Start from test whose name have such prefix.");
        println("  -h, --help                 Print this help and exit.");
    };

    std::string resume_pattern;
    RunSet run;
    SkipSet skip;

    for (int i = 1; i < argc; i++) {
        std::string arg = argv[i];
        if (arg == "--skip" || arg == "-s") {
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

    println("Pass benchmark started.");
    println("Mode1: '{}'", benchmark_data.mode1);
    println("Mode2: '{}'", benchmark_data.mode2);

    size_t passed = 0;
    size_t curr_test_cnt = 0;
    bool have_resumed = resume_pattern.empty();
    // Well, there shouldn't be any "failed" tests for clang, but just in case.
    std::vector<TestData> failed_tests;

    create_directories(cfg::global_benchmark_temp_dir);

    std::string sylib_to_link = prepare_sylib(cfg::global_benchmark_temp_dir); // .ll or .a

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

            // Expected
            auto testcase_out = sy.path().parent_path().string() + "/" +
                    sy.path().stem().string() + ".out";
            auto expected_syout = read_file(testcase_out);
            fix_newline(expected_syout);

            // Run
            auto data1 = get_mode1_data(sy, sylib_to_link, curr_temp_dir);
            auto data2 = get_mode2_data(sy, sylib_to_link, curr_temp_dir);

            auto res1 = run_test(data1);
            auto res2 = run_test(data2);

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

            benchmark_data.results1.emplace_back(BenchmarkData::Item
            {
                .data = data1,
                .res = res1,
                .success = res1.output == expected_syout
            });
            benchmark_data.results2.emplace_back(BenchmarkData::Item
            {
                .data = data2,
                .res = res2,
                .success = res2.output == expected_syout
            });

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

    print_run_skip_status(run, skip);

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
    auto path =
        format("{}/{}_vs_{}",
            cfg::global_benchmark_temp_dir,
            make_pathname(benchmark_data.mode2),
            make_pathname(benchmark_data.mode1));
    std::ofstream output_file(path);
    write_benchmark_result_to(benchmark_data, output_file);
    println("Benchmark result saved to {}", path);
    return 0;
}