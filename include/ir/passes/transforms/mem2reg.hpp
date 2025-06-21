/**
 * @brief Promote memory operations to registers
 */
#pragma once

#ifndef GNALC_IR_PASSES_TRANSFORMS_MEM2REG_HPP
#define GNALC_IR_PASSES_TRANSFORMS_MEM2REG_HPP

#include "ir/passes/pass_manager.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"

#include <vector>

namespace IR {
class PromotePass : public PM::PassInfo<PromotePass> {
    // Keep this to avoid interruptions
    pVal undef_val = std::make_shared<Value>("__reg_undef", makeBType(IRBTYPE::UNDEFINED), ValueTrait::UNDEFINED);
    struct BLOCK_INFO {
        std::map<unsigned, pLoad> load_map;
        std::map<unsigned, pStore> store_map;
    };
    struct ALLOCA_INFO {
        pAlloca alloca;
        std::vector<pLoad> loads;
        std::vector<pStore> stores;
        std::map<pBlock, BLOCK_INFO> user_blocks; // load, store的父块信息map
    };
    std::list<ALLOCA_INFO> alloca_infos;
    pBlock entry_block;
    DomTree *pDT{};
    ALLOCA_INFO cur_info;
    std::map<std::shared_ptr<PHIInst>, pAlloca> phi_to_alloca_map;
    std::unordered_set<pInst> del_queue;

    // 用于判断INST的支配关系
    bool iADomB(const pInst &ia, const pInst &ib);

    void analyseAlloca();
    bool removeUnusedAlloca();
    bool rewriteSingleStoreAlloca();
    bool promoteSingleBlockAlloca();
    void insertPhi();
    void rename(Function &f);

    // 计算迭代支配前沿
    // https://dl.acm.org/doi/pdf/10.1145/199448.199464
    void computeIDF(const std::unordered_set<pBlock> &def_blk, const std::unordered_set<pBlock> &live_in_blk, std::unordered_set<pBlock> &phi_blk);

    void promoteMemoryToRegister(Function &function);

public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};
} // namespace IR

#endif