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

namespace IR
{
class PromotePass : public PM::PassInfo<PromotePass> {
    // ...
    struct BLOCK_INFO {

    };
    struct ALLOCA_INFO{
        std::shared_ptr<ALLOCAInst> alloca;
        std::vector<std::shared_ptr<LOADInst>> loads;
        std::vector<std::shared_ptr<STOREInst>> stores;
    };
    std::queue<ALLOCA_INFO> alloca_infos;
    // std::shared_ptr<Function> cur_func;
    std::shared_ptr<BasicBlock> entry_block;

    void analyseAlloca();
    bool removeUnusedAlloca();
    bool rewriteSingleStoreAlloca();
    bool promoteSingleBlockAlloca();

    void promoteMemoryToRegister(Function &function);
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};
}

#endif