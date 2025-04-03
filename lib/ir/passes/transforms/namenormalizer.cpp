#include "ir/passes/transforms/namenormalizer.hpp"

namespace IR {
PM::PreservedAnalyses NameNormalizePass::run(Function &function, FAM &manager) {
    function.accept(*this);
    curr_idx = 0;
    return PreserveAll();
}

void NameNormalizePass::visit(Function &node) {
    curr_idx = 0;

    for (const auto &param : node.getParams())
        param->setName("%" + std::to_string(curr_idx++));

    for (const auto &block : node.getBlocks())
        block->accept(*this);
}

void NameNormalizePass::visit(BasicBlock &node) {
    if (bb_rename)
        node.setName("%" + std::to_string(curr_idx));
    ++curr_idx;

    for (const auto &phi : node.phis())
        phi->setName("%" + std::to_string(curr_idx++));
    for (const auto &inst : node) {
        if (inst->getVTrait() == ValueTrait::ORDINARY_VARIABLE)
            inst->setName("%" + std::to_string(curr_idx++));
    }
}

} // namespace IR
