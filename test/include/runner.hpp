#ifndef GNALC_TEST_RUNNER_HPP
#define GNALC_TEST_RUNNER_HPP

#include "utils.hpp"

#include <algorithm>
#include <filesystem>
#include <functional>
#include <string>

namespace Test {

struct TestResult {
    std::string source_output; // .ll or .s
    std::string output;
    size_t time_elapsed;
};

struct TestData {
    std::filesystem::directory_entry sy;
    std::string sylib;
    std::string temp_dir;
    std::string mode_id;

    // (newsy, output ll)  -> irgen command
    // (newsy, output s)   -> asmgen command
    std::function<std::string(const std::string &, const std::string &)> ir_asm_gen;
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

inline TestResult run_test(const TestData &data, size_t times = 1, bool only_run_frontend = cfg::only_frontend) {
    Err::gassert(times != 0);
    auto testcase_in = data.sy.path().parent_path().string() + "/" + data.sy.path().stem().string() + ".in";
    auto out_file_id = format("{}_{}", data.sy.path().stem().string(), make_pathname(data.mode_id));
    auto outtime = format("{}/{}.time", data.temp_dir, out_file_id);
    auto output = format("{}/{}.out", data.temp_dir, out_file_id);

    // Copy a sy in case we modified it in ir/asmgen
    auto newsy = data.temp_dir + "/" + out_file_id + ".new.sy";
    std::filesystem::copy_file(data.sy, newsy);

    std::string ir_asm_gen_command, link_command, exec_command;
    std::string out_source;
    if (only_run_frontend) {
        out_source = format("{}/{}.ll", data.temp_dir, out_file_id);
        auto outbc = format("{}/{}.bc", data.temp_dir, out_file_id);

        ir_asm_gen_command = data.ir_asm_gen(newsy, out_source);

        link_command += format("llvm-link 2>&1 {} {} -o {}", data.sylib, out_source, outbc);

        // /bin/echo is the one in GNU coreutils
        // Not the one in sh or bash.
        exec_command = format("lli {} < {} > {} 2>{}", outbc,
                              std::filesystem::exists(testcase_in) ? testcase_in : "/dev/null", output, outtime);
    } else {
        out_source = format("{}/{}.s", data.temp_dir, out_file_id);
        auto outexec = format("{}/{}", data.temp_dir, out_file_id);

        ir_asm_gen_command = data.ir_asm_gen(newsy, out_source);

        link_command =
            format("{} {} {} -fno-PIC -fno-PIE -static -o {}", cfg::gcc_arm_command, out_source, data.sylib, outexec);

        exec_command = format("{} {} < {} > {} 2>{}", cfg::qemu_arm_command, outexec,
                              std::filesystem::exists(testcase_in) ? testcase_in : "/dev/null", output, outtime);
        // link_command = format("{} {} {} -o {}",
        //     "clang", out_source, data.sylib, outexec);
        //
        // exec_command =
        //     format("{} < {} > {} 2>{}",
        //            outexec, std::filesystem::exists(testcase_in) ? testcase_in : "/dev/null", output, outtime);
    }
    exec_command += R"(;/bin/echo -e "\n"$? >> )" + output;

    println("");
    println("|  Running '{}' {} command: '{}'", data.mode_id, cfg::only_frontend ? "irgen" : "asmgen",
            ir_asm_gen_command);
    std::system(ir_asm_gen_command.c_str());
    println("|  Running '{}' link command: '{}'", data.mode_id, link_command);
    std::system(link_command.c_str());
    println("|  Running '{}' execute command: '{}'", data.mode_id, exec_command);

    std::string syout;
    size_t time_elapsed = 0;
    for (int i = 0; i < times; i++) {
        std::system(exec_command.c_str());
        syout = read_file(output);
        fix_newline(syout);
        time_elapsed += parse_time(read_file(outtime));
    }
    time_elapsed /= times;
    return {out_source, syout, time_elapsed};
}

inline std::string prepare_sylib(const std::string &global_tmp_dir, bool only_run_frontend = cfg::only_frontend) {
    std::string sylib_to_link;
    if (only_run_frontend) {
        sylib_to_link = global_tmp_dir + "/sylib.ll";

        // Just a quick and dirty trick to silence llvm-link.
        // llvm-link will emit a warning if we link two modules of different
        // data layouts Given that the LLVM IR we generate contains no target
        // data layout, we use `sed` to delete 'target datalayout' from the
        // sylib.ll
        std::string lib_command = format("clang -S -emit-llvm {} -o {} "
                                         "&& sed '/^target datalayout/d' {} -i",
                                         cfg::sylibc, sylib_to_link, sylib_to_link);

        println("Running '{}'.", lib_command);
        std::system(lib_command.c_str());
    } else {
        auto sylibo = global_tmp_dir + "/sylib.o";
        sylib_to_link = global_tmp_dir + "/sylib.a";

        std::string lib_command = format("clang -c {} --target=arm-linux-gnueabihf -o {} && ar rcs {} {}", cfg::sylibc,
                                         sylibo, sylib_to_link, sylibo);

        println("Running '{}'.", lib_command);
        std::system(lib_command.c_str());
    }
    return sylib_to_link;
}

struct Rule {
    std::string pattern;
    std::vector<std::string> matched_results;
};

// (Pattern, matched results)
using RunSet = std::vector<Rule>;
using SkipSet = std::vector<Rule>;
inline std::vector<std::filesystem::directory_entry> gather_test_files(const std::string &curr_test_dir, RunSet &run,
                                                                       SkipSet &skip) {
    std::vector<std::filesystem::directory_entry> test_files;

    for (const auto &p : std::filesystem::directory_iterator(cfg::test_data + "/" + curr_test_dir)) {
        if (p.is_regular_file() && p.path().extension() == ".sy") {
            bool need_run = true;

            if (skip.empty() && !run.empty()) {
                need_run = false;
                for (auto &&rule : run) {
                    if (begins_with(p.path().stem().string(), rule.pattern)) {
                        need_run = true;
                        rule.matched_results.emplace_back(p.path().string());
                        break;
                    }
                }
            } else if (!skip.empty() && run.empty()) {
                need_run = true;
                for (auto &&rule : skip) {
                    if (begins_with(p.path().stem().string(), rule.pattern)) {
                        need_run = false;
                        rule.matched_results.emplace_back(p.path().string());
                        break;
                    }
                }
            }

            if (need_run)
                test_files.emplace_back(p);
        }
    }

    std::sort(test_files.begin(), test_files.end());
    return test_files;
}

inline void print_run_skip_status(const RunSet &run, const SkipSet &skip) {
    if (!skip.empty()) {
        std::vector<std::string> skipped_tests;
        for (auto &&r : skip)
            skipped_tests.insert(skipped_tests.end(), r.matched_results.cbegin(), r.matched_results.cend());

        if (!skipped_tests.empty()) {
            println("Skipped {} tests: ", skipped_tests.size());
            for (const auto &f : skipped_tests)
                println("|  {}", f);
        }
    } else if (!run.empty()) {
        std::vector<std::string> run_tests;
        for (auto &&r : run)
            run_tests.insert(run_tests.end(), r.matched_results.cbegin(), r.matched_results.cend());

        if (!run_tests.empty()) {
            println("Only run {} tests: ", run_tests.size());
            for (const auto &f : run_tests)
                println("|  {}", f);
        }
    }
}

} // namespace Test

#endif //RUNNER_HPP
