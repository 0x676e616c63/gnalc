// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "codegen/riscv64/rv64printer.hpp"
#include "mir/tools.hpp"
#include "utils/logger.hpp"

using namespace MIR;

void RV64Printer::printout(const MIRModule &module) {
    printout(module.globals());

    writeln(".text");
    for (auto &mfunc : module.funcs())
        printout(*mfunc);
}

void RV64Printer::printout(const std::vector<MIRGlobal_p> &globals) {
    writeln(".bss");
    for (const auto &global : globals) {
        if (!global->reloc()->isBss())
            continue;

        const auto &bss = global->reloc()->as<MIRBssStorage>();
        const auto &sym = bss->getmSym();
        auto align = bss->align();
        auto size = bss->size();

        writeln(".global ", sym);
        writeln(".align ", align);
        writeln(sym, ":");
        writeln("    .zero ", size);
    }

    writeln(".data");
    for (const auto &global : globals) {
        if (!global->reloc()->isData())
            continue;

        auto data = global->reloc()->as<MIRDataStorage>();
        const auto &sym = data->getmSym();
        auto align = data->align();
        const auto &datas = data->getDatas();

        writeln(".global ", sym);
        writeln(".align ", align);
        writeln(sym, ":");

        for (const auto &entry : datas) {
            if (entry.isSize())
                writeln("    .zero ", entry.store<size_t>());
            else if (entry.isInt32())
                writeln("    .word ", entry.store<int>());
            else if (entry.isFloat()) {
                auto fp = entry.store<float>();
                unsigned encoding = *reinterpret_cast<unsigned *>(&fp);
                writeln("    .word ", encoding);
            } else
                Err::unreachable();
        }
    }
}

void RV64Printer::printout(const MIRFunction &func) {
    const auto &sym = func.getmSym();
    mfunc = &func;

    writeln(".globl ", sym);
    writeln(sym, ": ");

    for (auto &mblk : func.blks())
        printout(*mblk);
}

void RV64Printer::printout(const MIRBlk &mblk) {
    const auto &sym = mblk.getmSym();
    writeln(sym, ": ");

    for (auto &minst : mblk.Insts())
        printout(*minst);

    writeln("");
}

void RV64Printer::printout(const MIRInst &minst) {
    write("    ");
    if (minst.isGeneric()) {
        switch (minst.opcode<OpC>()) {
        case OpC::InstAdd:
        case OpC::InstSub:
        case OpC::InstMul:
        case OpC::InstAnd:
        case OpC::InstOr:
        case OpC::InstXor:
        case OpC::InstShl:
        case OpC::InstLShr:
        case OpC::InstAShr:
        case OpC::InstSDiv:
        case OpC::InstUDiv:
        case OpC::InstFAdd:
        case OpC::InstFSub:
        case OpC::InstFMul:
        case OpC::InstFDiv:
            outStream << formatBinary(minst);
            break;
        case OpC::InstNeg:
        case OpC::InstFNeg:
            outStream << formatUnary(minst);
            break;
        case OpC::InstF2S:
        case OpC::InstS2F:
        case OpC::InstFRINTZ:
            outStream << formatConverse(minst);
            break;
        case OpC::InstCopy:
        case OpC::InstCopyFromReg:
        case OpC::InstCopyToReg:
            outStream << formatCopy(minst);
            break;

        case OpC::InstLoad:
        case OpC::InstStore:
            Err::unreachable("Should be legalized in preRAlegalize");
            break;
        case OpC::InstAddSP:
            Err::unreachable("Should be legalized in postRAlegalize");
            break;
        case OpC::InstLoadGlobalAddress:
        case OpC::InstLoadImm:
        case OpC::InstLoadImmToReg:
        case OpC::InstLoadImmEx:
        case OpC::InstLoadFPImm:
        case OpC::InstLoadFPImmToReg:
            Err::unreachable("Should be legalized in preRAlegalize");
            break;
        case OpC::InstLoadStackObjectAddr:
        case OpC::InstLoadRegFromStack:
        case OpC::InstStoreRegToStack:
            Err::unreachable("Should be legalized in postRAlegalize");
            break;
        default:
            Err::unreachable("Unsupported opcode");
        }
        writeln("");
    } else {
        rv64_printout(minst);
        writeln("");
    }
}

