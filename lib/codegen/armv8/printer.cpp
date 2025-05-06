#include "codegen/armv8/armprinter.hpp"
#include "mir/strings.hpp"
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
    auto bitWide = getBitWide(def->type());

    string str;
    str += OpC2S(op) + '\t';
    str += Reg2S(def->isa(), bitWide) + ",\t";
    str += Reg2S(lhs->isa(), bitWide) + ",\t";

    if (rhs->isISA()) {
        str += Reg2S(rhs->isa(), bitWide);
    } else { // constant
        str += '#' + std::to_string(rhs->imme());
    }

    return str;
}

string ARMA64Printer::unaryPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &lhs = minst.getOp(1);
    auto op = minst.opcode<OpC>();
    auto bitWide = getBitWide(def->type());

    string str;
    str += OpC2S(op) + '\t';
    str += Reg2S(def->isa(), bitWide) + ",\t";
    str += Reg2S(lhs->isa(), bitWide) + ",\t";

    return str;
}

string ARMA64Printer::cmpPrinter(const MIRInst &minst) {

    const auto &lhs = minst.getOp(1);
    const auto &rhs = minst.getOp(2);

    string str;

    str += "cmp\t" + Reg2S(lhs->isa(), getBitWide(lhs->type())) + ",\t";

    if (rhs->isISA()) {
        str += Reg2S(rhs->isa(), getBitWide(rhs->type()));
    } else { // constant
        str += '#' + std::to_string(rhs->imme());
    }

    return str;
}

string ARMA64Printer::convertPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &use = minst.getOp(1);

    string str;
    str += OpC2S(minst.opcode<OpC>()) + '\t';
    str += Reg2S(def->isa(), getBitWide(def->type())) + ",\t";
    str += Reg2S(use->isa(), getBitWide(use->type()));

    return str;
}

string ARMA64Printer::copyPrinter(const MIRInst &minst) {
    auto opcode = minst.opcode<OpC>();
    const auto &def = minst.ensureDef();
    const auto &use = minst.getOp(1);
    auto defType = def->type();
    auto useType = use->type();

    string str;

    ///@todo vectorize
    if (all_equal_pairs(defType, OpT::Int32, useType, OpT::Int32)) {

        str += "mov\t" + Reg2S(def->isa(), 4) + ",\t" + Reg2S(use->isa(), 4);

    } else if (all_equal_pairs(defType, OpT::Int64, useType, OpT::Int64)) {

        str += "mov\t" + Reg2S(def->isa(), 8) + ",\t" + Reg2S(use->isa(), 8);

    } else if (all_equal_pairs(defType, OpT::Int, useType, OpT::Int)) {

        str += "mov\t" + Reg2S(def->isa(), 8) + ",\t" + Reg2S(use->isa(), 8);

    } else if (all_equal_pairs(defType, OpT::Int32, useType, OpT::Float32) ||
               all_equal_pairs(defType, OpT::Float32, useType, OpT::Int32)) {

        str += "fmov\t" + Reg2S(def->isa(), 8) + ",\t" + Reg2S(use->isa(), 8);

    } else {
        Err::todo("copyPrinter: vectorize todo");
    }

    return str;
}

