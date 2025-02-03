#ifndef GNALC_TEST_RUNNER_HPP
#define GNALC_TEST_RUNNER_HPP

#include "utils.hpp"
#include <string>
#include <filesystem>
#include <functional>

namespace Test {

struct TestResult {
    std::string output;
    size_t time_elapsed;
};

struct TestData {
    std::filesystem::directory_entry sy;
    std::string sylib;
    std::string temp_dir;
    std::string mode_id;

    // (newsy, output ll)  -> irgen command
    std::function<std::string(const std::string &, const std::string &)> irgen;
};

inline std::string make_pathname(const std::string &raw) {
    std::string ret;
    for (const auto &c : raw) {
        if (c == '/' || c == ' ')
            ret += '_';
        else
            ret += c;
    }
    return ret;
}

inline TestResult run_test(const TestData& data) {
    auto testcase_in = data.sy.path().parent_path().string() + "/" +
            data.sy.path().stem().string() + ".in";

    auto out_file_id = format("{}_{}",
    data.sy.path().stem().string(), make_pathname(data.mode_id));

    auto output =
        format("{}/{}.out", data.temp_dir, out_file_id);

    std::string irgen_command, link_command, command;

    auto outtime = format("{}/{}.time", data.temp_dir, out_file_id);

    if (cfg::only_frontend) {
        auto outll = format("{}/{}.ll", data.temp_dir, out_file_id);
        auto outbc = format("{}/{}.bc", data.temp_dir, out_file_id);

        // /bin/echo is the one in GNU coreutils
        auto newsy = data.temp_dir + "/" + out_file_id + ".new.sy";
        std::filesystem::copy_file(data.sy, newsy);

        irgen_command = data.irgen(newsy, outll);

        link_command += format(
            "llvm-link 2>&1 {} {} -o {}",
            data.sylib, outll, outbc);

        command = format(
        "lli {} < {} > {} 2>{};"
            "/bin/echo -e \"\\n\"$? >> {}",
            outbc, std::filesystem::exists(testcase_in) ? testcase_in : "/dev/null", output, outtime,
            output);
    } else {
        Err::todo("I'll write this when we have a real Raspberry Pi.");
    }

    println("");
    println("|  Running '{}' irgen command: '{}'", data.mode_id, irgen_command);
    std::system(irgen_command.c_str());
    println("|  Running '{}' link command: '{}'", data.mode_id, link_command);
    std::system(link_command.c_str());
    println("|  Running '{}' execute command: '{}'", data.mode_id, command);
    std::system(command.c_str());

    auto syout = read_file(output);
    fix_newline(syout);

    auto time_elased = parse_time(read_file(outtime));

    return {syout, time_elased};
}

}

#endif //RUNNER_HPP
