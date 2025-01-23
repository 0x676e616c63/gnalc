#include "../../../include/config/config.hpp"
#if GNALC_EXTENSION_BRAINFK
#include "../../../include/codegen/brainfk/bfmodule.hpp"

namespace BrainFk
{
const std::vector<BFInst>& BFModule::getInstructions() const { return instructions; }

void BFModule::setInst(std::vector<BFInst> inst) { instructions = std::move(inst); }

const std::vector<BF3tInst>& BF3tModule::getInstructions() const { return instructions; }

void BF3tModule::setInst(std::vector<BF3tInst> inst) { instructions = std::move(inst); }
}
#endif