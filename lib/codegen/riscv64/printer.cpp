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

    if (with_runtime) {
        auto runtime_types = module.getRuntimeTypes();
        for (auto rt : runtime_types) {
            writeln("\n\n");
            write(Runtime::getRuntime(rt, Runtime::RtTarget::RISCV64));
        }
    }
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

        writeln(".globl ", sym);
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

        writeln(".globl ", sym);
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

    writeln("");
}

void RV64Printer::printout(const MIRBlk &mblk) {
    const auto &sym = mblk.getmSym();
    writeln(sym, ": ");

    for (auto &minst : mblk.Insts())
        printout(*minst);
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
        case OpC::InstSRem:
        case OpC::InstURem:
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
        case OpC::InstBranch:
        case OpC::InstICmpBranch:
            outStream << formatBranch(minst);
            break;

        case OpC::InstLoad:
        case OpC::InstStore:
            Err::unreachable("Should be legalized in preRAlegalize");
            break;
        case OpC::InstAddSP:
            Err::unreachable("Should be legalized in postRAlegalize");
            break;
        case OpC::InstLoadAddress:
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
        printoutRV64(minst);
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

    if (op->isImme()) {
        if (op->isExImme())
            return std::to_string(static_cast<int64_t>(op->imme()));
        return std::to_string(static_cast<int>(op->imme()));
    }

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
    case OpC::InstSRem:
        opstr = "rem";
        break;
    case OpC::InstURem:
        opstr = "remu";
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
        switch (opcode) {
        case OpC::InstAdd:
        case OpC::InstAnd:
        case OpC::InstOr:
        case OpC::InstXor:
        case OpC::InstShl:
        case OpC::InstAShr:
        case OpC::InstLShr:
            opstr += "i";
            break;
        case OpC::InstSub:
            opstr = "addi";
            src2 = "-" + src2;
            break;
        default:
            Err::unreachable("bad legalization");
        }
    }

    switch (opcode) {
    case OpC::InstAdd:
    case OpC::InstSub:
    case OpC::InstMul:
    case OpC::InstSDiv:
    case OpC::InstUDiv:
    case OpC::InstSRem:
    case OpC::InstURem: {
        auto bitWide = getBitWideChoosen(def->type(), lhs->type(), rhs->type());
        if (bitWide < 8)
            opstr += "w";
    }
    default:
        break;
    }

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
        return "fcvt.w.s " + dst + ", " + src + ", rtz";
    case OpC::InstS2F:
        return "fcvt.s.w " + dst + ", " + src + ", rtz";
    case OpC::InstFRINTZ:
        return "fcvt.w.s " + dst + ", " + src + ", rtz";
    default:
        Err::unreachable("Unsupported conversion opcode");
    }
    return "";
}

string RV64Printer::formatCopy(const MIRInst &minst) {
    auto opcode = minst.opcode<OpC>();
    switch (opcode) {
    case OpC::InstCopy:
    case OpC::InstCopyFromReg:
    case OpC::InstCopyToReg: {
        auto dst = formatOperand(minst.getOp(0));
        auto src = formatOperand(minst.getOp(1));

        bool to_int = inRange(minst.getOp(0)->type(), OpT::Int, OpT::Int64);
        bool from_int = inRange(minst.getOp(1)->type(), OpT::Int, OpT::Int64);
        bool to_float = inRange(minst.getOp(0)->type(), OpT::Float, OpT::Float32);
        bool from_float = inRange(minst.getOp(1)->type(), OpT::Float, OpT::Float32);

        std::string movopcode;
        if (from_int && to_int)
            movopcode = "mv";
        else if (from_float && to_float)
            movopcode = "fmv.s";
        else if (from_int && to_float)
            movopcode = "fmv.w.x";
        else if (from_float && to_int)
            movopcode = "fmv.x.w";
        else
            Err::unreachable("bad legalization");

        return movopcode + " " + dst + ", " + src;
    }
    default:
        Err::unreachable("Unsupported copy opcode");
    }
    return "";
}

string RV64Printer::formatBranch(const MIRInst &minst) {
    if (minst.opcode<OpC>() == OpC::InstBranch)
        return "j " + formatOperand(minst.getOp(1));

    if (minst.opcode<OpC>() == OpC::InstICmpBranch) {
        auto cond = minst.getOp(4)->imme();
        auto bropcode = [&] {
            switch (cond) {
            case Cond::EQ:
                return RVOpC::BEQ;
            case Cond::NE:
                return RVOpC::BNE;
            case Cond::GT:
                return RVOpC::BGT;
            case Cond::GE:
                return RVOpC::BGE;
            case Cond::LT:
                return RVOpC::BLT;
            case Cond::LE:
                return RVOpC::BLE;
            default:
                Err::unreachable();
            }
            return RVOpC::BLT;
        }();

        return RV64::RVOpC2S(bropcode) + " " + formatOperand(minst.getOp(1)) + ", " +
               formatOperand(minst.getOp(2)) + ", " + formatOperand(minst.getOp(3));
    }

    Err::unreachable();
    return "";
}