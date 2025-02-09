/**
 * @brief 转换为SSA形式
 * @todo PhiOper直接存到operands里面
 * @todo BB中PhiInst单独存
 * @todo index可以在删除大量元素之后做
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
    // Keep this to avoid interruptions
    std::shared_ptr<Value> undef_val = std::make_shared<Value>("__reg_undef", makeBType(IRBTYPE::UNDEFINED), ValueTrait::UNDEFINED);
    struct BLOCK_INFO {
        std::map<unsigned, std::shared_ptr<LOADInst>> load_map;
        std::map<unsigned, std::shared_ptr<STOREInst>> store_map;
    };
    struct ALLOCA_INFO {
        std::shared_ptr<ALLOCAInst> alloca;
        std::vector<std::shared_ptr<LOADInst>> loads;
        std::vector<std::shared_ptr<STOREInst>> stores;
        std::map<std::shared_ptr<BasicBlock>, BLOCK_INFO> user_blocks; // load, store的父块信息map
        // bool processed = false; // 标记后不再rename
    };
    std::list<ALLOCA_INFO> alloca_infos;
    std::shared_ptr<BasicBlock> entry_block;
    DomTree DT;
    ALLOCA_INFO cur_info;
    // std::map<std::pair<unsigned, unsigned>, std::shared_ptr<PHIInst>> new_phi_nodes; // <<AllocaNo, BlockNo>, PhiNode>
    std::map<std::shared_ptr<PHIInst>, std::shared_ptr<ALLOCAInst>> phi_to_alloca_map;
    std::set<std::shared_ptr<Instruction>> del_queue;
    bool name_normalized = false;

    // 用于判断INST的支配关系
    bool iADomB(const std::shared_ptr<Instruction>& ia, const std::shared_ptr<Instruction>& ib);

    void analyseAlloca();
    bool removeUnusedAlloca();
    bool rewriteSingleStoreAlloca();
    bool promoteSingleBlockAlloca();
    void insertPhi();
    void rename(const Function &f);

    // 计算迭代支配前沿
    // https://dl.acm.org/doi/pdf/10.1145/199448.199464
    void computeIDF(const std::set<std::shared_ptr<BasicBlock>> &def_blk,
                    const std::set<std::shared_ptr<BasicBlock>> &live_in_blk,
                    std::set<std::shared_ptr<BasicBlock>> &phi_blk);

    void promoteMemoryToRegister(const Function &function);

public:
    explicit PromotePass(bool _name_normalized) : name_normalized(_name_normalized) {};
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};
} // namespace IR

#endif