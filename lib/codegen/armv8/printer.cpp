#include "codegen/armv8/armprinter.hpp"
#include "mir/tools.hpp"

using namespace MIR_new;

string ARMA64Printer::branchPrinter(const MIRInst &minst) {
    const auto &lable = minst.getOp(1)->relocable()->getmSym();
    const auto &cond = minst.getOp(2)->imme();

    string str;
    str = "b" + Cond2S(static_cast<Cond>(cond));
    str += '\t' + lable;

    return str;
}

string ARMA64Printer::binaryPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    ///@note deal gep add
    const auto &lhs = minst.getOp(1)->isISA() ? minst.getOp(1) : MIROperand::asISAReg(ARMReg::SP, OpT::Int64);
    const auto &rhs = minst.getOp(2);
    auto op = minst.opcode<OpC>();
    auto bitWide = getBitWideChoosen(def->type(), lhs->type(), rhs->type());

    string str;
    str += OpC2S(op) + '\t';
    str += reg2s(def, bitWide) + ",\t";
    str += reg2s(lhs, bitWide) + ",\t";

    if (rhs->isISA()) {
        str += reg2s(rhs, bitWide);
    } else { // constant
        str += '#' + std::to_string(rhs->imme());
    }

    // for extra shift op
    if ((op == OpC::InstAdd || op == OpC::InstSub) && minst.getOp(3)) {

        str += ",\t";

        unsigned imme = minst.getOp(3)->imme();
        unsigned shift_op = imme >> 30;

        if (shift_op == 0) {
            str += "lsl ";
        } else if (shift_op == 1) {
            str += "lsr ";
        } else if (shift_op == 2) {
            str += "asr ";
        }

        str += '#' + std::to_string(imme % 0b100000);
    }

    return str;
}

string ARMA64Printer::selectPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &lhs = minst.getOp(1);
    const auto &rhs = minst.getOp(2);
    auto op = minst.opcode<ARMOpC>();
    const auto &cond = minst.getOp(3)->imme();
    auto bitWide = getBitWideChoosen(def->type(), lhs->type(), rhs->type());

    string str;

    str += ARMOpC2S(op) + '\t';
    if (op != ARMOpC::CSET_SELECT) {
        str += reg2s(def, bitWide) + ",\t";
        str += reg2s(lhs, bitWide) + ",\t";
        str += reg2s(rhs, bitWide) + ",\t";
        str += Cond2S(static_cast<Cond>(cond));
    } else {
        str += reg2s(def, bitWide) + ",\t";
        str += Cond2S(static_cast<Cond>(cond));
    }

    return str;
}

string ARMA64Printer::unaryPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &lhs = minst.getOp(1);
    auto op = minst.opcode<OpC>();
    auto bitWide = getBitWideChoosen(def->type(), lhs->type());

    string str;
    str += OpC2S(op) + '\t';
    str += reg2s(def, bitWide) + ",\t";
    str += reg2s(lhs, bitWide);

    return str;
}

string ARMA64Printer::cmpPrinter(const MIRInst &minst) {

    const auto &lhs = minst.getOp(1);
    const auto &rhs = minst.getOp(2);
    auto op = minst.opcode<OpC>();
    auto bitWide = getBitWideChoosen(lhs->type(), rhs->type());

    string str;

    str += OpC2S(op) + '\t' + reg2s(lhs, bitWide) + ",\t";

    if (rhs->isISA()) {
        str += reg2s(rhs, bitWide);
    } else { // constant
        str += '#' + std::to_string(rhs->imme());
    }

    return str;
}

string ARMA64Printer::convertPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &use = minst.getOp(1);
    auto bitWide = getBitWideChoosen(def->type(), use->type());

    string str;
    str += OpC2S(minst.opcode<OpC>()) + '\t';
    str += reg2s(def, bitWide) + ",\t";
    str += reg2s(use, bitWide);

    return str;
}

