// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_PASSES_TRANSFORMS_PRERALEGALIZE_HPP
#define GNALC_LEGACY_MIR_PASSES_TRANSFORMS_PRERALEGALIZE_HPP

#include "../../SIMDinstruction/memory.hpp"
#include "../../instructions/memory.hpp"
#include "../pass_manager.hpp"

namespace LegacyMIR {

/// @brief 探测ldr, str(0 ~ 4095), vldr, vstr(0 ~ 1020)中超过范围的立即数
class PreRALegalize : public PM::PassInfo<PreRALegalize> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    Function *func; // 不清楚栈上还是堆上
    VarPool *varpool;
    std::set<BaseP> constClearSet; // 常量偏移需清空的寻址操作数

    void runOnBlk(const BlkP &);
    void runOnInst(const BlkP &, const InstP &);

    void addInstBefore(const BlkP &, const std::shared_ptr<ldrInst> &);
    void addInstBefore(const BlkP &, const std::shared_ptr<strInst> &);
    void addInstBefore(const BlkP &, const std::shared_ptr<Vldr> &);
    void addInstBefore(const BlkP &, const std::shared_ptr<Vstr> &);
};

} // namespace MIR
#endif
#endif
