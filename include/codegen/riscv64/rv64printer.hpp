// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_CODEGEN_RISCV64_RV64PRINTER_HPP
#define GNALC_CODEGEN_RISCV64_RV64PRINTER_HPP

#include "mir/MIR.hpp"
#include "mir/info.hpp"
#include "mir/strings.hpp"
#include <iostream>

namespace MIR {
class RV64Printer {
    MIRFunction const *mfunc;
    std::ostream &outStream;
    bool with_runtime;
private:
    template <typename T> void write(T &&obj) { outStream << obj; }

    template <typename T> void writeln(T &&obj) { outStream << obj << std::endl; }

    template <typename... Args> void write(Args &&...args) { (outStream << ... << args); }

    template <typename... Args> void writeln(Args &&...args) {
        (outStream << ... << args);
        outStream << std::endl;
    }
public:
    RV64Printer(std::ostream &outStream_, bool with_runtime_)
        : outStream(outStream_), with_runtime(with_runtime_) {}

    void printout(const MIRModule &);
    void printout(const std::vector<MIRGlobal_p> &);
    void printout(const MIRFunction &);
    void printout(const MIRBlk &);
    void printout(const MIRInst &);
    void printoutRV64(const MIRInst &);

    string formatOperand(const MIROperand_p &op);
    [[nodiscard]] string formatBinary(const MIRInst &);
    [[nodiscard]] string formatUnary(const MIRInst &);
    [[nodiscard]] string formatConverse(const MIRInst &);
    [[nodiscard]] string formatCopy(const MIRInst &);
    [[nodiscard]] string formatBranch(const MIRInst &);
};
}; // namespace MIR

#endif