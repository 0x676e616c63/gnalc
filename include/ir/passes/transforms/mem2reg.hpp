/**
 * @brief 转换为SSA形式
 */
#pragma once

#ifndef GNALC_IR_PASSES_TRANSFORMS_MEM2REG_HPP
#define GNALC_IR_PASSES_TRANSFORMS_MEM2REG_HPP

#include "../pass_manager.hpp"
#include <queue>
#include <vector>

#include "../../visitor.hpp"
#include "../analysis/domtree_analysis.hpp"

namespace IR {
class PromotePass : public PM::PassInfo<PromotePass> {
    struct BLOCK_INFO {
        std::map<unsigned, std::shared_ptr<LOADInst>> load_map;
        std::map<unsigned, std::shared_ptr<STOREInst>> store_map;
    };
    struct ALLOCA_INFO {
        std::shared_ptr<ALLOCAInst> alloca;
        std::vector<std::shared_ptr<LOADInst>> loads;
        std::vector<std::shared_ptr<STOREInst>> stores;
        std::map<std::shared_ptr<BasicBlock>, BLOCK_INFO> user_blocks; // load, store的父块信息map
    };
    std::queue<ALLOCA_INFO> alloca_infos;
    std::shared_ptr<BasicBlock> entry_block;
    DomTree DT;
    ALLOCA_INFO cur_info;

    // 用于判断INST的支配关系
    bool iADomB(const std::shared_ptr<Instruction>& ia, const std::shared_ptr<Instruction>& ib);

    void analyseAlloca();
    bool removeUnusedAlloca();
    bool rewriteSingleStoreAlloca();
    bool promoteSingleBlockAlloca();
    void computeProcessQueue();
    void processAlloca();

    void promoteMemoryToRegister(Function &function);

public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};
} // namespace IR

#endif