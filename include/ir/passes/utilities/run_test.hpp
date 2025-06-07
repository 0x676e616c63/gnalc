// Run Test Pass
// Run test to verify the correctness of passes.
#pragma once
#ifndef GNALC_IR_PASSES_UTILITIES_RUN_TEST_HPP
#define GNALC_IR_PASSES_UTILITIES_RUN_TEST_HPP

#include <utility>

#include "ir/passes/pass_manager.hpp"

namespace IR {
class RunTestPass : public PM::PassInfo<RunTestPass> {
    bool abort_when_test_failed;
    std::string expected_out_path;
    std::string input_path;
    std::string sylib_src_path;

public:
    explicit RunTestPass(std::string expected_out_path_, std::string input_path_ = "",
                         std::string sylib_src_path_ = "", bool abort_when_test_failed_ = false)
        : expected_out_path(std::move(expected_out_path_)), input_path(std::move(input_path_)), sylib_src_path(std::move(sylib_src_path_)),
          abort_when_test_failed(abort_when_test_failed_) {}
    PM::PreservedAnalyses run(Function &function, FAM &manager);
    PM::PreservedAnalyses run(Module &module, MAM &manager);

private:
    void runImpl(const std::string& outfile_id, Module& module);
};

} // namespace IR
#endif
