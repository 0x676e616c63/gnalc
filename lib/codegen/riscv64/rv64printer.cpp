// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "codegen/riscv64/rv64printer.hpp"
#include "mir/tools.hpp"

using namespace MIR;
void RV64Printer::printoutRV64(const MIRInst &minst) {
    auto rvopc = minst.opcode<RVOpC>();
    write(RV64::RVOpC2S(rvopc), " ");
    std::vector<std::string> ops;
    for (auto &op : minst.operands()) {
        if (op == nullptr)
            ops.emplace_back("<null operand>");
        else
            ops.emplace_back(formatOperand(op));
    }
    switch (minst.opcode<RVOpC>()) {
    case RVOpC::BEQ:
    case RVOpC::BNE:
    case RVOpC::BGE:
    case RVOpC::BLT:
    case RVOpC::BGT:
    case RVOpC::BLE:
    case RVOpC::BGTU:
    case RVOpC::BLEU:
        write(ops[1], ", ", ops[2], ", ", ops[3]);
        break;
    case RVOpC::BEQZ:
    case RVOpC::BNEZ:
    case RVOpC::BLEZ:
    case RVOpC::BGEZ:
    case RVOpC::BLTZ:
    case RVOpC::BGTZ:
        write(ops[1], ", ", ops[2]);
        break;
    case RVOpC::SLT:
    case RVOpC::SLTI:
    case RVOpC::SLTU:
    case RVOpC::FEQ:
    case RVOpC::FLT:
    case RVOpC::FLE:
    case RVOpC::AUIPC:
        write(ops[0], ", ", ops[1], ", ", ops[2]);
        break;
    case RVOpC::SEQZ:
    case RVOpC::SNEZ:
    case RVOpC::SLTZ:
    case RVOpC::SGTZ:
    case RVOpC::LA:
    case RVOpC::JAL:
    case RVOpC::MV:
    case RVOpC::FMV_S:
    case RVOpC::FMV_W_X:
    case RVOpC::FMV_X_W:
    case RVOpC::LUI:
    case RVOpC::LI:
        write(ops[0], ", ", ops[1]);
        break;
    case RVOpC::LB:
    case RVOpC::LH:
    case RVOpC::LW:
    case RVOpC::LD:
    case RVOpC::FLW:
    case RVOpC::FLD:
        // offset can be nullptr
        if (!minst.getOp(2))
            ops[2] = "0";
        write(ops[0], ", ", ops[2], "(", ops[1], ")");
        break;
    case RVOpC::SB:
    case RVOpC::SH:
    case RVOpC::SW:
    case RVOpC::SD:
    case RVOpC::FSW:
    case RVOpC::FSD:
        // offset can be nullptr
        if (!minst.getOp(3))
            ops[3] = "0";
        write(ops[1], ", ", ops[3], "(", ops[2], ")");
        break;
    case RVOpC::J:
    case RVOpC::JR:
        write(ops[1]);
        break;
    case RVOpC::JALR:
        write(ops[0], ops[2], "(", ops[1], ")");
        break;
    case RVOpC::RET:
        // pass
        break;
    default:
        Err::unreachable("Unsupported RV opcode in RV64Printer");
    }
}
