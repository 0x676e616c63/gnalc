#pragma once
#ifndef GNALC_CODEGEN_BRAINFK_BFBUILTINS_HPP
#define GNALC_CODEGEN_BRAINFK_BFBUILTINS_HPP

#include "bfmodule.hpp"

// Raw Brainfk code: https://github.com/moky/BrainFuck/tree/master
// Use `bfhelper` to translate
namespace BrainFk::builtin {
// gets: Get string from stdin(with End Marker in cell #0), save the input string(starts from cell #0) and move the pointer to the end(new position the of End Marker)
const std::vector gets = { BFInstruction::PTRINC, BFInstruction::BEQZ, BFInstruction::DEC, BFInstruction::BNEZ, BFInstruction::PTRDEC, BFInstruction::BEQZ, BFInstruction::PTRINC, BFInstruction::PTRINC, BFInstruction::BEQZ, BFInstruction::DEC, BFInstruction::BNEZ, BFInstruction::PTRDEC, BFInstruction::PTRDEC, BFInstruction::BEQZ, BFInstruction::DEC, BFInstruction::PTRINC, BFInstruction::INC, BFInstruction::PTRINC, BFInstruction::INC, BFInstruction::PTRDEC, BFInstruction::PTRDEC, BFInstruction::BNEZ, BFInstruction::INPUT, BFInstruction::BEQZ, BFInstruction::DEC, BFInstruction::PTRINC, BFInstruction::DEC, BFInstruction::PTRDEC, BFInstruction::BNEZ, BFInstruction::PTRINC, BFInstruction::BEQZ, BFInstruction::BEQZ, BFInstruction::INC, BFInstruction::PTRDEC, BFInstruction::INC, BFInstruction::PTRINC, BFInstruction::BNEZ, BFInstruction::PTRINC, BFInstruction::BEQZ, BFInstruction::DEC, BFInstruction::PTRDEC, BFInstruction::INC, BFInstruction::PTRDEC, BFInstruction::INC, BFInstruction::PTRINC, BFInstruction::PTRINC, BFInstruction::BNEZ, BFInstruction::BNEZ, BFInstruction::PTRDEC, BFInstruction::BNEZ, BFInstruction::PTRINC, BFInstruction::PTRINC, BFInstruction::BEQZ, BFInstruction::DEC, BFInstruction::PTRDEC, BFInstruction::PTRDEC, BFInstruction::INC, BFInstruction::PTRINC, BFInstruction::PTRINC, BFInstruction::BNEZ, BFInstruction::PTRDEC, BFInstruction::PTRDEC };
}

#endif