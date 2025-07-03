// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_PASSES_TRANSFORMS_USELESSBLKELI_HPP
#define GNALC_LEGACY_MIR_PASSES_TRANSFORMS_USELESSBLKELI_HPP

#include "legacy_mir/passes/pass_manager.hpp"

namespace LegacyMIR {
class uselessBlkEli : public PM::PassInfo<uselessBlkEli> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    Function *func;

    void impl(); // 删除块的过程应该不会产生新的无用块
    bool isUseless(const BlkP &);
    void blkConsolidate(const BlkP &); // 合并
};
}; // namespace MIR

#endif
#endif