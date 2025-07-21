// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_BRAINFK
#pragma once
#ifndef GNALC_CODEGEN_BRAINFK_BFPRINTER_HPP
#define GNALC_CODEGEN_BRAINFK_BFPRINTER_HPP

#include "bfmodule.hpp"

#include <iostream>

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
