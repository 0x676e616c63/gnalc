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
            return "undeftype";
        default:
            return "unknowntype";
    }
}

std::string IRFormatter::formatSTOCLASS(STOCLASS cls) {
    switch (cls) {
        case STOCLASS::GLOBAL:
            return "global";
        case STOCLASS::CONSTANT:
            return "constant";
        default:
            return "unknownstoclass";
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
        default:
            return "unknown instruction";
    }
}

}