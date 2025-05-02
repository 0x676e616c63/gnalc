#pragma once
#ifndef GNALC_CODEGEN_ARMV8_ARMPRINTER_HPP
#define GNALC_CODEGEN_ARMV8_ARMPRINTER_HPP

#include "mir/MIR.hpp"
#include "mir/Target.hpp"
#include <iostream>

namespace MIR_new {
class ARMA64Printer {
private:
    MIRFunction const *mfunc;
    std::ostream &outStream;

public:
    explicit ARMA64Printer(std::ostream &outStream_) : outStream(outStream_) {}

    void printout(const MIRModule &);
    void printout(const std::vector<MIRGlobal_p> &);
    void printout(const MIRFunction &);
    void printout(const MIRBlk &);
    void printout(const MIRInst &);

    [[nodiscard]] string branchPrinter(const MIRInst &);
    [[nodiscard]] string binaryPrinter(const MIRInst &);
    [[nodiscard]] string unaryPrinter(const MIRInst &);
    [[nodiscard]] string cmpPrinter(const MIRInst &);
    [[nodiscard]] string convertPrinter(const MIRInst &);
    [[nodiscard]] string copyPrinter(const MIRInst &);

    [[nodiscard]] string memoryPrinter(const MIRInst &);
    [[nodiscard]] string csetPrinter(const MIRInst &);
    [[nodiscard]] string cbnzPrinter(const MIRInst &);
    [[nodiscard]] string ADRP_LDRPrinter(const MIRInst &);
    [[nodiscard]] string movPrinter(const MIRInst &);
    [[nodiscard]] string blPrinter(const MIRInst &);
    [[nodiscard]] string calleePrinter(const MIRInst &);
    [[nodiscard]] string adjustPrinter(const MIRInst &);
};
}; // namespace MIR_new

#endif