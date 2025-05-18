#pragma once
#ifndef GNALC_CODEGEN_ARMV8_ARMPRINTER_HPP
#define GNALC_CODEGEN_ARMV8_ARMPRINTER_HPP

#include "mir/MIR.hpp"
#include "mir/info.hpp"
#include "mir/strings.hpp"
#include <iostream>

namespace MIR_new {
class ARMA64Printer {
private:
    MIRFunction const *mfunc;
    std::ostream &outStream;
    bool debug;

    using RegPrinter = std::string (*)(const MIROperand_p &, unsigned int);

    RegPrinter reg2s;

public:
    ARMA64Printer(std::ostream &outStream_, bool ifDebug = false) : outStream(outStream_), debug(ifDebug) {

        if (ifDebug) {
            reg2s = &Reg2SDebug;
        } else {
            reg2s = &Reg2S;
        }
    }

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
    [[nodiscard]] string calleePrinter_legacy(const MIRInst &);
    [[nodiscard]] string adjustPrinter(const MIRInst &);
};
}; // namespace MIR_new

#endif