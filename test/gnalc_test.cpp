#include <filesystem>
#include <fstream>
#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <map>

#include "gnalc_test.hpp"

using namespace Test;
using namespace std::filesystem;
namespace sycfg
{
// Commandline args
bool stop_on_error = true;
bool only_frontend = true;

// See `docs/gnalc-test.md` to get prepared.

//
//  gnalc -> test -> gnalc-test-data -> comp-test
//  comp-test ->
//              |  functional
//              |  h_functional
//              |  performance
//              |  h_performance
//              |  final ->
//                         |  functional
//                         |  h_functional
//                         |  performance
//                         |  h_performance
//
// Note that all the path is relative to the executing path
// gnalc(project dir) -> cmake-build-debug(CLion's build dir) -> test -> gnalc_test(executable)

const std::string gnalc_path = "../gnalc";

// backend
const std::string gcc_arm_command = "arm-linux-gnueabi-gcc-14";
const std::string qemu_arm_command = "LD_LIBRARY_PATH=/usr/arm-linux-gnueabi/lib qemu-arm";

const std::string global_temp_dir = "./gnalc_test_temp/" + generate_unique_temp_dir();

const std::string sylibc = "../../test/sylib/sylib.c";

const std::string test_data = "../../test/gnalc-test-data/comp-test";
const std::vector subdirs = {
     "functional", "performance",
     "h_functional", "h_performance",
     "final/performance", "final/h_performance"
};
}

