/**
 * @brief 转换为SSA形式
*/
#pragma once

#ifndef GNALC_IR_PASSES_TRANSFORMS_MEM2REG_HPP
#define GNALC_IR_PASSES_TRANSFORMS_MEM2REG_HPP

#include "../pass_manager.hpp"

namespace IR
{
class PromotePass : public PM::PassInfo<PromotePass> {
    // ...
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};
}

#endif