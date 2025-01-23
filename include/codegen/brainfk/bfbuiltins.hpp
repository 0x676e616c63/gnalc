#pragma once
#ifndef GNALC_CODEGEN_BRAINFK_BFBUILTINS_HPP
#define GNALC_CODEGEN_BRAINFK_BFBUILTINS_HPP

#include "../../config/config.hpp"
#if GNALC_EXTENSION_BRAINFK

#include "bfmodule.hpp"

// Raw Brainfk code: https://github.com/moky/BrainFuck/tree/master
// Use `bfhelper` to translate
namespace BrainFk::builtin {
// gets: Get string from stdin(with End Marker in cell #0), save the input string(starts from cell #0) and move the pointer to the end(new position the of End Marker)
const std::vector gets = { BFInst::PTRINC, BFInst::BEQZ, BFInst::DEC, BFInst::BNEZ, BFInst::PTRDEC, BFInst::BEQZ, BFInst::PTRINC, BFInst::PTRINC, BFInst::BEQZ, BFInst::DEC, BFInst::BNEZ, BFInst::PTRDEC, BFInst::PTRDEC, BFInst::BEQZ, BFInst::DEC, BFInst::PTRINC, BFInst::INC, BFInst::PTRINC, BFInst::INC, BFInst::PTRDEC, BFInst::PTRDEC, BFInst::BNEZ, BFInst::INPUT, BFInst::BEQZ, BFInst::DEC, BFInst::PTRINC, BFInst::DEC, BFInst::PTRDEC, BFInst::BNEZ, BFInst::PTRINC, BFInst::BEQZ, BFInst::BEQZ, BFInst::INC, BFInst::PTRDEC, BFInst::INC, BFInst::PTRINC, BFInst::BNEZ, BFInst::PTRINC, BFInst::BEQZ, BFInst::DEC, BFInst::PTRDEC, BFInst::INC, BFInst::PTRDEC, BFInst::INC, BFInst::PTRINC, BFInst::PTRINC, BFInst::BNEZ, BFInst::BNEZ, BFInst::PTRDEC, BFInst::BNEZ, BFInst::PTRINC, BFInst::PTRINC, BFInst::BEQZ, BFInst::DEC, BFInst::PTRDEC, BFInst::PTRDEC, BFInst::INC, BFInst::PTRINC, BFInst::PTRINC, BFInst::BNEZ, BFInst::PTRDEC, BFInst::PTRDEC };
}

#endif
#endif
