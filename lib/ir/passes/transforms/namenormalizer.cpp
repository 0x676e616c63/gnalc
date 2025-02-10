#include "../../../../include/ir/passes/transforms/namenormalizer.hpp"

#include "../../../../include/config/config.hpp"

namespace IR {
PM::PreservedAnalyses NameNormalizePass::run(Function &function, FAM &manager) {
    function.accept(*this);
    return PM::PreservedAnalyses::all();
}

void NameNormalizePass::visit(Function &node) {
    curr_idx = 0;
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
    for (const auto &inst : node.getAllInsts()) {
        //if (inst->getName() == Config::IR::REGISTER_TEMP_NAME)
        if (inst->getVTrait() == ValueTrait::ORDINARY_VARIABLE)
            inst->setName("%" + std::to_string(curr_idx++));
    }
}

} // namespace IR
