#include <filesystem>
#include <string>
#include <vector>

#include "config.hpp"
#include "runner.hpp"

using namespace Test;
using namespace std::filesystem;

struct ConfigEntry {
    std::string id;
    std::string ir_or_asm;
    std::string testcase_out;
    std::string testcase_in;
};

std::vector<ConfigEntry> parse_config(const std::string &config_file) {
    return {};
}

int main(int argc, char *argv[]) {
    auto print_help = [&argv] {
        println("Usage: {} [options]", argv[0]);
        println("Options:");
        println("  -b, --backend      Test backend.");
        println("  -c, --config       Config of tests to be run.");
        println("  -p, --para [Param] Run with gnalc parameter.");
    };
    bool only_frontend = true;
    std::string config_file;
    std::string gnalc_params;
    for (int i = 1; i < argc; i++) {
        std::string arg = argv[i];
        if (arg == "--backend" || arg == "-b")
            only_frontend = false;
        else if (arg == "--config" || arg == "-c") {
            if (i + 1 >= argc || argv[i + 1][0] == '-') {
                println("Error: Expected a file.");
                print_help();
                return -1;
            }
            config_file = argv[i + 1];
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

    println("GNALC test started. (GitHub Action)");
    size_t passed = 0;
    size_t curr_test_cnt = 0;

    create_directories(cfg::global_temp_dir);

    auto sylib_to_link = prepare_sylib(cfg::global_temp_dir, only_frontend); // .ll or .a

    std::vector<std::string> failed_tests;
    auto tests = parse_config(config_file);

    for (const auto& curr_test : tests) {
        auto curr_temp_dir = cfg::global_temp_dir + "/" + curr_test.id;
        create_directories(curr_temp_dir);
        print("<{}> Test {}", curr_test_cnt++, curr_test.id);

        CheckIRAsmData data = {
            .id = curr_test.id,
            .input = curr_test.testcase_in,
            .ir_or_asm = curr_test.ir_or_asm,
            .sylib = sylib_to_link,
            .temp_dir = curr_temp_dir,
        };

        auto res = check_ir_asm(data, only_frontend);

        auto expected_syout = read_file(curr_test.testcase_out);
        fix_newline(expected_syout);

        if (res.output != expected_syout) {
            println("|  [\033[0;32;31mFAILED\033[m] Expected '{}' but got "
                    "'{}'.",
                    expected_syout.size() > 1024 ? "<too long to display>" : expected_syout,
                    res.output.size() > 1024 ? "<too long to display>" : res.output);
            println("| expected: {}", curr_test.testcase_out);
            println("| actual:   {}", res.output_file);
            failed_tests.emplace_back(curr_test.id);
            println("----------");
            break;
        }


        println("|  [\033[0;32;32mPASSED\033[m]");
        ++passed;
        println("----------");
    }

    println("Finished running {} tests.", curr_test_cnt);

    if (!failed_tests.empty()) {
        println("Failed tests: ");
        for (const auto &f : failed_tests)
            println("|  {}", f);
        println("[\033[0;32;31mTEST FAILED\033[m] {} tests failed!", failed_tests.size());
        return -1;
    }

    println("[\033[0;32;32mTEST PASSED\033[m] {} tests passed!", passed);
    return 0;
}