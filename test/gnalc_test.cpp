#include <filesystem>
#include <fstream>
#include <iostream>
#include <chrono>
#include <vector>
#include <algorithm>
#include <string>
#include <ctime>

std::string generate_unique_temp_dir();
namespace sycfg
{
//
//  test -> data -> comp-test
//  comp-test ->
//              |  functional
//              |  h_functional
//              |  performance
//              |  h_performance
//
const bool stop_on_error = true;
// Note that all the path is relative to the executing path
// gnalc(project dir) -> cmake-build-debug(CLion's build dir) -> test -> gnalc_test(executable)

const std::string temp_dir = "./gnalc_test_temp/" + generate_unique_temp_dir();
const std::string irgen_path = "../irgen";
const std::string sylibc = "../../test/sylib/sylib.c";
const std::string test_data = "../../test/gnalc-test-data/comp-test";
const std::string functional = test_data + "/functional";
const std::string performance = test_data + "/performance";
const std::string h_functional = test_data + "/h_functional";
const std::string h_performance = test_data + "/h_performance";
const std::vector dirs = { functional, performance, h_functional, h_performance };
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
    size_t passed = 0;
    std::vector<std::string> failed_tests;

    std::filesystem::create_directories(sycfg::temp_dir);

    auto temp_sylib = sycfg::temp_dir + "/sylib.ll";
    std::string lib_command = "clang -S -emit-llvm " + sycfg::sylibc + " -o " + temp_sylib;
    std::system(lib_command.c_str());
    for (auto&& test_dir : sycfg::dirs)
    {
        std::vector<std::filesystem::directory_entry> test_files;
        for (const auto& p : std::filesystem::directory_iterator(test_dir))
        {
            if (p.is_regular_file() && p.path().extension() == ".sy")
                test_files.emplace_back(p);
        }
        std::sort(test_files.begin(), test_files.end());
        for (const auto& sy : test_files)
        {
            auto stem = sy.path().parent_path().string() + "/" + sy.path().stem().string();
            auto test_in = stem + ".in";
            auto test_out = stem + ".out";

            auto temp_outll = sycfg::temp_dir + "/" + sy.path().stem().string() + ".ll";
            auto temp_outbc = sycfg::temp_dir + "/" + sy.path().stem().string() + ".bc";
            auto temp_output = sycfg::temp_dir + "/" + sy.path().stem().string() + ".out";

            std::string command = sycfg::irgen_path + " 2>&1 < " + sy.path().string()
            + " > " + temp_outll;

            command += " && llvm-link 2>&1 " + temp_sylib + " " + temp_outll + " -o " + temp_outbc;
            command +=   + " && lli 2>&1 " + temp_outbc;

            if (std::filesystem::exists(test_in))
                command += "<" + test_in + " ";
            command += " > " + temp_output;

            command += "; echo $? > " + temp_output;

            std::cout << "Test " << sy.path().stem()  << std::endl;
            std::cout << "|  Running '" << command << "':" << std::endl;

            std::system(command.c_str());

            auto syout = remove_newline(read_file(temp_output));
            auto expected_syout = remove_newline(read_file(test_out));

            if (syout != expected_syout)
            {
                std::cout << "|  [\033[0;32;31mFAILED\033[m] Expected '" << expected_syout << "' but got '" << syout << "'." << std::endl;
                failed_tests.emplace_back(sy.path().string());
                if (sycfg::stop_on_error)
                {
                    std::cout << "------------------------------------------------------------------------------" << std::endl;
                    goto finish;
                }
            }
            else
            {
                std::cout << "|  [\033[0;32;32mPASSED\033[m]";
                ++passed;
            }
            std::cout << "\n------------------------------------------------------------------------------" << std::endl;
        }
    }

    finish:
    std::cout << "Finished running " << failed_tests.size() + passed << " tests." << std::endl;
    if (failed_tests.empty())
    {
        std::cout << "[\033[0;32;32mTEST PASSED\033[m] " << passed << " tests passed!" << std::endl;
        return 0;
    }
    else
    {
        std::cout << "Failed tests: " << std::endl;
        for (const auto& f : failed_tests)
            std::cout << "|  " << f << std::endl;
        std::cout << "[\033[0;32;31mTEST FAILED\033[m] " << failed_tests.size() << " tests failed!" << std::endl;
        return -1;
    }
    return 0;
}

std::string generate_unique_temp_dir() {
    auto systt = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
    struct tm *ptm = localtime(&systt);
    char date[60] = {0};
    sprintf(date, "%d-%02d-%02d_%02d:%02d:%02d",
           ptm->tm_year + 1900, ptm->tm_mon + 1, ptm->tm_mday,
            ptm->tm_hour, ptm->tm_min, ptm->tm_sec);
    return {date};
}