string ARMA64Printer::copyPrinter(const MIRInst &minst) {
    auto opcode = minst.opcode<OpC>();
    const auto &def = minst.ensureDef();
    const auto &use = minst.getOp(1);
    auto defType = def->type();
    auto useType = use->type();

    string str;

    auto bitWide = getBitWideChoosen(defType, useType);

    if (defType == OpT::Float && useType == OpT::Float) {
        ///@note mov from an isa to another isa, maybe caused by reduntant load eliminate
        str += "mov\t" + reg2s(def, 16, true) + ".16b,\t" + reg2s(use, 16, true) + ".16b";

    } else if (inRange(defType, OpT::Int, OpT::Int64) && inRange(useType, OpT::Float, OpT::Floatvec) ||
               inRange(useType, OpT::Int, OpT::Int64) && inRange(defType, OpT::Float, OpT::Floatvec) ||
               inRange(useType, OpT::Float, OpT::Floatvec) && inRange(defType, OpT::Float, OpT::Floatvec)) {

        str += "fmov\t" + reg2s(def, bitWide) + ",\t" + reg2s(use, bitWide);
    } else if (defType == OpT::Intvec || defType == OpT::Floatvec || useType == OpT::Intvec ||
               useType == OpT::Floatvec) {
        ///@todo vector regs 需要提供v<>寄存器的视图方式
        Err::todo("copyPrinter: vectorize todo");
    } else {
        str += "mov\t" + reg2s(def, bitWide) + ",\t" + reg2s(use, bitWide);
    }

    return str;
}

string ARMA64Printer::memoryPrinter(const MIRInst &minst) {
    MIROperand_p op1 = nullptr;
    MIROperand_p base = nullptr;
    MIROperand_p idx = nullptr; // isa or imme
    MIROperand_p shift = nullptr;

    auto memSize = minst.getOp(5)->imme();

    string str;

    if (minst.opcode<ARMOpC>() == ARMOpC::LDR) {

        if (minst.getOp(1)->isReloc()) {
            auto reg = Reg2S(minst.ensureDef(), memSize); // adrp + ldr
            auto label = minst.getOp(1)->relocable()->getmSym();
            str += "ldr\t" + reg + ", [" + reg + ", #:got_lo12:" + label + "]";

            return str;
        }

        op1 = minst.ensureDef();
        base = minst.getOp(1)->isISA() ? minst.getOp(1) : MIROperand::asISAReg(ARMReg::SP, OpT::Int64);
        idx = minst.getOp(2);
        shift = minst.getOp(3);
    } else if (minst.opcode<ARMOpC>() == ARMOpC::STR) {
        op1 = minst.getOp(1);
        base = minst.getOp(2)->isISA() ? minst.getOp(2) : MIROperand::asISAReg(ARMReg::SP, OpT::Int64);
        idx = minst.getOp(3);
        shift = minst.getOp(4);
    }

    str += ARMOpC2S(minst.opcode<ARMOpC>()) + '\t';

    str += reg2s(op1, memSize) + ",\t";

    str += '[';
    // base
    str += reg2s(base, 8);

    // const idx or var offset with shift
    if (idx) {
        str += ", ";

        if (idx->isImme()) {
            str += '#' + std::to_string(idx->imme());
        } else if (idx->isISA()) {
            str += reg2s(idx, 8);

            if (shift) {
                str += ", ";

                unsigned imme = shift->imme();
                unsigned shift_op = imme >> 30;

                if (shift_op == 0) {
                    str += "lsl ";
                } else if (shift_op == 1) {
                    str += "lsr ";
                } else if (shift_op == 2) {
                    str += "asr ";
                }

                str += '#' + std::to_string(imme % 0b100000);
            }

        } else {
            Err::unreachable("memoryPrinter: illegal operand");
        }
    }

    str += "]\n";

    return str;
}

string ARMA64Printer::smullPrinter(const MIRInst &minst) {
    string str;

    const auto &def = minst.ensureDef();
    const auto &op1 = minst.getOp(1);
    const auto &op2 = minst.getOp(2);

    str += "smull\t";
    str += reg2s(def, 8) + ",\t";
    str += reg2s(op1, 4) + ",\t";
    str += reg2s(op2, 4) + '\n';

    return str;
}

string ARMA64Printer::ternaryPrinter(const MIRInst &minst) {
    string str;

    const auto &def = minst.ensureDef();
    const auto &op1 = minst.getOp(1);
    const auto &op2 = minst.getOp(2);
    const auto &op3 = minst.getOp(3);

    auto bitWide = getBitWideChoosen_L(def->type(), op1->type(), op2->type(), op3->type());

    str += ARMOpC2S(minst.opcode<ARMOpC>()) + '\t';
    str += reg2s(def, bitWide) + ",\t";
    str += reg2s(op1, bitWide) + ",\t";
    str += reg2s(op2, bitWide) + ",\t";
    str += reg2s(op3, bitWide) + '\n';

    return str;
}

string ARMA64Printer::csetPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &cond = minst.getOp(1)->imme();

    string str;

    str += "cset\t";
    str += reg2s(def, 4) + ",\t";
    str += Cond2S(static_cast<Cond>(cond));

    return str;
}

