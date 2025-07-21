// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_PASSES_TRANSFORMS_PHIELIMINATE_HPP
#define GNALC_LEGACY_MIR_PASSES_TRANSFORMS_PHIELIMINATE_HPP

#include "../../module.hpp"
#include "../pass_manager.hpp"

namespace LegacyMIR {

struct PhiBlkPairs {
    ///@warning 这里的src和dst可能是同一个
    FuncP func;
    BlkP src;
    BlkP dst;
    std::vector<std::pair<OperP, OperP>> pairs; // dst, src
};

struct PhiFunction {
    /// @note 含有phiBlock的function
    std::vector<PhiBlkPairs> PhiList;
};

///@brief 通过将Phi相关的变量拓扑排序
///@brief 获得一个正确的拷贝顺序
///@note llvm的做法, 可能产生一些冗余copy
class PhiEliminatePass : public PM::PassInfo<PhiEliminatePass> {
public:
    PM::PreservedAnalyses run(Module &, MAM &);

private:
    Module *module;
    FuncP cur_func;
    VarPool *cur_varpool;
    std::vector<PhiFunction> processList;
    std::map<BlkP, std::map<BlkP, BlkP>> getMidBlk; // mid = getMidBlk[pred][succ];

    struct tempHash {
        std::size_t operator()(const std::pair<InstP, BlkP> &pair) const;
    };

    std::unordered_set<std::pair<InstP, BlkP>, tempHash> delList;

    std::vector<std::pair<OperP, OperP>> findPair(const BlkP &, const BlkP &);
    void MkWorkList();
    void RunOnFunc(PhiFunction &);
    void RunOnBlkPair(const PhiBlkPairs &); // core

    // push_before_branch
    OperP addCOYPInst(const BlkP &src, std::string dest, const OperP &, const FuncP &);

    void pushBeforeBranch(const BlkP &, std::string, const OperP &dst, OperP src);

    // judge whether pred and succ connected by critical edge
    BlkP splitCriticalEgde(const BlkP &pred, const BlkP &succ, const FuncP &);
};
} // namespace MIR

#endif
#endif