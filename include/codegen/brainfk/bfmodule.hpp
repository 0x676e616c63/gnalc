#pragma once
#ifndef GNALC_CODEGEN_BRAINFK_BFMODULE_HPP
#define GNALC_CODEGEN_BRAINFK_BFMODULE_HPP

#include "../../config/config.hpp"
#if GNALC_EXTENSION_BRAINFK

#include <vector>

namespace BrainFk {
// See: https://en.wikipedia.org/wiki/Brainfuck
enum class BFInst {
  PTRINC,  // >   Increment the data pointer by one (to point to the next cell to the right).

  PTRDEC,  // <   Decrement the data pointer by one (to point to the next cell to the left).

  INC,     // +   Increment the byte at the data pointer by one.

  DEC,     // -   Decrement the byte at the data pointer by one.

  OUTPUT,  // .   Output the byte at the data pointer.

  INPUT,   // ,   Accept one byte of input, storing its value in the byte at the data pointer.

  BEQZ,    // [   If the byte at the data pointer is zero,
           //     then instead of moving the instruction pointer forward to the next command,
           //     jump it forward to the command after the matching ] command.

  BNEZ     // ]   If the byte at the data pointer is nonzero,
           //     then instead of moving the instruction pointer forward to the next command,
           //     jump it back to the command after the matching [ command.[a]
};

enum class BF3tInst {
    PTRINC1,
    PTRDEC1,
    INC1,
    DEC1,
    OUTPUT1,
    INPUT1,
    BEQZ1,
    BNEZ1,

    PTRINC2,
    PTRDEC2,
    INC2,
    DEC2,
    OUTPUT2,
    INPUT2,
    BEQZ2,
    BNEZ2,

    PTRINC3,
    PTRDEC3,
    INC3,
    DEC3,
    OUTPUT3,
    INPUT3,
    BEQZ3,
    BNEZ3
};

class BFModule {
    std::vector<BFInst> instructions;
public:
    const std::vector<BFInst>& getInstructions() const;

    void setInst(std::vector<BFInst> inst);
};

class BF3tModule {
    std::vector<BF3tInst> instructions;
public:
    const std::vector<BF3tInst>& getInstructions() const;

    void setInst(std::vector<BF3tInst> inst);
};
}
#endif
#endif
