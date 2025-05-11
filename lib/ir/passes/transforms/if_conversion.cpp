#include "ir/passes/transforms/if_conversion.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/control.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"

namespace IR {
PM::PreservedAnalyses IfConversionPass::run(Function &function, FAM &fam) {
    bool if_conv_cfg_modified = false;



    return if_conv_cfg_modified ? PreserveNone() : PreserveAll();
}
} // namespace IR