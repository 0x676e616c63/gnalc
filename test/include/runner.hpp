#pragma once
#ifndef GNALC_TEST_RUNNER_HPP
#define GNALC_TEST_RUNNER_HPP

#include "utils.hpp"
#include "config.hpp"

#include <algorithm>
#include <filesystem>
#include <functional>
#include <string>

namespace Test {

struct TestResult {
    std::string source_output; // .ll or .s
    std::string output;
    std::string output_file;
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

static TestResult run_test(const TestData &data, bool only_run_frontend, size_t times = 1) {
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

        exec_command = format("lli {} < {} > {} 2>{}", outbc,
                              std::filesystem::exists(testcase_in) ? testcase_in : "/dev/null", output, outtime);
    } else {
        out_source = format("{}/{}.s", data.temp_dir, out_file_id);
        auto outexec = format("{}/{}", data.temp_dir, out_file_id);

        ir_asm_gen_command = data.ir_asm_gen(newsy, out_source);

        link_command = format("{} {} {} -o {}", cfg::gcc_arm_command, out_source, data.sylib, outexec);

        exec_command = format("{} {} < {} > {} 2>{}", cfg::qemu_arm_command, outexec,
                              std::filesystem::exists(testcase_in) ? testcase_in : "/dev/null", output, outtime);
        // link_command = format("{} {} {} -o {}",
        //     "clang", out_source, data.sylib, outexec);
        //
        // exec_command =
        //     format("{} < {} > {} 2>{}",
        //            outexec, std::filesystem::exists(testcase_in) ? testcase_in : "/dev/null", output, outtime);
    }

    // /bin/echo is the one in GNU coreutils
    // Not the one in sh or bash.
    exec_command += R"(;/bin/echo -e "\n"$? >> )" + output;

    println("");
    println("|  Running '{}' {} command: '{}'", data.mode_id, only_run_frontend ? "irgen" : "asmgen",
            ir_asm_gen_command);

    if (std::system(ir_asm_gen_command.c_str()) != 0)
        return {"", "compiler error", "", 0};

    println("|  Running '{}' link command: '{}'", data.mode_id, link_command);
    if (std::system(link_command.c_str()) != 0)
        return {out_source, "linker error", "", 0};

    println("|  Running '{}' execute command: '{}'", data.mode_id, exec_command);

    std::string syout;
    size_t time_elapsed = 0;
    for (int i = 0; i < times; i++) {
        if (std::system(exec_command.c_str()) != 0)
            return {out_source, "exec error", "", time_elapsed};

        time_elapsed += parse_time(read_file(outtime));

        auto curr_out = read_file(output);
        fix_newline(curr_out);
        if (syout.empty())
            syout = curr_out;
        else if (curr_out != syout)
            return {out_source, "output mismatch", "", time_elapsed / (i + 1)};
    }
    time_elapsed /= times;
    return {out_source, syout, output, time_elapsed};
}

struct CheckIRAsmData {
    std::string id;
    std::string ir_or_asm;
    std::string sylib;
    std::string temp_dir;
    std::string input;
};

struct CheckResult {
    std::string output;
    std::string output_file;
    size_t time_elapsed;
};

static CheckResult check_ir_asm(const CheckIRAsmData &data, bool only_run_frontend) {
    auto outtime = format("{}/{}.time", data.temp_dir, data.id);
    auto output = format("{}/{}.out", data.temp_dir, data.id);

    std::string link_command, exec_command;
    if (only_run_frontend) {
        auto outbc = format("{}/{}.bc", data.temp_dir, data.id);

        link_command += format("llvm-link 2>&1 {} {} -o {}", data.sylib, data.ir_or_asm, outbc);

        exec_command = format("lli {} < {} > {} 2>{}", outbc,
                              std::filesystem::exists(data.input) ? data.input : "/dev/null", output, outtime);
    } else {
        auto outexec = format("{}/{}", data.temp_dir, data.id);

        link_command = format("{} {} {} -o {}", cfg::gcc_arm_command, data.ir_or_asm, data.sylib, outexec);

        exec_command = format("{} {} < {} > {} 2>{}", cfg::qemu_arm_command, outexec,
                              std::filesystem::exists(data.input) ? data.input : "/dev/null", output, outtime);
    }

    // /bin/echo is the one in GNU coreutils
    // Not the one in sh or bash.
    exec_command += R"(;/bin/echo -e "\n"$? >> )" + output;

    println("");
    println("|  Running link command: '{}'", link_command);
    if (std::system(link_command.c_str()) != 0)
        return {"linker error", "", 0};

    println("|  Running execute command: '{}'",  exec_command);

    if (std::system(exec_command.c_str()) != 0)
        return {"exec error", "", 0};

    size_t time_elapsed = parse_time(read_file(outtime));

    auto syout = read_file(output);
    fix_newline(syout);
    return {syout, output, time_elapsed};
}

static std::string prepare_sylib(const std::string &global_tmp_dir, bool only_run_frontend) {
    std::string sylib_to_link;
    if (only_run_frontend) {
        sylib_to_link = global_tmp_dir + "/sylib.ll";

        // Just a quick and dirty trick to silence llvm-link.
        // llvm-link will emit a warning if we link two modules of different
        // data layouts Given that the LLVM IR we generate contains no target
        // data layout, we use `sed` to delete 'target datalayout' from the
        // sylib.ll
        //
        // std::string lib_command = format("clang++ -O3 -S -emit-llvm {} -o {} "
        std::string lib_command = format("clang -S -emit-llvm {} -o {} "
                                         "&& sed '/^target datalayout/d' {} -i",
                                         cfg::sylibc, sylib_to_link, sylib_to_link);

        println("Running '{}'.", lib_command);
        std::system(lib_command.c_str());
    } else {
        auto sylibo = global_tmp_dir + "/sylib.o";
        sylib_to_link = global_tmp_dir + "/sylib.a";

        std::string lib_command =
            format("{} -c {} -o {} && ar rcs {} {}", cfg::gcc_arm_command, cfg::sylibc, sylibo, sylib_to_link, sylibo);

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
static std::vector<std::filesystem::directory_entry> gather_test_files(const std::string &curr_test_dir, RunSet &run,
                                                                       SkipSet &skip) {
    std::vector<std::filesystem::directory_entry> test_files;

    for (const auto &p : std::filesystem::directory_iterator(curr_test_dir)) {
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

static void print_run_skip_status(const RunSet &run, const SkipSet &skip) {
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