string ARMA64Printer::cbnzPrinter(const MIRInst &minst) {
    const auto &use = minst.getOp(1);
    const auto &label = minst.getOp(2)->relocable()->getmSym();

    string str;
    str += "cbnz\t";                                    // nz = not zero
    str += reg2s(use, getBitWide(use->type())) + ",\t"; // 4
    str += label;

    return str;
}

string ARMA64Printer::AdrpPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &label = minst.getOp(1)->relocable()->getmSym();

    string str;
    string reg = reg2s(def, getBitWide(def->type())); // 8

    str += "adrp\t" + reg + ", :got:" + label;

    return str;
}

string ARMA64Printer::movVPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &use = minst.getOp(1);

    auto bitWide = 16;

    string str = "mov\t";
    str += reg2s(def, bitWide, true) + ".16b,\t";
    str += reg2s(use, bitWide, true) + ".16b";

    return str;
}

string ARMA64Printer::movPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &use = minst.getOp(1);
    const auto &shift = minst.getOp(2);
    auto bitWide = getBitWideChoosen(def->type(), use->type());

    string str;
    str += ARMOpC2S(minst.opcode<ARMOpC>()) + '\t';
    str += reg2s(def, bitWide) + ",\t";

    if (use->isImme()) {
        str += '#' + std::to_string(use->imme());
    } else {
        str += reg2s(use, bitWide);
    }

    // shift
    if (shift) {
        str += ",\t";

        unsigned imme = shift->imme();
        unsigned shift_op = imme >> 30;

        if (shift_op == 0) {
            str += "lsl ";
        } else {
            Err::unreachable("movPrinter: only 'LSL' shift is permitted at operand 2");
        }

        str += '#' + std::to_string(imme % 0b100000);
    }

    return str;
}

string ARMA64Printer::fmovPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto defType = def->type();
    const auto &use = minst.getOp(1);
    const auto useType = use->type();
    const auto &shift = minst.getOp(2);
    auto bitWide = getBitWideChoosen(defType, useType);

    string str;

    if (inRange(defType, OpT::Int, OpT::Int64) && inRange(useType, OpT::Float, OpT::Floatvec) ||
        inRange(useType, OpT::Int, OpT::Int64) && inRange(defType, OpT::Float, OpT::Floatvec)) {

        str += "fmov\t" + reg2s(def, bitWide) + ",\t" + reg2s(use, bitWide);

    } else if (defType == OpT::Float && useType == OpT::Float) {
        ///@note mov from an isa to another isa, maybe caused by reduntant load eliminate
        str += "mov\t" + reg2s(def, 16, true) + ".16b,\t" + reg2s(use, 16, true) + ".16b";
    } else {
        Err::unreachable("fmovPrinter: failed to handle this");
    }

    return str;
}

string ARMA64Printer::blPrinter(const MIRInst &minst) {
    const auto &label = minst.getOp(1)->relocable()->getmSym();
    auto tail_call_tag = minst.getOp(2)->imme();

    ///@todo TCO & TRO opt

    string str = "bl\t" + label;

    return str;
}

