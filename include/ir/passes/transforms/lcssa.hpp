#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LCSSA_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LCSSA_HPP

#include "../pass_manager.hpp"
#include "../analysis/loop_analysis.hpp"
#include "../analysis/domtree_analysis.hpp"

namespace IR {
class LCSSAPass : public PM::PassInfo<LCSSAPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
private:
    size_t name_cnt = 0;
    DomTree domtree;
    std::shared_ptr<Value> getValueForBlock(const Loop& loop,
        const DomTree::Node* node, const std::shared_ptr<Value>& value,
        std::map<const DomTree::Node*, std::shared_ptr<Value>>& added_values);
};
} // namespace IR
#endif
