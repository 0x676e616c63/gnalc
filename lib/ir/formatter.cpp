#include "../../include/ir/formatter.hpp"
#include "../../include/utils/logger.hpp"

namespace IR {
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
        return "sdiv";
    case OP::FDIV:
        return "fdiv";
    case OP::REM:
        return "srem";
    case OP::FREM:
        return "frem";
    case OP::FNEG:
        return "fneg";
    case OP::AND:
        return "and";
    case OP::OR:
        return "or";
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
    case OP::ZEXT:
        return "zext";
    case OP::BITCAST:
        return "bitcast";
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

std::string IRFormatter::formatValue(Value &val) {
    if (val.getVTrait() == ValueTrait::CONDHELPER) {
        std::string ret;
        auto &cond_value = dynamic_cast<CONDValue &>(val);
        if (cond_value.getCondType() == CONDTY::AND) {
            ret += "; and rhs insts\n";
            for (const auto &rinst : cond_value.getRHSInsts())
                ret += "  " + formatInst(*rinst) + "\n";
            ret += "  ; and value";
            ret += "  " + formatValue(*cond_value.getRHS()) + " && " +
                   formatValue(*cond_value.getLHS());
            return ret;
        } else if (cond_value.getCondType() == CONDTY::OR) {
            ret += "; or rhs insts\n";
            for (const auto &rinst : cond_value.getRHSInsts())
                ret += "  " + formatInst(*rinst) + "\n";
            ret += "  ; or value";
            ret += "  " + formatValue(*cond_value.getRHS()) + " || " +
                   formatValue(*cond_value.getLHS());
            return ret;
        } else
            return "  ; unsupported cond value";
    }

    return val.getType()->toString() + " " + val.getName();
}

std::string IRFormatter::formatBB(BasicBlock &bb) {
    // substr to remove '%'
    return bb.getName().substr(1);
}

std::string IRFormatter::formatFunc(Function &func) {
    auto fn_type = toFunctionType(func.getType());
    auto ret_type = fn_type->getRet();

    std::string ret;
    ret += "define ";
    ret += "dso_local ";
    ret += ret_type->toString() + " " + func.getName();
    ret += "(";

    for (auto it = func.getParams().begin(); it != func.getParams().end();
         it++) {
        ret += (*it)->getType()->toString() + " noundef " + (*it)->getName();
        if (std::next(it) != func.getParams().end()) {
            ret += ", ";
        }
    }

    ret += ")";
    return ret;
}

std::string IRFormatter::formatFuncDecl(FunctionDecl &func) {
    auto fn_type = toFunctionType(func.getType());
    auto ret_type = fn_type->getRet();

    std::string ret;
    ret += "declare ";
    ret += ret_type->toString() + " " + func.getName();
    ret += "(";

    for (auto it = fn_type->getParams().begin();
         it != fn_type->getParams().end(); it++) {
        ret += (*it)->toString() + " noundef";
        if (std::next(it) != fn_type->getParams().end() || fn_type->isVAArg()) {
            ret += ", ";
        }
    }

    if (fn_type->isVAArg())
        ret += "...";

    ret += ")";
    return ret;
}

std::string IRFormatter::formatGV(GlobalVariable &gv) {
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

std::string IRFormatter::formatInst(Instruction &inst) {
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
        return IRFormatter::fBinaryInst(dynamic_cast<BinaryInst &>(inst));
    case OP::FPTOSI:
    case OP::SITOFP:
    case OP::ZEXT:
    case OP::BITCAST:
        return IRFormatter::fCastInst(dynamic_cast<CastInst &>(inst));
    case OP::FNEG:
        return IRFormatter::fFNEGInst(dynamic_cast<FNEGInst &>(inst));
    case OP::ICMP:
        return IRFormatter::fICMPInst(dynamic_cast<ICMPInst &>(inst));
    case OP::FCMP:
        return IRFormatter::fFCMPInst(dynamic_cast<FCMPInst &>(inst));
    case OP::RET:
        return IRFormatter::fRETInst(dynamic_cast<RETInst &>(inst));
    case OP::BR:
        return IRFormatter::fBRInst(dynamic_cast<BRInst &>(inst));
    case OP::CALL:
        return IRFormatter::fCALLInst(dynamic_cast<CALLInst &>(inst));
    case OP::ALLOCA:
        return IRFormatter::fALLOCAInst(dynamic_cast<ALLOCAInst &>(inst));
    case OP::LOAD:
        return IRFormatter::fLOADInst(dynamic_cast<LOADInst &>(inst));
    case OP::STORE:
        return IRFormatter::fSTOREInst(dynamic_cast<STOREInst &>(inst));
    case OP::GEP:
        return IRFormatter::fGEPInst(dynamic_cast<GEPInst &>(inst));
    case OP::PHI:
        return IRFormatter::fPHIInst(dynamic_cast<PHIInst &>(inst));

    case OP::HELPER:
        return IRFormatter::fHELPERInst(dynamic_cast<HELPERInst &>(inst));

    default:
        return "unknown instruction";
    }
}

std::string IRFormatter::fBinaryInst(BinaryInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += inst.getType()->toString() + " ";
    ret += inst.getLHS()->getName();
    ret += ", ";
    ret += inst.getRHS()->getName();
    return ret;
}

std::string IRFormatter::fFNEGInst(FNEGInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += inst.getType()->toString() + " ";
    ret += inst.getVal()->getName();
    return ret;
}

std::string IRFormatter::fICMPInst(ICMPInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += IRFormatter::formatCMPOP(inst.getCond()) + " ";
    ret += inst.getLHS()->getType()->toString() + " ";
    ret += inst.getLHS()->getName();
    ret += ", ";
    ret += inst.getRHS()->getName();
    return ret;
}

std::string IRFormatter::fFCMPInst(FCMPInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += IRFormatter::formatCMPOP(inst.getCond()) + " ";
    ret += inst.getLHS()->getType()->toString() + " ";
    ret += inst.getLHS()->getName();
    ret += ", ";
    ret += inst.getRHS()->getName();
    return ret;
}

std::string IRFormatter::fRETInst(RETInst &inst) {
    std::string ret;
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    if (inst.isVoid()) {
        ret += "void";
    } else {
        ret += IRFormatter::formatValue(*(inst.getRetVal()));
    }
    return ret;
}

std::string IRFormatter::fBRInst(BRInst &inst) {
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

std::string IRFormatter::fCALLInst(CALLInst &inst) {
    std::string ret;
    if (!inst.isVoid()) {
        ret += inst.getName();
        ret += " = ";
    }
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += inst.getType()->toString() + " ";
    ret += inst.getFuncName();
    ret += "(";
    auto args = inst.getArgs();
    for (auto it = args.begin(); it != args.end(); it++) {
        ret += (**it).getType()->toString() + " noundef " + (**it).getName();
        if (std::next(it) != args.end()) {
            ret += ", ";
        }
    }
    ret += ")";
    return ret;
}

std::string IRFormatter::fCastInst(CastInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += inst.getOType()->toString() + " ";
    ret += inst.getOVal()->getName();
    ret += " to ";
    ret += inst.getTType()->toString();
    return ret;
}

std::string IRFormatter::fALLOCAInst(ALLOCAInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    if (inst.isStatic()) {
        ret += inst.getBaseType()->toString();
    } else {
        // ret += IRFormatter::formatIRTYPE(inst.getBaseType());
        // ret += ", ";
        // ret += IRFormatter::formatValue(*(inst.getNumElements()));
    }
    ret += ", align ";
    ret += std::to_string(inst.getAlign());
    return ret;
}

std::string IRFormatter::fLOADInst(LOADInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += inst.getType()->toString() + ", ";
    ret += IRFormatter::formatValue(*(inst.getPtr()));
    ret += ", align ";
    ret += std::to_string(inst.getAlign());
    return ret;
}

std::string IRFormatter::fSTOREInst(STOREInst &inst) {
    std::string ret;
    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += IRFormatter::formatValue(*(inst.getValue()));
    ret += ", ";
    ret += IRFormatter::formatValue(*(inst.getPtr()));
    ret += ", align ";
    ret += std::to_string(inst.getAlign());
    return ret;
}

std::string IRFormatter::fGEPInst(GEPInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";

    ret += IRFormatter::formatOp(inst.getOpcode()) + " ";
    ret += inst.getBaseType()->toString();

    ret += ", ";
    ret += IRFormatter::formatValue(*(inst.getPtr()));

    for (auto idx : inst.getIdxs()) {
        ret += ", ";
        ret += IRFormatter::formatValue(*idx);
    }

    return ret;
}

std::string IRFormatter::fPHIInst(PHIInst &inst) {
    std::string ret;

    return ret;
}

std::string IRFormatter::fHELPERInst(HELPERInst &inst) {
    switch (inst.getHlpType()) {
    case HELPERTY::IF: {
        auto &if_inst = dynamic_cast<IFInst &>(inst);
        std::string ret = "; if cond value\n";
        ret += "  " + formatValue(*if_inst.getCond()) + "\n";
        ret += "  ; if body insts\n";
        for (const auto &body_inst : if_inst.getBodyInsts())
            ret += "  " + formatInst(*body_inst) + "\n";
        ret += "  ; if body end";
        if (if_inst.hasElse()) {
            ret += "\n  ; else body insts\n";
            for (const auto &else_inst : if_inst.getElseInsts())
                ret += "  " + formatInst(*else_inst) + "\n";
            ret += "  ; else body end";
        }
        return ret;
    } break;
    case HELPERTY::WHILE: {
        auto &while_inst = dynamic_cast<WHILEInst &>(inst);
        std::string ret = "; while cond insts\n";
        for (const auto &cond_inst : while_inst.getCondInsts())
            ret += "  " + formatInst(*cond_inst) + "\n";

        ret += "  ; while cond value\n";
        ret += "  " + formatValue(*while_inst.getCond()) + "\n";

        ret += "  ; while body insts\n";
        for (const auto &body_inst : while_inst.getBodyInsts())
            ret += "  " + formatInst(*body_inst) + "\n";

        ret += "  ; while body end";
        return ret;
    } break;
    case HELPERTY::BREAK:
        return "; break";
        break;
    case HELPERTY::CONTINUE:
        return "; continue";
        break;
    }
    return "; unknown helper";
}
} // namespace IR
