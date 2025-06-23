#include <filesystem>
#include <string>
#include <vector>
#include <fstream>
#include <ctime>
#include <iomanip>

#include "config.hpp"
#include "runner.hpp"

using namespace Test;
using namespace std::filesystem;

struct TestEntry {
    std::string id;
    std::string ir_or_asm;
    std::string testcase_out;
    std::string testcase_in;
};

std::string escape_md(const std::string& input) {
    std::string output;
    for (char c : input) {
        if (c == '\\') output += "\\\\";
        else if (c == '`') output += "\\`";
        else if (c == '*') output += "\\*";
        else if (c == '_') output += "\\_";
        else if (c == '{' || c == '}') output += "\\" + std::string(1, c);
        else if (c == '[' || c == ']') output += "\\" + std::string(1, c);
        else if (c == '(' || c == ')') output += "\\" + std::string(1, c);
        else if (c == '#') output += "\\#";
        else if (c == '+') output += "\\+";
        else if (c == '-') output += "\\-";
        else if (c == '.') output += "\\.";
        else if (c == '!') output += "\\!";
        else output += c;
    }
    return output;
}

int main(int argc, char *argv[]) {
    auto print_help = [&argv] {
        println("Usage: {} [options]", argv[0]);
        println("Options:");
        println("  -b, --backend       Test backend.");
        println("  -d, --data          Test data directory.");
        println("  -p, --para [Param]  Run with gnalc parameter.");
        println("  -s, --sha [SHA]     Commit SHA for test metadata.");
        println("  -l, --sylib         Specify sylib.c.");
        println("  -r, --report [Path] Path to save test report.");
        println("  -h, --help          Print this help message.");
    };

    bool only_frontend = true;
    std::string testdata_dir;
    std::string gnalc_params;
    std::string commit_sha;
    std::string sylibc = cfg::sylibc;
    std::string report_path = "test_report.md";

    for (int i = 1; i < argc; i++) {
        std::string arg = argv[i];
        if (arg == "--backend" || arg == "-b")
            only_frontend = false;
        else if (arg == "--data" || arg == "-d") {
            if (i + 1 >= argc || argv[i + 1][0] == '-') {
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
        } else if (arg == "--sylib" || arg == "-l") {
            if (i + 1 >= argc) {
                println("Error: Expected a sylib.c");
                print_help();
                return -1;
            }
            sylibc = argv[++i];
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
    size_t passed = 0;
    size_t curr_test_cnt = 0;

    create_directories(cfg::global_temp_dir);

    auto sylib_to_link = prepare_sylib(cfg::global_temp_dir, only_frontend, sylibc);

    std::vector<std::string> failed_tests;
    std::vector<TestEntry> entries;

    std::string line;
    while (std::getline(std::cin, line)) {
        if (!line.empty()) {
            path path(line);
            if ((path.extension() == ".s" && only_frontend) || (path.extension() == ".ll" && !only_frontend))
                continue;

            entries.emplace_back(TestEntry{
                .id = path.parent_path().stem().string() + "-" + path.stem().string(),
                .ir_or_asm = path,
                .testcase_out = testdata_dir + "/" + path.parent_path().stem().string() + "/" + path.stem().string() + ".out",
                .testcase_in = testdata_dir + "/" + path.parent_path().stem().string() + "/" + path.stem().string() + ".in",
            });
        }
    }

    std::ofstream report(report_path);
    if (!report) {
        println("Error: Failed to open report file: {}", report_path);
        return -1;
    }

    auto now = std::time(nullptr);
    auto tm = *std::localtime(&now);
    report << "## Test Results - " << std::put_time(&tm, "%Y-%m-%d %H:%M:%S") << "\n\n";
    auto build_md_url = [](const std::string& sha) {
        return "[" + sha + "](https://github.com/Althra/gnalc/commit/" + sha + ")";
    };
    report << "- **Artifacts Commit:** " << (commit_sha.empty() ? "N/A" : build_md_url(commit_sha)) << "\n";
    report << "- **Total Tests:** " << entries.size() << "\n";
    report << "- **Mode:** " << (only_frontend ? "Frontend only" : "With backend") << "\n\n";

    for (const auto& curr_test : entries) {
        auto curr_temp_dir = cfg::global_temp_dir + "/" + curr_test.id;
        create_directories(curr_temp_dir);
        print("<{}> Test {}", curr_test_cnt++, curr_test.id);

        CheckIRAsmData data = {
            .id = curr_test.id,
            .ir_or_asm = curr_test.ir_or_asm,
            .sylib = sylib_to_link,
            .temp_dir = curr_temp_dir,
            .input = curr_test.testcase_in,
        };

        auto res = check_ir_asm(data, only_frontend);

        auto expected_syout = read_file(curr_test.testcase_out);
        fix_newline(expected_syout);

        report << "#### Test: " << curr_test.id << "\n";
        report << "- **File:** " << curr_test.ir_or_asm << "\n";
        report << "- **Status:** ";

        if (res.output != expected_syout) {
            report << "❌ FAILED\n";
                report << "- **Expected:** " << (expected_syout.size() > 512 ?
                    "<output too long>" : escape_md(expected_syout)) << "\n";
            report << "- **Actual:** " << (res.output.size() > 512 ?
                    "<output too long>" : escape_md(res.output)) << "\n";
        } else {
            ++passed;
            report << "✅ PASSED\n";
        }
        report << "\n";
    }

    report << "### Summary\n\n";
    report << "| Status | Count |\n";
    report << "|--------|-------|\n";
    report << "| ✅ Passed | " << passed << " |\n";
    report << "| ❌ Failed | " << failed_tests.size() << " |\n";
    report << "| **Total** | **" << entries.size() << "** |\n";

    if (!failed_tests.empty()) {
        report << "\n### Failed Tests\n\n";
        for (const auto& test : failed_tests) {
            report << "- " << test << "\n";
        }
    }

    report.close();
    return 0;
}