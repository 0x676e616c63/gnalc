#include "../../include/irvisitors/namenormalizer.hpp"
#include "../../include/parser/visitor.hpp"

namespace IR {
void NameNormalizer::normalize(const Module& module) {
    for (const auto& func : module.getFunctions())
    {
        func->accept(*this);
    }
}
void NameNormalizer::visit(Function& node) {
    curr_idx = 0;
    curr_idx = 0;

    for (const auto& param : node.getParams())
        param->setName("%" + std::to_string(curr_idx++));

    // I don't know why, but it seems clang do this. (Maybe I misunderstood it)
    ++curr_idx;

    for (const auto& block : node.getBlocks())
        block->accept(*this);
}

void NameNormalizer::visit(BasicBlock& node) {
    if (bb_rename)
        node.setName("%" + std::to_string(curr_idx++));

    for (const auto& inst : node.getInsts())
    {
        if (inst->getName() == AST::IRGenerator::irval_temp_name)
            inst->setName("%" + std::to_string(curr_idx++));
    }
}

}