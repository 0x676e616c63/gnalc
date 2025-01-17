#include "../../../include/codegen/brainfk/bfmodule.hpp"

namespace BrainFk
{
const std::vector<BFInstruction>& BFModule::getInstructions() const { return instructions; }

void BFModule::setInst(std::vector<BFInstruction> inst) { instructions = std::move(inst); }
}
