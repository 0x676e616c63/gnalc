// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_PASSES_UTILITIES_MIRPRINTER_HPP
#define GNALC_MIR_PASSES_UTILITIES_MIRPRINTER_HPP

#include "../pass_manager.hpp"
#include "../../MIR.hpp"

#include <ostream>

namespace MIR {
class MIRPrinter {
private:
    std::ostream &outStream;

public:
    explicit MIRPrinter(std::ostream &outStream_)
        : outStream(outStream_) {}

protected:
    template <typename T> void write(T &&obj) { outStream << obj; }

    template <typename T> void writeln(T &&obj) { outStream << obj << std::endl; }

    template <typename... Args> void write(Args &&...args) { (outStream << ... << args); }

    template <typename... Args> void writeln(Args &&...args) {
        (outStream << ... << args);
        outStream << std::endl;
    }
};

class PrintFunctionPass : public PM::PassInfo<PrintFunctionPass>, public MIRPrinter {
public:
    explicit PrintFunctionPass(std::ostream &outStream_) : MIRPrinter(outStream_) {}

    PM::PreservedAnalyses run(MIRFunction &unit, FAM &manager);
};
} // namespace IR

#endif
