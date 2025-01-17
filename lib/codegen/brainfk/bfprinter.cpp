#include "../../../include/codegen/brainfk/bfmodule.hpp"
#include "../../../include/codegen/brainfk/bfprinter.hpp"
#include "../../../include/utils/exception.hpp"

namespace BrainFk
{
void BFPrinter::printout(const BFModule& module) {
    const auto& insts = module.getInstructions();

    for (const auto& inst : insts)
    {
        switch (inst)
        {
        case BFInstruction::PTRINC:
            outStream << ">";
            break;
        case BFInstruction::PTRDEC:
            outStream << "<";
            break;
        case BFInstruction::INC:
            outStream << "+";
            break;
        case BFInstruction::DEC:
            outStream << "-";
            break;
        case BFInstruction::OUTPUT:
            outStream << ".";
            break;
        case BFInstruction::INPUT:
            outStream << ",";
            break;
        case BFInstruction::BEQZ:
            outStream << "[";
            break;
        case BFInstruction::BNEZ:
            outStream << "]";
            break;
        default:
            Err::unreachable();
        }
    }

    outStream << "\n";
}
}
