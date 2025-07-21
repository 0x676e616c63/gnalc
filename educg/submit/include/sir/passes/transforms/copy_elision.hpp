// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Copy Elision
#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_COPY_ELISION_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_COPY_ELISION_HPP

#include "../pass_manager.hpp"

namespace SIR {
class CopyElisionPass : public PM::PassInfo<CopyElisionPass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &lfam);
    size_t name_cnt = 0;
};

} // namespace SIR
#endif
