/**
 * @brief 转换为SSA形式
*/
#pragma once

#ifndef GNALC_PASSES_TRANSFORMS_MEM2REG_HPP
#define GNALC_PASSES_TRANSFORMS_MEM2REG_HPP

#include "../pass_manager.hpp"

namespace IR
{
class PromotePass : public PassInfo<PromotePass> {
    // ...
public:
    PreservedAnalyses run(Function &function, FunctionAnalysisManager &manager);
};
}

#endif