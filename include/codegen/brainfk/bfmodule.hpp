#pragma once
#ifndef GNALC_CODEGEN_BRAINFK_BFMODULE_HPP
#define GNALC_CODEGEN_BRAINFK_BFMODULE_HPP

#include <vector>

namespace BrainFk {
// See: https://en.wikipedia.org/wiki/Brainfuck
enum class BFInstruction {
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

class BFModule {
    std::vector<BFInstruction> instructions;
public:
    const std::vector<BFInstruction>& getInstructions() const;

    void addInst(BFInstruction inst);
    void addInsts(std::vector<BFInstruction> insts);
};
}
#endif