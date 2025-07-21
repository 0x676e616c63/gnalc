// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Export CFG to dot files or png
#pragma once
#ifndef GNALC_IR_PASSES_UTILITIES_CFG_EXPORT_HPP
#define GNALC_IR_PASSES_UTILITIES_CFG_EXPORT_HPP

#include <utility>

#include "../pass_manager.hpp"

namespace IR {
class DotCFGPass : public PM::PassInfo<DotCFGPass> {
    std::ostream &out_stream;

public:
    explicit DotCFGPass(std::ostream &outStream_)
    : out_stream(outStream_) {}
    PM::PreservedAnalyses run(Function &function, FAM &manager);
    PM::PreservedAnalyses run(Module &module, MAM &manager);
};

class PngCFGPass : public PM::PassInfo<PngCFGPass> {
private:
    std::string output_dir;

public:
    explicit PngCFGPass(std::string output_dir_)
        : output_dir(std::move(output_dir_)) {}
    PM::PreservedAnalyses run(Function &function, FAM &manager);
    PM::PreservedAnalyses run(Module &module, MAM &manager);
};
} // namespace IR
#endif
