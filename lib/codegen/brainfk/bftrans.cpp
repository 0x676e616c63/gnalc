// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_BRAINFK
#include "utils/exception.hpp"
#include "codegen/brainfk/bfmodule.hpp"
#include "codegen/brainfk/bftrans.hpp"

#include <vector>

namespace BrainFk {
using namespace trans::tape;
using namespace trans::bit;

void BF32t32bTrans::visit(const BF3tModule &input_module) {
    std::vector<BFInst> insts32b = bf3t::init;

    for (auto &inst : input_module.getInstructions()) {
        switch (inst) {
        case BF3tInst::PTRINC1:
            insts32b.insert(insts32b.end(), bf3t::ptrinc1.cbegin(), bf3t::ptrinc1.cend());
            break;
        case BF3tInst::PTRDEC1:
            insts32b.insert(insts32b.end(), bf3t::ptrdec1.cbegin(), bf3t::ptrdec1.cend());
            break;
        case BF3tInst::INC1:
            insts32b.insert(insts32b.end(), bf3t::inc1.cbegin(), bf3t::inc1.cend());
            break;
        case BF3tInst::DEC1:
            insts32b.insert(insts32b.end(), bf3t::dec1.cbegin(), bf3t::dec1.cend());
            break;
        case BF3tInst::OUTPUT1:
            insts32b.insert(insts32b.end(), bf3t::output1.cbegin(), bf3t::output1.cend());
            break;
        case BF3tInst::INPUT1:
            insts32b.insert(insts32b.end(), bf3t::input1.cbegin(), bf3t::input1.cend());
            break;
        case BF3tInst::BEQZ1:
            insts32b.insert(insts32b.end(), bf3t::beqz1.cbegin(), bf3t::beqz1.cend());
            break;
        case BF3tInst::BNEZ1:
            insts32b.insert(insts32b.end(), bf3t::bnez1.cbegin(), bf3t::bnez1.cend());
            break;

        case BF3tInst::PTRINC2:
            insts32b.insert(insts32b.end(), bf3t::ptrinc2.cbegin(), bf3t::ptrinc2.cend());
            break;
        case BF3tInst::PTRDEC2:
            insts32b.insert(insts32b.end(), bf3t::ptrdec2.cbegin(), bf3t::ptrdec2.cend());
            break;
        case BF3tInst::INC2:
            insts32b.insert(insts32b.end(), bf3t::inc2.cbegin(), bf3t::inc2.cend());
            break;
        case BF3tInst::DEC2:
            insts32b.insert(insts32b.end(), bf3t::dec2.cbegin(), bf3t::dec2.cend());
            break;
        case BF3tInst::OUTPUT2:
            insts32b.insert(insts32b.end(), bf3t::output2.cbegin(), bf3t::output2.cend());
            break;
        case BF3tInst::INPUT2:
            insts32b.insert(insts32b.end(), bf3t::input2.cbegin(), bf3t::input2.cend());
            break;
        case BF3tInst::BEQZ2:
            insts32b.insert(insts32b.end(), bf3t::beqz2.cbegin(), bf3t::beqz2.cend());
            break;
        case BF3tInst::BNEZ2:
            insts32b.insert(insts32b.end(), bf3t::bnez2.cbegin(), bf3t::bnez2.cend());
            break;

        case BF3tInst::PTRINC3:
            insts32b.insert(insts32b.end(), bf3t::ptrinc3.cbegin(), bf3t::ptrinc3.cend());
            break;
        case BF3tInst::PTRDEC3:
            insts32b.insert(insts32b.end(), bf3t::ptrdec3.cbegin(), bf3t::ptrdec3.cend());
            break;
        case BF3tInst::INC3:
            insts32b.insert(insts32b.end(), bf3t::inc3.cbegin(), bf3t::inc3.cend());
            break;
        case BF3tInst::DEC3:
            insts32b.insert(insts32b.end(), bf3t::dec3.cbegin(), bf3t::dec3.cend());
            break;
        case BF3tInst::OUTPUT3:
            insts32b.insert(insts32b.end(), bf3t::output3.cbegin(), bf3t::output3.cend());
            break;
        case BF3tInst::INPUT3:
            insts32b.insert(insts32b.end(), bf3t::input3.cbegin(), bf3t::input3.cend());
            break;
        case BF3tInst::BEQZ3:
            insts32b.insert(insts32b.end(), bf3t::beqz3.cbegin(), bf3t::beqz3.cend());
            break;
        case BF3tInst::BNEZ3:
            insts32b.insert(insts32b.end(), bf3t::bnez3.cbegin(), bf3t::bnez3.cend());
            break;
        default:
            Err::unreachable();
        }
    }

    if (!safe_8bit) {
        module.setInst(std::move(insts32b));
    } else {
        insts32b.insert(insts32b.begin(), bf32b::init.cbegin(), bf32b::init.cend());

        std::vector<BFInst> insts;

        for (auto &inst : insts32b) {
            switch (inst) {
            case BFInst::PTRINC:
                insts.insert(insts.end(), bf32b::ptrinc.cbegin(), bf32b::ptrinc.cend());
                break;
            case BFInst::PTRDEC:
                insts.insert(insts.end(), bf32b::ptrdec.cbegin(), bf32b::ptrdec.cend());
                break;
            case BFInst::INC:
                insts.insert(insts.end(), bf32b::inc.cbegin(), bf32b::inc.cend());
                break;
            case BFInst::DEC:
                insts.insert(insts.end(), bf32b::dec.cbegin(), bf32b::dec.cend());
                break;
            case BFInst::OUTPUT:
                insts.insert(insts.end(), bf32b::output.cbegin(), bf32b::output.cend());
                break;
            case BFInst::INPUT:
                insts.insert(insts.end(), bf32b::input.cbegin(), bf32b::input.cend());
                break;
            case BFInst::BEQZ:
                insts.insert(insts.end(), bf32b::beqz.cbegin(), bf32b::beqz.cend());
                break;
            case BFInst::BNEZ:
                insts.insert(insts.end(), bf32b::bnez.cbegin(), bf32b::bnez.cend());
                break;
            default:
                Err::unreachable();
            }
        }

        module.setInst(std::move(insts));
    }
}
} // namespace BrainFk
#endif