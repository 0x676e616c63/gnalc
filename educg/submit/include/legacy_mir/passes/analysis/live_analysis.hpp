// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_PASSES_ANALYSIS_LIVE_ANALYSIS_HPP
#define GNALC_LEGACY_MIR_PASSES_ANALYSIS_LIVE_ANALYSIS_HPP

#include "../pass_manager.hpp"

namespace LegacyMIR {

///@note Liveness的类定义移到function.hpp中

class LiveAnalysis : public PM::AnalysisInfo<LiveAnalysis> { // 仅在RA时, 供给给单个function使用
private:
    Function *func{};
    Liveness liveinfo;

public:
    LiveAnalysis() = default;
    // explicit LiveAnalysis(Function &_func) noexcept : func(&_func) {}

    void runOnFunc(Function *_func);
    bool runOnBlk(const BlkP &);
    void runOnInst(const InstP &inst, std::unordered_set<OperP> &livein, std::unordered_set<OperP> &liveout);

    std::list<OperP> extractUse(const InstP &inst);
    OperP extractDef(const InstP &inst);
    std::unordered_set<OperP> extractDef_v(const InstP &inst);

    Liveness run(Function &f, FAM &fam);

    ~LiveAnalysis() = default;

public:
    using Result = Liveness;

private:
    friend AnalysisInfo<LiveAnalysis>;
    static PM::UniqueKey Key;
};
} // namespace MIR

#endif
#endif