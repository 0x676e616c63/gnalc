// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include <ctime>
#include <filesystem>
#include <fstream>
#include <functional>
#include <future>
#include <iomanip>
#include <string>
#include <vector>

#include "config.hpp"
#include "runner.hpp"
#include "utils/misc.hpp"

using namespace Test;
using namespace std::filesystem;

struct Entry {
    std::string id;
    std::string ir_or_bin;
    std::string testcase_out;
    std::string testcase_in;
};

struct Result {
    std::string id;
    std::string file_path;
    size_t time_elapsed;
    std::string expected_output;
    std::string actual_output;
    bool passed;
};

std::string escape_md(const std::string &input) {
    std::string output;
    for (char c : input) {
        if (c == '\\')
            output += "\\\\";
        else if (c == '`')
            output += "\\`";
        else if (c == '*')
            output += "\\*";
        else if (c == '_')
            output += "\\_";
        else if (c == '{' || c == '}')
            output += "\\" + std::string(1, c);
        else if (c == '[' || c == ']')
            output += "\\" + std::string(1, c);
        else if (c == '(' || c == ')')
            output += "\\" + std::string(1, c);
        else if (c == '#')
            output += "\\#";
        else if (c == '+')
            output += "\\+";
        else if (c == '-')
            output += "\\-";
        else if (c == '.')
            output += "\\.";
        else if (c == '!')
            output += "\\!";
        else
            output += c;
    }
    return output;
}

template <typename... Args> void safe_println(Args &&...args) {
    static std::mutex print_mutex;
    std::lock_guard<std::mutex> lock(print_mutex);
    println(std::forward<Args>(args)...);
}

// UTC+8
std::tm get_beijing_time() {
    auto now = std::time(nullptr);
    now += 8 * 3600;
    return *std::gmtime(&now);
}

