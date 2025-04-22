#pragma once
#ifndef GNALC_CODEGEN_BRAINFK_BFPRINTER_HPP
#define GNALC_CODEGEN_BRAINFK_BFPRINTER_HPP

#include "config/config.hpp"
#if GNALC_EXTENSION_BRAINFK

#include <iostream>

#include "bfmodule.hpp"

namespace BrainFk {
class BFPrinter {
    std::ostream &outStream;

public:
    explicit BFPrinter(std::ostream &outStream_) : outStream(outStream_) {}

    void printout(const BFModule &module);

    void printout(const BF3tModule &module);

    void printout_multiline(const BF3tModule &module);
};
} // namespace BrainFk
#endif
#endif
