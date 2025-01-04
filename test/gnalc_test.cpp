#include <filesystem>
#include <fstream>
#include <iostream>
#include <vector>
#include <algorithm>
#include <string>

#include "gnalc_test.hpp"

using namespace Test;
using namespace std::filesystem;
namespace sycfg
{
constexpr bool stop_on_error = true;
constexpr bool only_frontend = true;

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

const std::string gcc_arm_command = "arm-linux-gnueabi-gcc-14";
const std::string qemu_arm_command = "LD_LIBRARY_PATH=/usr/arm-linux-gnueabi/lib qemu-arm";

const std::string irgen_path = "../irgen";
const std::string asmgen_path = "../asmgen";

const std::string temp_dir = "./gnalc_test_temp/" + generate_unique_temp_dir();
const std::string sylibc = "../test/sylib/sylib.c";
const std::string test_data = "../test/gnalc-test-data/comp-test";
const std::string functional = test_data + "/functional";
const std::string performance = test_data + "/performance";
const std::string h_functional = test_data + "/h_functional";
const std::string h_performance = test_data + "/h_performance";
const std::string final_functional = test_data + "/final/functional";
const std::string final_performance = test_data + "/final/performance";
const std::string final_h_functional = test_data + "/final/h_functional";
const std::string final_h_performance = test_data + "/final/h_performance";
const std::vector dirs = {
    functional, performance,
    h_functional, h_performance,
    final_functional, final_performance,
    final_h_functional, final_h_performance};
}

std::string remove_newline(std::string s) {
    while (!s.empty() && s.back() == '\n')
        s.pop_back();
    return s;
}

std::string read_file(const std::string& file_name) {
    std::ifstream in(file_name);
    std::istreambuf_iterator<char> beg(in), end;
    return {beg, end};
}

int main() {
    println("GNALC test started.");
    size_t passed = 0;
    std::vector<std::string> failed_tests;

    create_directories(sycfg::temp_dir);

    std::string sylib_to_link; // .ll or .a
    if (sycfg::only_frontend)
    {
        sylib_to_link = sycfg::temp_dir + "/sylib.ll";

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
        auto sylibo = sycfg::temp_dir + "/sylib.o";
        sylib_to_link = sycfg::temp_dir + "/sylib.a";

        std::string lib_command = format("gcc -c {} -o {} && ar rcs {} {}",
            sycfg::sylibc, sylibo, sylib_to_link, sylibo);

        println("Running '{}'.", lib_command);
        std::system(lib_command.c_str());
    }

    for (auto&& test_dir : sycfg::dirs)
    {
        std::vector<directory_entry> test_files;
        for (const auto& p : directory_iterator(test_dir))
        {
            if (p.is_regular_file() && p.path().extension() == ".sy")
                test_files.emplace_back(p);
        }
        std::sort(test_files.begin(), test_files.end());
        for (const auto& sy : test_files)
        {
            auto stem = sy.path().parent_path().string() + "/" + sy.path().stem().string();
            auto testcase_in = stem + ".in";
            auto testcase_out = stem + ".out";

            auto output = format("{}/{}.out",
                sycfg::temp_dir, sy.path().stem().string());

            std::string command;

            if (sycfg::only_frontend)
            {
                auto outll = format("{}/{}.ll",
                    sycfg::temp_dir, sy.path().stem().string());
                auto outbc = format("{}/{}.bc",
                    sycfg::temp_dir, sy.path().stem().string());

                command = format(
                    "{} 2>&1 < {} > {}"
                    " && llvm-link 2>&1 {} {} -o {}"
                    " && lli 2>&1 {} < {} > {}"
                    "; echo $? > {}",
                    sycfg::irgen_path, sy.path().string(), outll,
                    sylib_to_link, outll, outbc,
                    outbc, exists(testcase_in) ? testcase_in : "/dev/null", output,
                    output);
            }
            else
            {
                auto outs = format("{}/{}.s",
                    sycfg::temp_dir, sy.path().stem().string());
                auto outexec = format("{}/{}",
                    sycfg::temp_dir, sy.path().stem().string());

                command = format(
                    "{} 2>&1 < {} > {}"
                    " && gcc {} {} -o {}"
                    " && ./{}"
                    "; echo $? > {}",
                    sycfg::asmgen_path, sy.path().string(), outs,
                    outs, sylib_to_link, outexec,
                    outexec,
                    output);
            }

            println("Test {}", sy.path().stem());
            println("|  Running '{}':", command);

            std::system(command.c_str());

            auto syout = remove_newline(read_file(output));
            auto expected_syout = remove_newline(read_file(testcase_out));

            if (syout != expected_syout)
            {
                println("|  [\033[0;32;31mFAILED\033[m] Expected '{}' but got '{}'.",
                    expected_syout, syout);
                failed_tests.emplace_back(sy.path().string());
                if (sycfg::stop_on_error)
                {
                    println("------------------------------------------------------------------------------");
                    goto finish;
                }
            }
            else
            {
                println("|  [\033[0;32;32mPASSED\033[m]");
                ++passed;
            }
            println("------------------------------------------------------------------------------");
        }
    }

    finish:
    println("Finished running {} tests.", failed_tests.size() + passed);
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