int main(int argc, char* argv[]) {
    auto print_help = [&argv]() {
        println("Usage: {} [options]", argv[0]);
        println("Options:");
        println("  -a, --all                : Run all tests, regardless of failure.");
        println("  -b, --backend            : Test backend.");
        println("  -s, --skip [name_prefix] : Skip test whose name has such prefix.");
        println("  -r, --run  [name_prefix] : Only run test whose name has such prefix.");
        println("  -h, --help               : Print this help and exit.");
    };
    std::vector<std::pair<std::string, std::vector<std::string>>> skip;
    std::vector<std::pair<std::string, std::vector<std::string>>> run;
    for (int i = 1; i < argc; i++)
    {
        std::string arg = argv[i];
        if (arg == "--all" || arg == "-a")
            sycfg::stop_on_error = false;
        else if (arg == "--backend" || arg == "-b")
            sycfg::only_frontend = false;
        else if (arg == "--skip" || arg == "-s")
        {
            if (!run.empty())
            {
                println("Error: '--run' conflicts with '--skip'.");
                return -1;
            }
            if (i + 1 >= argc || argv[i + 1][0] == '-')
            {
                println("Error: Expected a name.");
                print_help();
                return -1;
            }
            skip.emplace_back(argv[i + 1], std::vector<std::string>{});
            ++i;
        }
        else if (arg == "--run" || arg == "-r")
        {
            if (!skip.empty())
            {
                println("Error: '--run' conflicts with '--skip'.");
                return -1;
            }
            if (i + 1 >= argc || argv[i + 1][0] == '-')
            {
                println("Error: Expected a name.");
                print_help();
                return -1;
            }
            run.emplace_back(argv[i + 1], std::vector<std::string>{});
            ++i;
        }
        else if (arg == "--help" || arg == "-h")
        {
            print_help();
            return 0;
        }
        else
        {
            println("Error: Unrecognized option '{}'", arg);
            print_help();
            return -1;
        }
    }

    println("GNALC test started.");
    size_t passed = 0;
    size_t curr_test_cnt = 0;
    std::vector<std::string> failed_tests;

    create_directories(sycfg::global_temp_dir);

    std::string sylib_to_link; // .ll or .a
    if (sycfg::only_frontend)
    {
        sylib_to_link = sycfg::global_temp_dir + "/sylib.ll";

        // Just a quick and dirty trick to silence llvm-link.
        // llvm-link will emit a warning if we link two modules of different data layouts
        // Given that the LLVM IR we generate contains no target data layout, we use
        // `sed` to delete 'target datalayout' from the sylib.ll
        std::string lib_command = format("clang -S -emit-llvm {} -o {} "
                                         "&& sed '/^target datalayout/d' {} -i",
                                         sycfg::sylibc, sylib_to_link,
                                         sylib_to_link);

        println("Running '{}'.", lib_command);
        std::system(lib_command.c_str());
    }
    else
    {
        auto sylibo = sycfg::global_temp_dir + "/sylib.o";
        sylib_to_link = sycfg::global_temp_dir + "/sylib.a";

        std::string lib_command = format("{} -c {} -o {} && ar rcs {} {}",
            sycfg::gcc_arm_command, sycfg::sylibc, sylibo, sylib_to_link, sylibo);

        println("Running '{}'.", lib_command);
        std::system(lib_command.c_str());
    }

    for (auto&& curr_test_dir : sycfg::subdirs)
    {
        std::vector<directory_entry> test_files;
        for (const auto& p : directory_iterator(sycfg::test_data + "/" + curr_test_dir))
        {
            if (p.is_regular_file() && p.path().extension() == ".sy")
            {
                bool need_run = true;

                if (skip.empty() && !run.empty())
                {
                    need_run = false;
                    for (auto&& rule : run)
                    {
                        if (begins_with(p.path().stem().string(), rule.first))
                        {
                            need_run = true;
                            rule.second.emplace_back(p.path().string());
                            break;
                        }
                    }
                }
                else if (!skip.empty() && run.empty())
                {
                    need_run = true;
                    for (auto&& rule : skip)
                    {
                        if (begins_with(p.path().stem().string(), rule.first))
                        {
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

        auto curr_temp_dir = sycfg::global_temp_dir + "/" + curr_test_dir;
        create_directories(curr_temp_dir);

        for (const auto& sy : test_files)
        {
            auto stem = sy.path().parent_path().string() + "/" + sy.path().stem().string();
            auto testcase_in = stem + ".in";
            auto testcase_out = stem + ".out";

            auto output = format("{}/{}.out",
                curr_temp_dir, sy.path().stem().string());

            std::string command;

            if (sycfg::only_frontend)
            {
                auto outll = format("{}/{}.ll",
                    curr_temp_dir, sy.path().stem().string());
                auto outbc = format("{}/{}.bc",
                    curr_temp_dir, sy.path().stem().string());

                // /bin/echo is the one in GNU coreutils
                command = format(
                    "{} 2>&1 -S -emit-llvm -o {} {}"
                    " && llvm-link 2>&1 {} {} -o {}"
                    " && lli {} < {} > {}"
                    "; /bin/echo -e \"\\n\"$? >> {}",
                    sycfg::gnalc_path,outll, sy.path().string(),
                    sylib_to_link, outll, outbc,
                    outbc, exists(testcase_in) ? testcase_in : "/dev/null", output,
                    output);

                // Test for this test script.
                // auto newsy = curr_temp_dir + "/" + sy.path().stem().string() + ".new.sy";
                // copy_file(sy, newsy);
                // command = format(
                // "sed -i '1i\\int getint(),getch(),getarray(int a[]);float getfloat();int getfarray(float a[]);void putint(int a),putch(int a),putarray(int n,int a[]);void putfloat(float a);void putfarray(int n, float a[]);void putf(char a[], ...);void _sysy_starttime(int);void _sysy_stoptime(int);\\n#define starttime() _sysy_starttime(__LINE__)\\n#define stoptime()  _sysy_stoptime(__LINE__)' {}"
                //     " && clang -xc {} -emit-llvm -S -o {} -I ../../test/sylib/"
                //     " && llvm-link 2>&1 {} {} -o {}"
                //     " && lli {} < {} > {}"
                //     "; /bin/echo -e \"\\n\"$? >> {}",
                //     newsy,
                //     newsy, outll,
                //     sylib_to_link, outll, outbc,
                //     outbc, exists(testcase_in) ? testcase_in : "/dev/null", output,
                //     output);
            }
            else
            {
                auto outs = format("{}/{}.s",
                    curr_temp_dir, sy.path().stem().string());
                auto outexec = format("{}/{}",
                    curr_temp_dir, sy.path().stem().string());

                command = format(
                    "{} 2>&1 -S -o {} {}"
                    " && {} {} {} -o {}"
                    " && {} {} < {} > {}"
                    "; /bin/echo -e \"\\n\"$? >> {}",
                    sycfg::gnalc_path, outs, sy.path().string(),
                    sycfg::gcc_arm_command, outs, sylib_to_link, outexec,
                    sycfg::qemu_arm_command, outexec, exists(testcase_in) ? testcase_in : "/dev/null", output,
                    output);
            }

            println("<{}> Test {}", curr_test_cnt++, sy.path().stem());

            println("|  Running '{}':", command);

            std::system(command.c_str());

            auto syout = read_file(output);
            auto expected_syout = read_file(testcase_out);

            fix_newline(syout);
            fix_newline(expected_syout);

            if (syout != expected_syout)
            {
                println("|  [\033[0;32;31mFAILED\033[m] Expected '{}' but got '{}'.",
                    expected_syout, syout);
                failed_tests.emplace_back(sy.path().string());
                if (sycfg::stop_on_error)
                {
                    println("----------");
                    goto finish;
                }
            }
            else
            {
                println("|  [\033[0;32;32mPASSED\033[m]");
                ++passed;
            }
            println("----------");
        }
    }

    finish:
    println("Finished running {} tests.", curr_test_cnt);

    if (!skip.empty())
    {
        std::vector<std::string> skipped_tests;
        for (auto&& r : skip)
            skipped_tests.insert(skipped_tests.end(), r.second.cbegin(), r.second.cend());

        if (!skipped_tests.empty())
        {
            println("Skipped {} tests: ", skipped_tests.size());
            for (const auto& f : skipped_tests)
                println("|  {}", f);
        }
    }
    else if (!run.empty())
    {
        std::vector<std::string> run_tests;
        for (auto&& r : run)
            run_tests.insert(run_tests.end(), r.second.cbegin(), r.second.cend());

        if (!run_tests.empty())
        {
            println("Only run {} tests: ", run_tests.size());
            for (const auto& f : run_tests)
                println("|  {}", f);
        }
    }

    if (failed_tests.empty())
    {
        println("[\033[0;32;32mTEST PASSED\033[m] {} tests passed!", passed);
        return 0;
    }
    else
    {
        println("Failed tests: ");
        for (const auto& f : failed_tests)
            println("|  {}", f);
        println("[\033[0;32;31mTEST FAILED\033[m] {} tests failed!", failed_tests.size());
        return -1;
    }
    return 0;
}