int main(int argc, char *argv[]) {
    auto print_help = [&argv] {
        println("Usage: {} [options]", argv[0]);
        println("Options:");
        println("  -b, --backend       Test backend.");
        println("  -d, --data          Test data directory.");
        println("  -p, --para [Param]  Run with gnalc parameter.");
        println("  -s, --sha [SHA]     Commit SHA for test metadata.");
        println("  -r, --report [Path] Path to save test report.");
        println("  -h, --help          Print this help message.");
    };

    Target target = Target::LLVM;
    std::string testdata_dir;
    std::string gnalc_params;
    std::string commit_sha;
    std::string report_path = "test_report.md";

    for (int i = 1; i < argc; i++) {
        std::string arg = argv[i];
        if (arg == "--backend" || arg == "-b")
            target = Target::ARMv8;
        else if (arg == "--data" || arg == "-d") {
            if (i + 1 >= argc) {
                println("Error: Expected a directory.");
                print_help();
                return -1;
            }
            testdata_dir = argv[i + 1];
            ++i;
        } else if (arg == "--help" || arg == "-h") {
            print_help();
            return 0;
        } else if (arg == "--para" || arg == "-p") {
            if (i + 1 >= argc) {
                println("Error: Expected a parameter.");
                print_help();
                return -1;
            }
            gnalc_params += " " + std::string(argv[++i]);
        } else if (arg == "--sha" || arg == "-s") {
            if (i + 1 >= argc) {
                println("Error: Expected a commit SHA.");
                print_help();
                return -1;
            }
            commit_sha = argv[++i];
        } else if (arg == "--report" || arg == "-r") {
            if (i + 1 >= argc) {
                println("Error: Expected a report path.");
                print_help();
                return -1;
            }
            report_path = argv[++i];
        } else {
            println("Error: Unrecognized option '{}'", arg);
            print_help();
            return -1;
        }
    }

    println("GNALC test started. (GitHub Action)");

    cfg::init();

    create_directories(cfg::global_temp_dir);

    std::vector<Entry> entries;
    std::string line;
    while (std::getline(std::cin, line)) {
        if (!line.empty()) {
            path path(line);
            if ((path.extension() == ".bin" && target == Target::LLVM) ||
                (path.extension() == ".bc" && target != Target::LLVM))
                continue;

            auto parent_path = path.parent_path();
            bool is_final = parent_path.parent_path().stem() == "final";
            auto base_path = testdata_dir + "/" + (is_final ? "final/" : "") + parent_path.stem().string() + "/" +
                             path.stem().string();
            entries.emplace_back(Entry{
                .id = (is_final ? "final-" : "") + parent_path.stem().string() + "-" + path.stem().string(),
                .ir_or_bin = path,
                .testcase_out = base_path + ".out",
                .testcase_in = base_path + ".in",
            });
        }
    }

    std::vector<Result> results(entries.size());

    for (size_t i = 0; i < entries.size(); ++i) {
        const auto &curr_test = entries[i];
        safe_println("<{}> Test {}", i, curr_test.id);

        try {
            auto curr_temp_dir = cfg::global_temp_dir + "/" + curr_test.id;
            create_directories(curr_temp_dir);

            CheckIRBinData data = {
                .id = curr_test.id,
                .ir_or_bin = curr_test.ir_or_bin,
                .temp_dir = curr_temp_dir,
                .input = curr_test.testcase_in,
            };

            auto res = check_ir_or_bin(data, target);
            auto expected_syout = read_file(curr_test.testcase_out);
            fix_newline(expected_syout);

            results[i] = Result{.id = curr_test.id,
                                .file_path = curr_test.ir_or_bin,
                                .time_elapsed = res.time_elapsed,
                                .expected_output = expected_syout,
                                .actual_output = res.output,
                                .passed = (res.output == expected_syout)};
        } catch (const std::exception &e) {
            results[i] = Result{.id = curr_test.id,
                                .file_path = curr_test.ir_or_bin,
                                .time_elapsed = 0,
                                .expected_output = "",
                                .actual_output = "Exception: " + std::string(e.what()),
                                .passed = false};
        } catch (...) {
            results[i] = Result{.id = curr_test.id,
                                .file_path = curr_test.ir_or_bin,
                                .time_elapsed = 0,
                                .expected_output = "",
                                .actual_output = "Unknown exception",
                                .passed = false};
        }
    }

    std::ofstream report(report_path);
    if (!report) {
        println("Error: Failed to open report file: {}", report_path);
        return -1;
    }

    auto tm = get_beijing_time();
    report << "## Test Results - " << std::put_time(&tm, "%Y-%m-%d %H:%M:%S") << "\n\n";
    auto build_md_url = [](const std::string &sha) {
        return "[" + sha + "](https://github.com/Althra/gnalc/commit/" + sha + ")";
    };
    report << "- **Artifacts Commit:** " << (commit_sha.empty() ? "N/A" : build_md_url(commit_sha)) << "\n";
    report << "- **Total Tests:** " << entries.size() << "\n";
    report << "- **Target:** " << Util::getEnumName(target) << "\n";

    size_t passed = std::count_if(results.begin(), results.end(), [](const auto &tres) { return tres.passed; });

    report << "- **Result:** " << (passed == entries.size() ? "✅ PASSED" : "❌ FAILED") << "\n\n";

    std::vector<std::string> failed_tests;
    for (const auto &tres : results) {
        report << "#### Test: " << tres.id << "\n";
        report << "- **File:** " << tres.file_path << "\n";
        report << "- **Time Elapsed:** " << tres.time_elapsed << "us\n";
        report << "- **Status:** ";

        if (tres.passed) {
            report << "✅ PASSED\n";
        } else {
            failed_tests.push_back(tres.id);
            report << "❌ FAILED\n";
            report << "- **Expected:** "
                   << (tres.expected_output.size() > 512 ? "<output too long>" : escape_md(tres.expected_output))
                   << "\n";
            report << "- **Actual:** "
                   << (tres.actual_output.size() > 512 ? "<output too long>" : escape_md(tres.actual_output)) << "\n";
        }
        report << "\n";
    }

    if (!failed_tests.empty()) {
        report << "\n### Failed Tests\n\n";
        for (const auto &test : failed_tests) {
            report << "- " << test << "\n";
        }
    }

    report << "### Summary\n\n";
    report << "| Status | Count |\n";
    report << "|--------|-------|\n";
    report << "| ✅ Passed | " << passed << " |\n";
    report << "| ❌ Failed | " << failed_tests.size() << " |\n";
    report << "| **Total** | **" << entries.size() << "** |\n";

    report.close();

    if (!failed_tests.empty())
        return -1;

    return 0;
}