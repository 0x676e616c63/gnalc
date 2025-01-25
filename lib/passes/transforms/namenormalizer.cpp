#include "../../../include/passes/transforms/namenormalizer.hpp"
#include "../../../include/parser/visitor.hpp"

namespace IR {
PreservedAnalyses NameNormalizePass::run(Function &function, FunctionAnalysisManager &manager) {
    function.accept(*this);
    return PreservedAnalyses::all();
}

void NameNormalizePass::visit(Function& node) {
    curr_idx = 0;
    curr_idx = 0;

    for (const auto& param : node.getParams())
        param->setName("%" + std::to_string(curr_idx++));

    for (const auto& block : node.getBlocks())
        block->accept(*this);
}

void NameNormalizePass::visit(BasicBlock& node) {
    if (bb_rename)
        node.setName("%" + std::to_string(curr_idx));
    ++curr_idx;
    for (const auto& inst : node.getInsts())
    {
        if (inst->getName() == AST::IRGenerator::irval_temp_name)
            inst->setName("%" + std::to_string(curr_idx++));
    }
}

}