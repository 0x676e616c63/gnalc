// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_BRAINFK
#include "codegen/brainfk/bfmodule.hpp"
#include "codegen/brainfk/bfprinter.hpp"
#include "utils/exception.hpp"

namespace BrainFk {
void BFPrinter::printout(const BFModule &module) {
    const auto &insts = module.getInstructions();

    for (const auto &inst : insts) {
        switch (inst) {
        case BFInst::PTRINC:
            outStream << ">";
            break;
        case BFInst::PTRDEC:
            outStream << "<";
            break;
        case BFInst::INC:
            outStream << "+";
            break;
        case BFInst::DEC:
            outStream << "-";
            break;
        case BFInst::OUTPUT:
            outStream << ".";
            break;
        case BFInst::INPUT:
            outStream << ",";
            break;
        case BFInst::BEQZ:
            outStream << "[";
            break;
        case BFInst::BNEZ:
            outStream << "]";
            break;
        default:
            Err::unreachable();
        }
    }

    outStream << "\n";
}

void BFPrinter::printout(const BF3tModule &module) {
    const auto &insts = module.getInstructions();

    for (const auto &inst : insts) {
        switch (inst) {
        case BF3tInst::PTRINC1:
            outStream << ">1";
            break;
        case BF3tInst::PTRDEC1:
            outStream << "<1";
            break;
        case BF3tInst::INC1:
            outStream << "+1";
            break;
        case BF3tInst::DEC1:
            outStream << "-1";
            break;
        case BF3tInst::OUTPUT1:
            outStream << ".1";
            break;
        case BF3tInst::INPUT1:
            outStream << ",1";
            break;
        case BF3tInst::BEQZ1:
            outStream << "[1";
            break;
        case BF3tInst::BNEZ1:
            outStream << "]1";
            break;

        case BF3tInst::PTRINC2:
            outStream << ">2";
            break;
        case BF3tInst::PTRDEC2:
            outStream << "<2";
            break;
        case BF3tInst::INC2:
            outStream << "+2";
            break;
        case BF3tInst::DEC2:
            outStream << "-2";
            break;
        case BF3tInst::OUTPUT2:
            outStream << ".2";
            break;
        case BF3tInst::INPUT2:
            outStream << ",2";
            break;
        case BF3tInst::BEQZ2:
            outStream << "[2";
            break;
        case BF3tInst::BNEZ2:
            outStream << "]2";
            break;

        case BF3tInst::PTRINC3:
            outStream << ">3";
            break;
        case BF3tInst::PTRDEC3:
            outStream << "<3";
            break;
        case BF3tInst::INC3:
            outStream << "+3";
            break;
        case BF3tInst::DEC3:
            outStream << "-3";
            break;
        case BF3tInst::OUTPUT3:
            outStream << ".3";
            break;
        case BF3tInst::INPUT3:
            outStream << ",3";
            break;
        case BF3tInst::BEQZ3:
            outStream << "[3";
            break;
        case BF3tInst::BNEZ3:
            outStream << "]3";
            break;
        default:
            Err::unreachable();
        }
        outStream << " ";
    }

    outStream << "\n";
}
} // namespace BrainFk
#endif