string RV64Printer::formatOperand(const MIROperand_p &op) {
    if (op == nullptr) {
        Logger::logCritical("RV64Printer::formatOperand: Unexpected null operand.");
        return "<null>";
    }
    if (op->isISA()) {
        unsigned reg = op->reg();
        if (reg == RVReg::SP)
            return "sp";
        if (reg == RVReg::FP)
            return "fp";
        if (reg == RVReg::GP)
            return "gp";
        if (reg == RVReg::RA)
            return "ra";
        if (reg >= RVReg::X0 && reg <= RVReg::X31)
            return "x" + std::to_string(reg - static_cast<unsigned>(RVReg::X0));
        if (reg >= RVReg::F0 && reg <= RVReg::F31)
            return "f" + std::to_string(reg - static_cast<unsigned>(RVReg::F0));
        Err::unreachable();
    }

    if (op->isImme())
        return std::to_string(op->imme());

    if (op->isReloc())
        return op->reloc()->getmSym();

    // Don't panic, some operands are meant to be ignored.
    return "<bad operand>";
}

string RV64Printer::formatBinary(const MIRInst &minst) {
    auto def = minst.getOp(0);
    auto lhs = minst.getOp(1);
    auto rhs = minst.getOp(2);

    auto dst = formatOperand(def);
    auto src1 = formatOperand(lhs);
    auto src2 = formatOperand(rhs);

    auto opcode = minst.opcode<OpC>();
    std::string opstr;
    switch (opcode) {
    case OpC::InstAdd:
        opstr = "add";
        break;
    case OpC::InstSub:
        opstr = "sub";
        break;
    case OpC::InstMul:
        opstr = "mul";
        break;
    case OpC::InstAnd:
        opstr = "and";
        break;
    case OpC::InstOr:
        opstr = "or";
        break;
    case OpC::InstXor:
        opstr = "xor";
        break;
    case OpC::InstShl:
        opstr = "sll";
        break;
    case OpC::InstLShr:
        opstr = "srl";
        break;
    case OpC::InstAShr:
        opstr = "sra";
        break;
    case OpC::InstSDiv:
        opstr = "div";
        break;
    case OpC::InstUDiv:
        opstr = "divu";
        break;
    case OpC::InstFAdd:
        opstr = "fadd.s";
        break;
    case OpC::InstFSub:
        opstr = "fsub.s";
        break;
    case OpC::InstFMul:
        opstr = "fmul.s";
        break;
    case OpC::InstFDiv:
        opstr = "fdiv.s";
        break;
    default:
        Err::unreachable("Unsupported binary opcode.");
    }

    if (minst.getOp(2)->isImme()) {
        if (opcode == OpC::InstAdd)
            opstr += "i";
        else if (opcode == OpC::InstSub) {
            opstr = "addi";
            src2 = "-" + src2;
        } else Err::unreachable("bad legalization");
    }

    auto bitWide = getBitWideChoosen(def->type(), lhs->type(), rhs->type());
    if (bitWide < 8)
        opstr += "w";

    return opstr + " " + dst + ", " + src1 + ", " + src2;
}
string RV64Printer::formatUnary(const MIRInst &minst) {
    auto opcode = minst.opcode<OpC>();
    auto dst = formatOperand(minst.getOp(0));
    auto src = formatOperand(minst.getOp(1));

    switch (opcode) {
    case OpC::InstNeg:
        return "sub " + dst + ", x0, " + src;
    case OpC::InstFNeg:
        return "fsgnjn.s " + dst + ", " + src + ", " + src;
    default:
        Err::unreachable("Unsupported unary opcode.");
    }
    return "";
}
string RV64Printer::formatConverse(const MIRInst &minst) {
    auto opcode = minst.opcode<OpC>();
    auto dst = formatOperand(minst.getOp(0));
    auto src = formatOperand(minst.getOp(1));

    switch (opcode) {
    case OpC::InstF2S:
        return "fcvt.w.s " + dst + ", " + src;
    case OpC::InstS2F:
        return "fcvt.s.w " + dst + ", " + src;
    case OpC::InstFRINTZ:
        return "fcvt.w.s " + dst + ", " + src + ", rtz";
    default:
        Err::unreachable("Unsupported conversion opcode");
    }
    return "";
}
string RV64Printer::formatCopy(const MIRInst &minst) {
    auto opcode = minst.opcode<OpC>();
    auto dst = formatOperand(minst.getOp(0));
    auto src = formatOperand(minst.getOp(1));

    switch (opcode) {
    case OpC::InstCopy:
    case OpC::InstCopyFromReg:
    case OpC::InstCopyToReg:
        if (minst.getOp(0)->type() == OpT::Float32)
            return "fmv.s " + dst + ", " + src;
        return "mv " + dst + ", " + src;
    default:
        Err::unreachable("Unsupported copy opcode");
    }
    return "";
}
