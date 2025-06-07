// Export CFG to dot files or png
#pragma once
#ifndef GNALC_IR_PASSES_UTILITIES_CFG_EXPORT_HPP
#define GNALC_IR_PASSES_UTILITIES_CFG_EXPORT_HPP

#include <utility>

#include "ir/passes/pass_manager.hpp"

namespace IR {
class DotCFGPass : public PM::PassInfo<DotCFGPass> {
    std::ostream &out_stream;

public:
    explicit DotCFGPass(std::ostream &outStream_)
    : out_stream(outStream_) {}
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

class PngCFGPass : public PM::PassInfo<PngCFGPass> {
private:
    std::string output_path;

public:
    explicit PngCFGPass(std::string output_path_)
        : output_path(std::move(output_path_)) {}
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};
} // namespace IR
#endif
