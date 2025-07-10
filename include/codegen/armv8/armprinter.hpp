// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_CODEGEN_ARMV8_ARMPRINTER_HPP
#define GNALC_CODEGEN_ARMV8_ARMPRINTER_HPP

#include "mir/MIR.hpp"
#include "mir/info.hpp"
#include "mir/strings.hpp"
#include <iostream>

namespace MIR {
class ARMA64Printer {
private:
    MIRFunction const *mfunc;
    std::ostream &outStream;
    bool debug;

    std::string reg2s(const MIROperand_p &reg, unsigned int bitWide, bool vector = false) {
        if (debug) {
            return Reg2SDebug(reg, bitWide, mfunc->Context(), vector);
        } else {
            return Reg2S(reg, bitWide, vector);
        }
    }

public:
    ARMA64Printer(std::ostream &outStream_, bool ifDebug = false) : outStream(outStream_), debug(ifDebug) {}

    void printout(const MIRModule &);
    void printout(const std::vector<MIRGlobal_p> &);
    void printout(const MIRFunction &);
    void printout(const MIRBlk &);
    void printout(const MIRInst &);

    [[nodiscard]] string branchPrinter(const MIRInst &);
    [[nodiscard]] string binaryPrinter(const MIRInst &);
    [[nodiscard]] string selectPrinter(const MIRInst &);
    [[nodiscard]] string unaryPrinter(const MIRInst &);
    [[nodiscard]] string cmpPrinter(const MIRInst &);
    [[nodiscard]] string convertPrinter(const MIRInst &);
    [[nodiscard]] string copyPrinter(const MIRInst &);

    [[nodiscard]] string memoryPrinter(const MIRInst &);
    [[nodiscard]] string smullPrinter(const MIRInst &);
    [[nodiscard]] string ternaryPrinter(const MIRInst &);
    [[nodiscard]] string csetPrinter(const MIRInst &);
    [[nodiscard]] string cbnzPrinter(const MIRInst &);
    [[nodiscard]] string AdrpPrinter(const MIRInst &);
    [[nodiscard]] string movPrinter(const MIRInst &);
    [[nodiscard]] string movVPrinter(const MIRInst &);
    [[nodiscard]] string fmovPrinter(const MIRInst &);
    [[nodiscard]] string moviPrinter(const MIRInst &);
    [[nodiscard]] string blPrinter(const MIRInst &);
    [[nodiscard]] string calleePrinter(const MIRInst &);
    [[nodiscard]] string calleePrinter_legacy(const MIRInst &);
    [[nodiscard]] string adjustPrinter(const MIRInst &);

    // vectors
    [[nodiscard]] string binaryPrinter_v(const MIRInst &);
    [[nodiscard]] string selectPrinter_v(const MIRInst &);
    [[nodiscard]] string unaryPrinter_v(const MIRInst &);
    [[nodiscard]] string cmpPrinter_v(const MIRInst &);
    [[nodiscard]] string convertPrinter_v(const MIRInst &);
    [[nodiscard]] string extractPrinter_v(const MIRInst &);
    [[nodiscard]] string insertPrinter_v(const MIRInst &);
    [[nodiscard]] string copyPrinter_v(const MIRInst &);
};
}; // namespace MIR

#endif