string ARMA64Printer::memoryPrinter(const MIRInst &minst) {
    MIROperand_p op1 = nullptr;
    MIROperand_p base = nullptr;
    MIROperand_p idx = nullptr; // isa or imme
    MIROperand_p shift = nullptr;

    if (minst.opcode<ARMOpC>() == ARMOpC::LDR) {
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

    string str;

    str += ARMOpC2S(minst.opcode<ARMOpC>()) + '\t';

    str += Reg2S(op1->isa(), getBitWide(op1->type())) + ",\t";

    str += '[';
    // base
    str += Reg2S(base->isa(), 8);

    // const idx or var offset with shift
    if (idx) {
        str += ", ";

        if (idx->isImme()) {
            str += '#' + std::to_string(idx->imme());
        } else if (idx->isISA()) {
            str += Reg2S(idx->isa(), 8);

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

string ARMA64Printer::csetPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &cond = minst.getOp(1)->imme();

    string str;

    str += "cset\t";
    str += Reg2S(def->isa(), 4) + ",\t";
    str += Cond2S(static_cast<Cond>(cond));

    return str;
}

string ARMA64Printer::cbnzPrinter(const MIRInst &minst) {
    const auto &use = minst.getOp(1);
    const auto &label = minst.getOp(2)->relocable()->getmSym();

    string str;
    str += "cbnz\t";
    str += Reg2S(use->isa(), getBitWide(use->type())) + ",\t"; // 4
    str += label;

    return str;
}

string ARMA64Printer::ADRP_LDRPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &label = minst.getOp(1)->relocable()->getmSym();

    string str;
    string reg = Reg2S(def->isa(), getBitWide(def->type())); // 8

    str += "adrp\t" + reg + ", :got:" + label + '\n';
    str += "    ldr\t" + reg + ", [" + reg + ", :got_lo12:" + label + "]"; // indent

    return str;
}

string ARMA64Printer::movPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &use = minst.getOp(1);
    const auto &shift = minst.getOp(2);

    string str;
    str += ARMOpC2S(minst.opcode<ARMOpC>()) + '\t';
    str += Reg2S(def->isa(), getBitWide(def->type())) + ",\t";

    if (use->isImme()) {
        str += '#' + std::to_string(use->imme());
    } else {
        str += Reg2S(use->isa(), getBitWide(use->type()));
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

    if (minst.opcode<ARMOpC>() == ARMOpC::PUSH) {
        int lastReg = -1;
        int offset = 0;
        for (int i = 0; i < 32; ++i, bitMap >>= 1) {

            if (i == ARMReg::SP) {
                continue;
            }

            if (bitMap & 1) {
                if (lastReg == -1) {
                    lastReg = i;
                } else {
                    str += "stp\t" + Reg2S(lastReg, 8) + ", " + Reg2S(i, 8) + ", " + "[sp, " + std::to_string(offset) +
                           "]\n";

                    lastReg = -1;
                    offset += 16;
                }
            }
        }

        if (lastReg != -1) {
            str += "str\t" + Reg2S(lastReg, 8) + ", " + "[sp, " + std::to_string(offset) + "]\n";

            lastReg = -1;
            offset += 8;
        }

        offset += offset % 16 ? 8 : 0; // align

        for (int i = 32; i < 65; ++i, bitMap >>= 1) {
            if (bitMap & 1) {
                if (lastReg == -1) {
                    lastReg = i;
                } else {
                    str += "stp\t" + Reg2S(lastReg, 16) + ", " + Reg2S(i, 16) + ", " + "[sp, " +
                           std::to_string(offset) + "]\n";

                    lastReg = -1;
                    offset += 32;
                }
            }
        }

        if (lastReg != -1) {
            str += "str\t" + Reg2S(lastReg, 16) + ", " + "[sp, " + std::to_string(offset) + "]\n";

            lastReg = -1;
            offset += 16;
        }

    } else {
        int lastReg = -1;
        int offset = 0;
        for (int i = 0; i < 32; ++i, bitMap >>= 1) {

            if (i == ARMReg::SP) {
                continue;
            }

            if (bitMap & 1) {
                if (lastReg == -1) {
                    lastReg = i;
                } else {
                    str += "ldp\t" + Reg2S(lastReg, 8) + ", " + Reg2S(i, 8) + ", " + "[sp, " + std::to_string(offset) +
                           "]\n";

                    lastReg = -1;
                    offset += 16;
                }
            }
        }

        if (lastReg != -1) {
            str += "ldr\t" + Reg2S(lastReg, 8) + ", " + "[sp, " + std::to_string(offset) + "]\n";

            lastReg = -1;
            offset += 8;
        }

        offset += offset % 16 ? 0 : 8; // align

        for (int i = 32; i < 65; ++i, bitMap >>= 1) {
            if (bitMap & 1) {
                if (lastReg == -1) {
                    lastReg = i;
                } else {
                    str += "ldp\t" + Reg2S(lastReg, 16) + ", " + Reg2S(i, 16) + ", " + "[sp, " +
                           std::to_string(offset) + "]\n";

                    lastReg = -1;
                    offset += 32;
                }
            }
        }

        if (lastReg != -1) {
            str += "ldr\t" + Reg2S(lastReg, 16) + ", " + "[sp, " + std::to_string(offset) + "]\n";

            lastReg = -1;
            offset += 16;
        }
    }

    return str;
}

string ARMA64Printer::adjustPrinter(const MIRInst &minst) {
    const auto &def = minst.ensureDef();
    const auto &use = minst.getOp(1);
    const auto &offset = minst.getOp(2);

    string str;
    if (minst.opcode<ARMOpC>() == ARMOpC::INC) {
        str += "add\t";
    } else {
        str += "sub\t";
    }

    str += Reg2S(def->isa(), getBitWide(def->type())) + ", "; // int
    str += Reg2S(use->isa(), getBitWide(use->type())) + ", ";

    if (offset->isImme()) {
        str += '#' + std::to_string(offset->imme());
    } else {
        str += Reg2S(offset->isa(), getBitWide(offset->type())); // int
    }

    return str;
}