string ARMA64Printer::calleePrinter(const MIRInst &minst) {
    auto bitMap = minst.getOp(1)->immeEx();

    string str;

    if (!isFitPairMemInst(mfunc->begCalleeSave())) {
        return calleePrinter_legacy(minst);
    }

    if (minst.opcode<ARMOpC>() == ARMOpC::PUSH) {
        int lastReg = -1;
        int offset = mfunc->begCalleeSave();
        for (int i = 0; i < 32; ++i, bitMap >>= 1) {

            if (i == ARMReg::SP) {
                continue;
            }

            if (bitMap & 1) {
                if (lastReg == -1) {
                    lastReg = i;
                } else {
                    str += "stp\t" + reg2s(MIROperand::asISAReg(lastReg, OpT::Int64), 8) + ", " +
                           reg2s(MIROperand::asISAReg(i, OpT::Int64), 8) + ", " + "[sp, #" + std::to_string(offset) +
                           "]\n    ";

                    lastReg = -1;
                    offset += 16;
                }
            }
        }

        if (lastReg != -1) {
            str += "str\t" + reg2s(MIROperand::asISAReg(lastReg, OpT::Int64), 8) + ", " + "[sp, " +
                   std::to_string(offset) + "]\n";

            lastReg = -1;
            offset += 8;
        }

        offset += offset % 16 ? 8 : 0; // align

        for (int i = 32; i < 65; ++i, bitMap >>= 1) {
            if (bitMap & 1) {
                if (lastReg == -1) {
                    lastReg = i;
                } else {
                    str += "    stp\t" + reg2s(MIROperand::asISAReg(lastReg, OpT::Floatvec), 16) + ", " +
                           reg2s(MIROperand::asISAReg(i, OpT::Floatvec), 16) + ", " + "[sp, #" +
                           std::to_string(offset) + "]\n";

                    lastReg = -1;
                    offset += 32;
                }
            }
        }

        if (lastReg != -1) {
            if (str.size() > 4) {
                str += "    "; // indent
            }

            str += "str\t" + reg2s(MIROperand::asISAReg(lastReg, OpT::Floatvec), 16) + ", " + "[sp, " +
                   std::to_string(offset) + "]\n";

            lastReg = -1;
            offset += 16;
        }

    } else {
        int lastReg = -1;
        int offset = mfunc->begCalleeSave();
        for (int i = 0; i < 32; ++i, bitMap >>= 1) {

            if (i == ARMReg::SP) {
                continue;
            }

            if (bitMap & 1) {
                if (lastReg == -1) {
                    lastReg = i;
                } else {
                    str += "ldp\t" + reg2s(MIROperand::asISAReg(lastReg, OpT::Int64), 8) + ", " +
                           reg2s(MIROperand::asISAReg(i, OpT::Int64), 8) + ", " + "[sp, #" + std::to_string(offset) +
                           "]\n    ";

                    lastReg = -1;
                    offset += 16;
                }
            }
        }

        if (lastReg != -1) {
            str += "ldr\t" + reg2s(MIROperand::asISAReg(lastReg, OpT::Int64), 8) + ", " + "[sp, " +
                   std::to_string(offset) + "]\n";

            lastReg = -1;
            offset += 8;
        }

        offset += offset % 16 ? 8 : 0; // align

        for (int i = 32; i < 65; ++i, bitMap >>= 1) {
            if (bitMap & 1) {
                if (lastReg == -1) {
                    lastReg = i;
                } else {
                    str += "    ldp\t" + reg2s(MIROperand::asISAReg(lastReg, OpT::Floatvec), 16) + ", " +
                           reg2s(MIROperand::asISAReg(i, OpT::Floatvec), 16) + ", " + "[sp, #" +
                           std::to_string(offset) + "]\n";

                    lastReg = -1;
                    offset += 32;
                }
            }
        }

        if (lastReg != -1) {
            if (str.size() > 4) {
                str += "    "; // indent
            }

            str += "ldr\t" + reg2s(MIROperand::asISAReg(lastReg, OpT::Floatvec), 16) + ", " + "[sp, " +
                   std::to_string(offset) + "]\n";

            // lastReg = -1;
            // offset += 16;
        }
    }

    return str;
}

string ARMA64Printer::calleePrinter_legacy(const MIRInst &minst) {
    auto bitMap = minst.getOp(1)->immeEx();
    int offset = mfunc->begCalleeSave();

    string str;

    // 再多就只能苦一苦fp了
    Err::gassert(isFitMemInstX(mfunc->begCalleeSave()), "calleePrinter: too large stk todo..."); // NOLINT

    if (minst.opcode<ARMOpC>() == ARMOpC::PUSH) {
        for (int i = 0; i < 32; bitMap >>= 1, ++i) {
            if (bitMap & 1) {
                str += "str\t" + reg2s(MIROperand::asISAReg(i, OpT::Int64), 8) + ", [sp, " + std::to_string(offset) +
                       ']' + "\n    ";
                offset += 8;
            }
        }

        offset += offset % 16 ? 8 : 0; // align

        for (int i = 32; i < 65; ++i, bitMap <<= 1) {
            if (bitMap & 1) {
                str += "str\t" + reg2s(MIROperand::asISAReg(i, OpT::Floatvec), 16) + ", [sp, " +
                       std::to_string(offset) + ']' + "\n    ";
                offset += 16;
            }
        }
    }

    return str;
}

string ARMA64Printer::adjustPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &use = minst.getOp(1);
    const auto &offset = minst.getOp(2);
    auto bitWide = getBitWideChoosen(def->type(), use->type());

    string str;
    if (minst.opcode<ARMOpC>() == ARMOpC::INC) {
        str += "add\t";
    } else {
        str += "sub\t";
    }

    str += reg2s(def, bitWide) + ", "; // int
    str += reg2s(use, bitWide) + ", ";

    if (offset->isImme()) {
        str += '#' + std::to_string(offset->imme());
    } else {
        str += reg2s(offset, bitWide); // int
    }

    return str;
}