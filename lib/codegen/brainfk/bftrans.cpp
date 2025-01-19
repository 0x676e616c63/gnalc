#include "../../../include/codegen/brainfk/bfmodule.hpp"
#include "../../../include/codegen/brainfk/bftrans.hpp"
#include "../../../include/utils/exception.hpp"

namespace BrainFk
{
void BF32to8Trans::visit(const BFModule& input_module) {
    std::vector<BFInstruction> insts = trans::bf32to8::init;
    for (auto& inst : input_module.getInstructions())
    {
        switch (inst)
        {
        case BFInstruction::PTRINC:
            insts.insert(insts.end(), trans::bf32to8::ptrinc.cbegin(), trans::bf32to8::ptrinc.cend());
            break;
        case BFInstruction::PTRDEC:
            insts.insert(insts.end(), trans::bf32to8::ptrdec.cbegin(), trans::bf32to8::ptrdec.cend());
            break;
        case BFInstruction::INC:
            insts.insert(insts.end(), trans::bf32to8::inc.cbegin(), trans::bf32to8::inc.cend());
            break;
        case BFInstruction::DEC:
            insts.insert(insts.end(), trans::bf32to8::dec.cbegin(), trans::bf32to8::dec.cend());
            break;
        case BFInstruction::OUTPUT:
            insts.insert(insts.end(), trans::bf32to8::output.cbegin(), trans::bf32to8::output.cend());
            break;
        case BFInstruction::INPUT:
            insts.insert(insts.end(), trans::bf32to8::input.cbegin(), trans::bf32to8::input.cend());
            break;
        case BFInstruction::BEQZ:
            insts.insert(insts.end(), trans::bf32to8::beqz.cbegin(), trans::bf32to8::beqz.cend());
            break;
        case BFInstruction::BNEZ:
            insts.insert(insts.end(), trans::bf32to8::bnez.cbegin(), trans::bf32to8::bnez.cend());
            break;
        default:
            Err::unreachable();
        }
    }
    module.setInst(std::move(insts));
}
}
