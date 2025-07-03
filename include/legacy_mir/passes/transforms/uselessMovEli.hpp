// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_PASSES_TRANSFORMS_USELESSMOVELI_HPP
#define GNALC_LEGACY_MIR_PASSES_TRANSFORMS_USELESSMOVELI_HPP

#include "legacy_mir/passes/pass_manager.hpp"
#include "registeralloc.hpp"

namespace LegacyMIR {

///@note 主要扫描 COPY/mov/vmov 是否是无用的移动指令

class uselessMovEli : public PM::PassInfo<uselessMovEli> {
public:
    PM::PreservedAnalyses run(Function &func, FAM &fam);

    friend class RAPass;

private:
    Function *function;

    void impl(Function &);

    static bool isUseless(const InstP &);
};

}; // namespace MIR

#endif
#endif