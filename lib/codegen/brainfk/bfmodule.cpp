#include "../../../include/codegen/brainfk/bfmodule.hpp"

namespace BrainFk
{
const std::vector<BFInstruction>& BFModule::getInstructions() const { return instructions; }

void BFModule::addInst(BFInstruction inst) { instructions.emplace_back(inst); }

void BFModule::addInsts(std::vector<BFInstruction> insts) {
    instructions.insert(instructions.end(),
        std::make_move_iterator(insts.begin()),
        std::make_move_iterator(insts.end()));
}
}
