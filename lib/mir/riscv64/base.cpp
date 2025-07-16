// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/MIR.hpp"
#include "mir/riscv64/base.hpp"

using namespace MIR;

RVOpC MIR::RVIRCondConvert(IR::ICMPOP cond) {
    switch (cond) {
    case IR::ICMPOP::eq:
        return RVOpC::BEQ;
    case IR::ICMPOP::ne:
        return RVOpC::BNE;
    case IR::ICMPOP::sgt:
        return RVOpC::BGT;
    case IR::ICMPOP::sge:
        return RVOpC::BGE;
    case IR::ICMPOP::slt:
        return RVOpC::BLT;
    case IR::ICMPOP::sle:
        return RVOpC::BLE;
    default:
        Err::unreachable();
    }
    return RVOpC::BLT;
}