// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../include/codegen/armv8/armprinter.hpp"
#include <string>

using namespace MIR;

void ARMA64Printer::printout(const MIRModule &mModule) {

    // arch
    outStream << ".arch armv8-a\n";
    // cpu
    outStream << ".cpu cortex-a53\n";
    // fpu
    // outStream << ".fpu neon-fp-armv8\n";
    // crypto
    outStream << ".arch_extension crypto\n";

    outStream << '\n';

    printout(mModule.globals());

    // outStream << ".text\n.arm\n\n";
    outStream << ".text\n\n";

    for (auto &mfunc : mModule.funcs()) {
        printout(*mfunc);
    }

    if (with_runtime) {
        auto runtime_types = mModule.getRuntimeTypes();
        for (auto rt : runtime_types) {
            outStream << "\n\n\n";
            outStream << Runtime::getRuntime(rt, Runtime::RtTarget::ARMv8);
        }
    }
    return;
}

void ARMA64Printer::printout(const std::vector<MIRGlobal_p> &mGlobals) {
    ///@note 现在的全局变量是未初始化放在一起, 初始化的放在一起
    ///@todo 变量之间做padding, 避免跨越cache line

    auto log2 = [](unsigned pow) { return ctz_wrapper(pow); };

    outStream << ".bss\n";

    // handle zeroes
    for (auto &mGlo : mGlobals) {

        if (!mGlo->reloc()->isBss()) {
            continue;
        }

        auto mbss = mGlo->reloc()->as<MIRBssStorage>();
        const auto &sym = mbss->getmSym();
        const auto &align = mbss->align();
        const auto &size = mbss->size();

        outStream << ".global " + sym + '\n';
        outStream << ".align\t" + std::to_string(log2(align)) + '\n';
        outStream << sym + ":\n";
        outStream << ".type " + sym + ", %object\n";
        outStream << "    .zero\t" + std::to_string(size) + "\n\n";
    }

    outStream << ".data\n";
    for (auto &mGlo : mGlobals) {

        if (!mGlo->reloc()->isData()) {
            continue;
        }

        auto mdata = mGlo->reloc()->as<MIRDataStorage>();
        const auto &sym = mdata->getmSym();
        const auto &align = mdata->align();
        const auto &datas = mdata->getDatas();

        outStream << ".global " + sym + '\n';
        outStream << ".align\t" + std::to_string(log2(align)) + '\n';
        outStream << sym + ":\n";
        outStream << ".type " + sym + ", %object\n";

        for (const auto &data : datas) {

            if (data.isSize()) {
                outStream << "    .zero\t" + std::to_string(data.store<size_t>()) + '\n';
            } else if (data.isInt32()) {
                outStream << "    .word\t" + std::to_string(data.store<int>()) + '\n';
            } else if (data.isFloat()) {
                auto fp = data.store<float>();
                unsigned encoding = *reinterpret_cast<unsigned *>(&fp);
                outStream << "    .word\t" + std::to_string(encoding) + '\n';
            } else {
                Err::unreachable("ARMA64Printer::printout(const std::vector<MIRGlobal_p>&): MIRStorage corrupted");
            }
        }
        outStream << '\n';
    }

    outStream << '\n';
    return;
}

void ARMA64Printer::printout(const MIRFunction &_mfunc) {
    const auto &sym = _mfunc.getmSym();
    mfunc = &_mfunc;

    outStream << ".globl " + sym + '\n';
    outStream << ".align 2\n.p2align 4,,11\n";
    outStream << ".type " + sym + ", %function\n";
    outStream << sym + ":\n";

    for (auto &mblk : _mfunc.blks()) {
        printout(*mblk);
    }
}

void ARMA64Printer::printout(const MIRBlk &mblk) {
    auto log2 = [](unsigned pow) { return ctz_wrapper(pow); };

    const auto &sym = mblk.getmSym();

    outStream << sym + ":\n"; // lable

    for (auto &minst : mblk.Insts()) {
        printout(*minst);
    }

    if (mblk.useLiteral()) {
        outStream << "    .align " + std::to_string(log2(*mblk.getFirstAlign())) + "\n    .ltorg\n";
    }

    ///@todo make code layout align to enhance cache performance

    outStream << '\n';
}

