// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_BRAINFK
#pragma once
#ifndef GNALC_CODEGEN_BRAINFK_BFOPT_HPP
#define GNALC_CODEGEN_BRAINFK_BFOPT_HPP

#include "bfmodule.hpp"

namespace BrainFk {
class BFOpt {
private:
    BFModule module;

public:
    void visit(const BFModule &input_module);
    BFModule &getModule() { return module; }
};
} // namespace BrainFk
#endif
#endif
