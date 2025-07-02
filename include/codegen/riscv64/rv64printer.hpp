#pragma once
#ifndef GNALC_CODEGEN_RISCV64_RV64PRINTER_HPP
#define GNALC_CODEGEN_RISCV64_RV64PRINTER_HPP

#include "mir/MIR.hpp"
#include "mir/info.hpp"
#include "mir/strings.hpp"
#include <iostream>

namespace MIR {
class RV64Printer {
    std::ostream &outStream;
public:
    explicit RV64Printer(std::ostream &outStream_) : outStream(outStream_) {}

    void printout(const MIRModule &);
};
}; // namespace MIR

#endif