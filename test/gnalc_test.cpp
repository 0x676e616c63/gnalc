#include <filesystem>
#include <fstream>
#include <iostream>
#include <sstream>
#include <vector>
#include <algorithm>
#include <string>

constexpr auto irgen_path = "../irgen";

namespace sycfg
{
//
//  test -> data -> comp-test
//  comp-test ->
//            |  functional
//            |  h_functional
//            |  performance
//            |  h_performance
//
const bool stop_on_error = true;
const std::string sylibc = "../../test/sylib/sylib.c";
const std::string temp_outll = "gnalc_temp.ll";
const std::string temp_outbc = "gnalc_temp.bc";
const std::string temp_outfile = "gnalc_temp.out";
const std::string test_data = "../../test/data/comp-test";
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
    std::string lib_command = "clang -S -emit-llvm " + sycfg::sylibc + " -o sylib.ll";
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
            auto in = stem + ".in";
            auto out = stem + ".out";

            std::string command = std::string{irgen_path} + " 2>&1 < " + sy.path().string()
            + " > " + sycfg::temp_outll;

            command += " && llvm-link 2>&1 sylib.ll " + sycfg::temp_outll + " -o " + sycfg::temp_outbc;
            command +=   + " && lli 2>&1 " + sycfg::temp_outbc;

            if (std::filesystem::exists(in))
                command += "<" + in + " ";
            command += "> " + sycfg::temp_outfile;

            std::cout << "Test '" << sy.path().stem() << "'" << std::endl;
            std::cout << "|  Running '" << command << "':" << std::endl;

            std::system(command.c_str());

            auto syout = remove_newline(read_file(sycfg::temp_outfile));
            auto expected_syout = remove_newline(read_file(out));

            if (syout != expected_syout)
            {
                std::cout << "|  [\033[0;32;31mError\033[m] Expected '" << expected_syout << "' but got '" << syout << "'." << std::endl;
                if (sycfg::stop_on_error) return -1;
            }
            else
            {
                std::cout << "|  [\033[0;32;32mPASSED\033[m]";
            }

            std::filesystem::remove(sycfg::temp_outfile);
            std::filesystem::remove(sycfg::temp_outll);
            std::cout << "\n------------------------------------------------------------------------------" << std::endl;
        }
    }
    return 0;
}