void ARMA64Printer::printout(const MIRInst &minst) {

    outStream << "    "; // indent
    if (minst.isGeneric()) {
        switch (minst.opcode<OpC>()) {
        case OpC::InstBranch:
            outStream << branchPrinter(minst);
            break;
        case OpC::InstLoad:
        case OpC::InstStore:
            Err::unreachable("ARMA64Printer::printout(const MIRInst &): should be legalized in preRAlegalize");
            break;
        case OpC::InstAddSP:
            Err::unreachable("ARMA64Printer::printout(const MIRInst &): should be legalized in postRAlegalize");
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
            outStream << binaryPrinter(minst);
            break;
        case OpC::InstNeg:
        case OpC::InstFNeg:
            outStream << unaryPrinter(minst);
            break;
        case OpC::InstSRem:
        case OpC::InstFRem:
            Err::unreachable("ARMA64Printer::printout(const MIRInst &minst): rem not supported");
            break;
        case OpC::InstICmp:
        case OpC::InstFCmp:
            outStream << cmpPrinter(minst);
            break;
        case OpC::InstF2S:
        case OpC::InstS2F:
        case OpC::InstFRINTZ:
            outStream << convertPrinter(minst);
            break;
        case OpC::InstSelect:
            Err::unreachable("ARMA64Printer::printout(const MIRInst &): select inst not to be printed here");
            break;
        case OpC::InstCopy:
        case OpC::InstCopyFromReg:
        case OpC::InstCopyToReg:
            outStream << copyPrinter(minst);
            break;
        case OpC::InstLoadAddress:
            outStream << loadAddrPrinter(minst);
            break;
        case OpC::InstLoadImm:
        case OpC::InstLoadImmToReg:
        case OpC::InstLoadImmEx:
        case OpC::InstLoadFPImm:
        case OpC::InstLoadFPImmToReg:
            Err::unreachable("ARMA64Printer::printout(const MIRInst &): should be legalized in preRAlegalize");
            break;
        case OpC::InstLoadStackObjectAddr:
        case OpC::InstLoadRegFromStack:
        case OpC::InstStoreRegToStack:
            Err::unreachable("ARMA64Printer::printout(const MIRInst &): should be legalized in postRAlegalize");
            break;
        case OpC::InstVAdd:
        case OpC::InstVSub:
        case OpC::InstVMul:
        case OpC::InstVFAdd:
        case OpC::InstVFSub:
        case OpC::InstVFMul:
        case OpC::InstVFDiv:
        case OpC::InstVAnd:
        case OpC::InstVOr:
        case OpC::InstVXor:
        case OpC::InstVShl:
            outStream << binaryPrinter_v(minst);
            break;
        case OpC::InstVFNeg:
        case OpC::InstVNeg:
            outStream << unaryPrinter_v(minst);
            break;
        case OpC::InstVExtract:
            outStream << extractPrinter_v(minst);
            break;
        case OpC::InstVInsert:
            outStream << insertPrinter_v(minst);
            break;
        case OpC::InstVFP2SI:
        case OpC::InstVSI2FP:
        case OpC::InstVFRINTZ:
            outStream << convertPrinter_v(minst);
            break;
        case OpC::InstVIcmp:
        case OpC::InstVFcmp:
            outStream << cmpPrinter_v(minst);
            break;
        case OpC::InstVSelect:
            outStream << selectPrinter_v(minst);
            break;
        case OpC::InstVCopy:
            outStream << copyPrinter_v(minst);
            break;
        case OpC::InstLoadLiteral:
            outStream << literalPrinter(minst);
            break;
        default:
            Err::unreachable("ARMA64Printer::printout(const MIRInst &):  unknown opc");
        }
    } else {
        switch (minst.opcode<ARMOpC>()) {
        case ARMOpC::LDR:
        case ARMOpC::STR:
            outStream << memoryPrinter(minst);
            break;
        case ARMOpC::LDUR:
        case ARMOpC::STUR:
            Err::todo("ARMA64Printer::printout(const MIRInst &): not implemented");
            break;
        case ARMOpC::LD1:
        case ARMOpC::LD2:
        case ARMOpC::LD3:
        case ARMOpC::ST1:
        case ARMOpC::ST2:
        case ARMOpC::ST3:
            Err::todo("ARMA64Printer::printout(const MIRInst &): vectorize todo");
            break;
        case ARMOpC::SMULL:
            outStream << smullPrinter(minst); // deal with special bitWides
            break;
        case ARMOpC::MADD:
        case ARMOpC::MSUB:
        case ARMOpC::FMADD:
        case ARMOpC::FMSUB:
            outStream << ternaryPrinter(minst);
            break;
        case ARMOpC::MLS_V:
        case ARMOpC::MLA_V:
            outStream << mlPrinter_v(minst);
            break;
        case ARMOpC::CSEL:
        case ARMOpC::CSET_SELECT:
        case ARMOpC::FCSEL:
            outStream << selectPrinter(minst);
            break;
        case ARMOpC::CSET:
            outStream << csetPrinter(minst);
            break;
        case ARMOpC::CBNZ:
            outStream << cbnzPrinter(minst);
            break;
        case ARMOpC::ADRP:
            outStream << AdrpPrinter(minst);
            break;
        case ARMOpC::MOV_V:
            outStream << movVPrinter(minst);
            break;
        case ARMOpC::MOV:
        case ARMOpC::MOVZ:
        case ARMOpC::MOVK:
            outStream << movPrinter(minst);
            break;
        case ARMOpC::MOVF: // fmov
            outStream << fmovPrinter(minst);
            break;
        case ARMOpC::MOVI:
            outStream << moviPrinter(minst);
            break;
        case ARMOpC::BL:
            outStream << blPrinter(minst);
            break;
        case ARMOpC::RET:
            outStream << "ret\n";
            break;
        case ARMOpC::PUSH:
        case ARMOpC::POP:
            outStream << calleePrinter(minst);
            break;
        case ARMOpC::INC:
        case ARMOpC::DEC:
            outStream << adjustPrinter(minst);
            break;
        default:
            Err::unreachable("ARMA64Printer::printout(const MIRInst &):  unknown opc");
        }
    }

    outStream << '\n';
}
