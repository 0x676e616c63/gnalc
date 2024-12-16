#include "../../include/irvisitors/irprinter.hpp"
#include "../../include/utils/exception.hpp"
#include "../../include/utils/logger.hpp"

namespace IR {

LIRPrinter::LIRPrinter(const std::string& filename) {
    Logger::logDebug("LIRPrinter: Opening file: " + filename);
    outFile.open(filename, std::ios::out);
    Err::assert(outFile.is_open(), "Failed to open file: " + filename);
}

LIRPrinter::~LIRPrinter() {
    if (outFile.is_open()) {
        outFile.close();
        Logger::logDebug("LIRPrinter: Closed file.");
    }
}

void LIRPrinter::write(const std::string& str) {
    if (outFile.is_open()) {
        outFile << str;
    }
}

void LIRPrinter::writeln(const std::string& str) {
    if (outFile.is_open()) {
        outFile << str << std::endl;
    }
}

void LIRPrinter::printout(Module& module) {
    Logger::logInfo("LIRPrinter: Printing Module \"" + module.getName() + "\"");
    writeln("; Module: " + module.getName());

    writeln("");

    Logger::logDebug("LIRPrinter: Printing Global Variables");
    for (GlobalVariable* gv : module.getGlobalVars()) {
        gv->accept(*this);
    }

    writeln("");

    Logger::logDebug("LIRPrinter: Printing Functions");
    for (Function* func : module.getFunctions()) {
        func->accept(*this);
        writeln("");
    }

    Logger::logInfo("LIRPrinter: Finished printing Module \"" + module.getName() + "\"");
}

// void LIRPrinter::visit(Module& node) {
// }

void LIRPrinter::visit(GlobalVariable& node) {
    Logger::logDebug("LIRPrinter: Printing Global Variable \"" + node.getName() + "\"");
    writeln(IRFormatter::formatGV(node));
}

void LIRPrinter::visit(Function& node) {
    Logger::logDebug("LIRPrinter: Printing Function \"" + node.getName() + "\"");
    write(IRFormatter::formatFunc(node));
    writeln(" {");

    for (Instruction* inst : node.getInsts()) {
        inst->accept(*this);
    }

    writeln("}");
}

void LIRPrinter::visit(Instruction& node) {
    Logger::logDebug("LIRPrinter: Printing Instruction \"" + node.getName() + "\"");
    writeln(IRFormatter::formatInst(node));
}


std::string IRFormatter::formatIRTYPE(IRTYPE type) {
    switch (type) {
        case IRTYPE::I32:
            return "i32";
        case IRTYPE::FLOAT:
            return "float";
        case IRTYPE::VOID:
            return "void";
        case IRTYPE::PTR:
            return "ptr";
        case IRTYPE::UNDEFINED:
            Logger::logDebug("ERR: Undefined IRTYPE");
            return "UNDEFTYPE";
        default:
            Logger::logDebug("ERR: Unknown IRTYPE");
            return "UNKNOWNTYPE";
    }
}

std::string IRFormatter::formatSTOCLASS(STOCLASS cls) {
    switch (cls) {
        case STOCLASS::GLOBAL:
            return "global";
        case STOCLASS::CONSTANT:
            return "constant";
        default:
            Logger::logDebug("ERR: Unknown STOCLASS");
            return "UNKNOWNSTOCLASS";
    }
}

std::string IRFormatter::formatOp(OP op) {
    switch (op) {
        case OP::ADD:
            return "add";
        case OP::FADD:
            return "fadd";
        case OP::SUB:
            return "sub";
        case OP::FSUB:
            return "fsub";
        case OP::MUL:
            return "mul";
        case OP::FMUL:
            return "fmul";
        case OP::DIV:
            return "div";
        case OP::FDIV:
            return "fdiv";
        case OP::REM:
            return "rem";
        case OP::FREM:
            return "frem";
        case OP::FNEG:
            return "fneg";
        case OP::ICMP:
            return "icmp";
        case OP::FCMP:
            return "fcmp";
        case OP::RET:
            return "ret";
        case OP::BR:
            return "br";
        case OP::CALL:
            return "call";
        case OP::FPTOSI:
            return "fptosi";
        case OP::SITOFP:
            return "sitofp";
        case OP::ALLOCA:
            return "alloca";
        case OP::LOAD:
            return "load";
        case OP::STORE:
            return "store";
        case OP::GEP:
            return "getelementptr";
        case OP::PHI:
            return "phi";
        default:
            Logger::logDebug("ERR: Unknown OP");
            return "UNKNOWNOP";
    }
}

std::string IRFormatter::formatCMPOP(ICMPOP cond) {
    switch (cond) {
        case ICMPOP::eq:
            return "eq";
        case ICMPOP::ne:
            return "ne";
        case ICMPOP::sgt:
            return "sgt";
        case ICMPOP::sge:
            return "sge";
        case ICMPOP::slt:
            return "slt";
        case ICMPOP::sle:
            return "sle";
        default:
            Logger::logDebug("ERR: Unknown ICMPOP");
            return "UNKNOWNICMPOP";
    }
}

std::string IRFormatter::formatCMPOP(FCMPOP cond) {
    switch (cond) {
        case FCMPOP::oeq:
            return "oeq";
        case FCMPOP::ogt:
            return "ogt";
        case FCMPOP::oge:
            return "oge";
        case FCMPOP::olt:
            return "olt";
        case FCMPOP::ole:
            return "ole";
        case FCMPOP::one:
            return "one";
        case FCMPOP::ord:
            return "ord";
        default:
            Logger::logDebug("ERR: Unknown FCMPOP");
            return "UNKNOWNFCMPOP";
    }
}

std::string IRFormatter::formatHELPERTY(HELPERTY hlpty) {
    switch (hlpty) {
        case HELPERTY::IFBEntry:
            return "IFBEntry";
        case HELPERTY::IFBEnd:
            return "IFBEnd";
        case HELPERTY::ELSEBEntry:
            return "ELSEBEntry";
        case HELPERTY::ELSEBEnd:
            return "ELSEBEnd";
        case HELPERTY::WHILEBEntry:
            return "WHILEBEntry";
        case HELPERTY::WHILEBEnd:
            return "WHILEBEnd";
        default:
            Logger::logDebug("ERR: Unknown HELPERTY");
            return "UNKNOWNHELPERTY";
    }
}

std::string IRFormatter::formatValue(Value& val) {
    return IRFormatter::formatIRTYPE(val.getType()) + " " + val.getName();
}

std::string IRFormatter::formatFunc(Function& func) {
    std::string ret;
    ret += "define ";
    ret += "dso_local ";
    ret += IRFormatter::formatIRTYPE(func.getType()) + " " + func.getName();
    ret += "(";

    for (auto it = func.getParams().begin(); it != func.getParams().end(); it++) {
        ret += IRFormatter::formatIRTYPE((*it)->getType()) + " noundef " + (*it)->getName();
        if (std::next(it) != func.getParams().end()) {
            ret += ", ";
        }
    }

    ret += ")";
    return ret;
}

std::string IRFormatter::formatGV(GlobalVariable& gv) {
    std::string ret;
    ret += gv.getName();
    ret += " = ";
    ret += "dso_local ";
    ret += IRFormatter::formatSTOCLASS(gv.getStorageClass()) + " ";

    // 最外层的initer的类型即为gv的类型，就在initer中递归print了
    // // type
    // if (gv.isArray()) {
    //     for (int size : gv.getArraySize()) {
    //         ret += "[" + std::to_string(size) + " x ";
    //     }
    //     ret += IRFormatter::formatIRTYPE(gv.getVarType());
    //     for (int i = 0; i < gv.getArraySize().size(); i++) {
    //         ret += "]";
    //     }
    // } else {
    //     ret += IRFormatter::formatIRTYPE(gv.getVarType());
    // }
    // ret += " ";

    // initializer
    ret += gv.getIniter().toString();
    ret += ", align " + std::to_string(gv.getAlign());
    return ret;
}

std::string IRFormatter::formatInst(Instruction& inst) {
    switch (inst.getOpcode()) {
        case OP::ADD:
        case OP::FADD:
        case OP::SUB:
        case OP::FSUB:
        case OP::MUL:
        case OP::FMUL:
        case OP::DIV:
        case OP::FDIV:
        case OP::REM:
        case OP::FREM:
            return IRFormatter::fBinaryInst(dynamic_cast<BinaryInst&>(inst));
        case OP::FNEG:
            return IRFormatter::fFNEGInst(dynamic_cast<FNEGInst&>(inst));
        case OP::ICMP:
            return IRFormatter::fICMPInst(dynamic_cast<ICMPInst&>(inst));
        case OP::FCMP:
            return IRFormatter::fFCMPInst(dynamic_cast<FCMPInst&>(inst));
        case OP::RET:
            return IRFormatter::fRETInst(dynamic_cast<RETInst&>(inst));
        case OP::BR:
            return IRFormatter::fBRInst(dynamic_cast<BRInst&>(inst));
        case OP::CALL:
            return IRFormatter::fCALLInst(dynamic_cast<CALLInst&>(inst));
        case OP::FPTOSI:
            return IRFormatter::fFPTOSIInst(dynamic_cast<FPTOSIInst&>(inst));
        case OP::SITOFP:
            return IRFormatter::fSITOFPInst(dynamic_cast<SITOFPInst&>(inst));
        case OP::ALLOCA:
            return IRFormatter::fALLOCAInst(dynamic_cast<ALLOCAInst&>(inst));
        case OP::LOAD:
            return IRFormatter::fLOADInst(dynamic_cast<LOADInst&>(inst));
        case OP::STORE:
            return IRFormatter::fSTOREInst(dynamic_cast<STOREInst&>(inst));
        case OP::GEP:
            return IRFormatter::fGEPInst(dynamic_cast<GEPInst&>(inst));
        case OP::PHI:
            return IRFormatter::fPHIInst(dynamic_cast<PHIInst&>(inst));

        case OP::HELPER:
            return IRFormatter::fHELPERInst(dynamic_cast<HELPERInst&>(inst));

        default:
            return "unknown instruction";
    }
}

std::string IRFormatter::fBinaryInst(BinaryInst& inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += IRFormatter::formatIRTYPE(inst.getType()) + " ";
    ret += inst.GetLHS()->getName();
    ret += ", ";
    ret += inst.GetRHS()->getName();
    return ret;
}

std::string IRFormatter::fFNEGInst(FNEGInst& inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += IRFormatter::formatIRTYPE(inst.getType()) + " ";
    ret += inst.GetVal()->getName();
    return ret;
}

std::string IRFormatter::fICMPInst(ICMPInst& inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += IRFormatter::formatCMPOP(inst.GetCond()) + " ";
    ret += IRFormatter::formatIRTYPE(inst.getType()) + " ";
    ret += inst.GetLHS()->getName();
    ret += ", ";
    ret += inst.GetRHS()->getName();
    return ret;
}

std::string IRFormatter::fFCMPInst(FCMPInst& inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += IRFormatter::formatCMPOP(inst.GetCond()) + " ";
    ret += IRFormatter::formatIRTYPE(inst.getType()) + " ";
    ret += inst.GetLHS()->getName();
    ret += ", ";
    ret += inst.GetRHS()->getName();
    return ret;
}

std::string IRFormatter::fRETInst(RETInst& inst) {
    std::string ret;
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    if (inst.isVoid()) {
        ret += "void";
    } else {
        ret += IRFormatter::formatIRTYPE(inst.getRetVal()->getType()) + " "; // or getRetType()
        ret += inst.getRetVal()->getName();
    }
    return ret;
}

std::string IRFormatter::fBRInst(BRInst& inst) {
    std::string ret;
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    if (inst.isConditional()) {
        ret += IRFormatter::formatValue(*(inst.getCond())); // TYPE i1?
        ret += ", label ";
        ret += inst.getTrueDest()->getName();
        ret += ", label ";
        ret += inst.getFalseDest()->getName();
    } else {
        ret += "label ";
        ret += inst.getDest()->getName();
    }
    return ret;
}

std::string IRFormatter::fCALLInst(CALLInst& inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += IRFormatter::formatIRTYPE(inst.getType()) + " ";
    ret += inst.getFuncName();
    ret += "(";
    auto args = inst.getArgs();
    if (!(inst.isVoid())) {
        for (auto it = args.begin(); it != args.end(); it++) {
            ret += IRFormatter::formatValue(**it);
            if (std::next(it) != inst.getArgs().end()) {
                ret += ", ";
            }
        }
    }
    ret += ")";
    return ret;
}

std::string IRFormatter::fFPTOSIInst(FPTOSIInst& inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += IRFormatter::formatIRTYPE(inst.getOType()) + " ";
    ret += inst.getOVal()->getName();
    ret += " to ";
    ret += IRFormatter::formatIRTYPE(inst.getTType());
    return ret;
}

std::string IRFormatter::fSITOFPInst(SITOFPInst& inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += IRFormatter::formatIRTYPE(inst.getOType()) + " ";
    ret += inst.getOVal()->getName();
    ret += " to ";
    ret += IRFormatter::formatIRTYPE(inst.getTType());
    return ret;
}

std::string IRFormatter::fALLOCAInst(ALLOCAInst& inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    if (inst.isStatic()) {
        if (inst.isArray()) {
            for (int size : inst.getStaticArraySize()) {
                ret += "[" + std::to_string(size) + " x ";
            }
            ret += IRFormatter::formatIRTYPE(inst.getBaseType());
            for (int i = 0; i < inst.getStaticArraySize().size(); i++) {
                ret += "]";
            }
        } else {
            ret += IRFormatter::formatIRTYPE(inst.getBaseType());
        }
    } else {
        ret += IRFormatter::formatIRTYPE(inst.getBaseType());
        ret += ", ";
        ret += IRFormatter::formatValue(*(inst.getNumElements()));
    }
    ret += ", align ";
    ret += std::to_string(inst.getAlign());
    return ret;
}

std::string IRFormatter::fLOADInst(LOADInst& inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += IRFormatter::formatIRTYPE(inst.getType()) + ", ";
    ret += IRFormatter::formatValue(*(inst.getPtr()));
    ret += ", align ";
    ret += std::to_string(inst.getAlign());
    return ret;
}

std::string IRFormatter::fSTOREInst(STOREInst& inst) {
    std::string ret;
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += IRFormatter::formatValue(*(inst.getValue()));
    ret += ", ";
    ret += IRFormatter::formatValue(*(inst.getPtr()));
    ret += ", align ";
    ret += std::to_string(inst.getAlign());
    return ret;
}

std::string IRFormatter::fGEPInst(GEPInst& inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";

    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    for (int size : inst.getArraySize()) {
        ret += "[" + std::to_string(size) + " x ";
    }
    ret += IRFormatter::formatIRTYPE(inst.getBaseType());
    for (int i = 0; i < inst.getArraySize().size(); i++) {
        ret += "]";
    }

    ret += ", ";
    ret += IRFormatter::formatValue(*(inst.getPtr()));

    for (auto idx : inst.getIdxs()) {
        ret += ", ";
        ret += IRFormatter::formatValue(*idx);
    }

    return ret;
}

std::string IRFormatter::fPHIInst(PHIInst& inst) {
    std::string ret;

    return ret;
}

std::string IRFormatter::fHELPERInst(HELPERInst& inst) {
    return "; " + IRFormatter::formatHELPERTY(inst.getHlpType());
}

}