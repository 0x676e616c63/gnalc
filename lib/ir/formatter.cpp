#include "ir/formatter.hpp"
#include "ir/function.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/phi.hpp"
#include "ir/instructions/vector.hpp"
#include "utils/logger.hpp"

#include <string>

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
    case OP::EXTRACT:
        return "extractelement";
    case  OP::INSERT:
        return "insertelement";
    case OP::SHUFFLE:
        return "shufflevector";
    case OP::SELECT:
        return "select";
    default:
        Err::unreachable("ERR: Unknown OP");
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
    Err::not_implemented("HELPERTY");
    return "";
}

std::string IRFormatter::formatValue(Value &val) {
    if (val.getVTrait() == ValueTrait::CONDHELPER) {
        std::string ret;
        auto &cond_value = val.as_ref<CONDValue>();
        if (cond_value.getCondType() == CONDTY::AND) {
            ret += "; and rhs insts\n";
            for (const auto &rinst : cond_value.getRHSInsts())
                ret += "  " + formatInst(*rinst) + "\n";
            ret += "  ; and value";
            ret += "  " + formatValue(*cond_value.getRHS()) + " && " + formatValue(*cond_value.getLHS());
            return ret;
        } else if (cond_value.getCondType() == CONDTY::OR) {
            ret += "; or rhs insts\n";
            for (const auto &rinst : cond_value.getRHSInsts())
                ret += "  " + formatInst(*rinst) + "\n";
            ret += "  ; or value";
            ret += "  " + formatValue(*cond_value.getRHS()) + " || " + formatValue(*cond_value.getLHS());
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
    auto fn_type = func.getType()->as<FunctionType>();
    auto ret_type = fn_type->getRet();

    std::string ret;
    ret += "define ";
    ret += "dso_local ";
    ret += ret_type->toString() + " " + func.getName();
    ret += "(";

    const auto &params = func.getParams();
    for (auto it = params.begin(); it != params.end(); it++) {
        ret += (*it)->getType()->toString() + " noundef " + (*it)->getName();
        if (std::next(it) != func.getParams().end()) {
            ret += ", ";
        }
    }

    ret += ")";
    return ret;
}

std::string IRFormatter::formatFuncDecl(FunctionDecl &func) {
    auto fn_type = func.getType()->as<FunctionType>();
    auto ret_type = fn_type->getRet();

    std::string ret;
    ret += "declare ";
    ret += ret_type->toString() + " " + func.getName();
    ret += "(";

    for (auto it = fn_type->getParams().begin(); it != fn_type->getParams().end(); it++) {
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
    ret += formatSTOCLASS(gv.getStorageClass()) + " ";

    // 最外层的initer的类型即为gv的类型，就在initer中递归print了
    // // type
    // if (gv.isArray()) {
    //     for (int size : gv.getArraySize()) {
    //         ret += "[" + std::to_string(size) + " x ";
    //     }
    //     ret += formatIRTYPE(gv.getVarType());
    //     for (int i = 0; i < gv.getArraySize().size(); i++) {
    //         ret += "]";
    //     }
    // } else {
    //     ret += formatIRTYPE(gv.getVarType());
    // }
    // ret += " ";

    // initializer
    ret += gv.getIniter().toString();
    ret += ", align " + std::to_string(gv.getAlign());
    return ret;
}

std::string IRFormatter::formatInst(Instruction &inst) {
    // For Quick Debug
    for(const auto& use : inst.operand_uses()) {
        if (use->getValue() == nullptr) {
            Logger::logCritical("[IRFormatter]: Operand got destroyed while its user '", inst.getName(), "' is alive.");
            std::string alive_opers;
            for (const auto& oper : inst.operand_uses()) {
                if (oper->getValue())
                    alive_opers += formatValue(*oper->getValue()) + ", ";
                else
                    alive_opers += "<null>, ";
            }
            if (!alive_opers.empty()) {
                // Remove trailing ', '
                alive_opers.pop_back();
                alive_opers.pop_back();
            }
            return "  ;Bad Inst '" + inst.getName() + "', operands: " + alive_opers;
        }
    }

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
        return fBinaryInst(inst.as_ref<BinaryInst>());
    case OP::FPTOSI:
    case OP::SITOFP:
    case OP::ZEXT:
    case OP::BITCAST:
        return fCastInst(inst.as_ref<CastInst>());
    case OP::FNEG:
        return fFNEGInst(inst.as_ref<FNEGInst>());
    case OP::ICMP:
        return fICMPInst(inst.as_ref<ICMPInst>());
    case OP::FCMP:
        return fFCMPInst(inst.as_ref<FCMPInst>());
    case OP::RET:
        return fRETInst(inst.as_ref<RETInst>());
    case OP::BR:
        return fBRInst(inst.as_ref<BRInst>());
    case OP::CALL:
        return fCALLInst(inst.as_ref<CALLInst>());
    case OP::ALLOCA:
        return fALLOCAInst(inst.as_ref<ALLOCAInst>());
    case OP::LOAD:
        return fLOADInst(inst.as_ref<LOADInst>());
    case OP::STORE:
        return fSTOREInst(inst.as_ref<STOREInst>());
    case OP::GEP:
        return fGEPInst(inst.as_ref<GEPInst>());
    case OP::PHI:
        return fPHIInst(inst.as_ref<PHIInst>());
    case OP::EXTRACT:
        return fEXTRACTInst(inst.as_ref<EXTRACTInst>());
    case OP::INSERT:
        return fINSERTInst(inst.as_ref<INSERTInst>());
    case OP::SHUFFLE:
        return fSHUFFLEInst(inst.as_ref<SHUFFLEInst>());
    case OP::SELECT:
        return fSELECTInst(inst.as_ref<SELECTInst>());

    case OP::HELPER:
        return fHELPERInst(inst.as_ref<HELPERInst>());

    default:
        return "unknown instruction";
    }
}

std::string IRFormatter::fBinaryInst(BinaryInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += formatOp(inst.getOpcode()) + " ";
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
    ret += formatOp(inst.getOpcode()) + " ";
    ret += inst.getType()->toString() + " ";
    ret += inst.getVal()->getName();
    return ret;
}

std::string IRFormatter::fICMPInst(ICMPInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += formatOp(inst.getOpcode()) + " ";
    ret += formatCMPOP(inst.getCond()) + " ";
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
    ret += formatOp(inst.getOpcode()) + " ";
    ret += formatCMPOP(inst.getCond()) + " ";
    ret += inst.getLHS()->getType()->toString() + " ";
    ret += inst.getLHS()->getName();
    ret += ", ";
    ret += inst.getRHS()->getName();
    return ret;
}

std::string IRFormatter::fRETInst(RETInst &inst) {
    std::string ret;
    ret += formatOp(inst.getOpcode()) + " ";
    if (inst.isVoid()) {
        ret += "void";
    } else {
        ret += formatValue(*(inst.getRetVal()));
    }
    return ret;
}

std::string IRFormatter::fBRInst(BRInst &inst) {
    std::string ret;
    ret += formatOp(inst.getOpcode()) + " ";
    if (inst.isConditional()) {
        ret += formatValue(*(inst.getCond())); // TYPE i1?
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
    if (inst.isTailCall())
        ret += "tail ";
    ret += formatOp(inst.getOpcode()) + " ";
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
    ret += formatOp(inst.getOpcode()) + " ";
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
    ret += formatOp(inst.getOpcode()) + " ";
    // if (inst.isStatic()) {
    ret += inst.getBaseType()->toString();
    // } else {
    // ret += formatIRTYPE(inst.getBaseType());
    // ret += ", ";
    // ret += formatValue(*(inst.getNumElements()));
    // }
    ret += ", align ";
    ret += std::to_string(inst.getAlign());
    return ret;
}

std::string IRFormatter::fLOADInst(LOADInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += formatOp(inst.getOpcode()) + " ";
    ret += inst.getType()->toString() + ", ";
    ret += formatValue(*(inst.getPtr()));
    ret += ", align ";
    ret += std::to_string(inst.getAlign());
    return ret;
}

std::string IRFormatter::fSTOREInst(STOREInst &inst) {
    std::string ret;
    ret += formatOp(inst.getOpcode()) + " ";
    ret += formatValue(*(inst.getValue()));
    ret += ", ";
    ret += formatValue(*(inst.getPtr()));
    ret += ", align ";
    ret += std::to_string(inst.getAlign());
    return ret;
}

std::string IRFormatter::fGEPInst(GEPInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";

    ret += formatOp(inst.getOpcode()) + " ";
    ret += inst.getBaseType()->toString();

    ret += ", ";
    ret += formatValue(*(inst.getPtr()));

    for (const auto& idx : inst.getIdxs()) {
        ret += ", ";
        ret += formatValue(*idx);
    }

    return ret;
}

std::string IRFormatter::fPHIInst(PHIInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += formatOp(inst.getOpcode()) + " ";
    ret += inst.getType()->toString() + " ";
    auto opers = inst.getPhiOpers();
    for (auto it = opers.begin();;) {
        ret += "[ ";
        ret += it->value->getName();
        ret += ", ";
        ret += it->block->getName() + " ";
        ret += "]";
        if (++it == opers.end()) {
            break;
        } else {
            ret += ", ";
        }
    }
    return ret;
}

std::string IRFormatter::fEXTRACTInst(EXTRACTInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += formatOp(inst.getOpcode()) + " ";
    ret += formatValue(*inst.getVector()) + ", ";
    ret += formatValue(*inst.getIdx());
    return ret;
}

std::string IRFormatter::fINSERTInst(INSERTInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += formatOp(inst.getOpcode()) + " ";
    ret += formatValue(*inst.getVector()) + ", ";
    ret += formatValue(*inst.getElm()) + ", ";
    ret += formatValue(*inst.getIdx());
    return ret;
}

std::string IRFormatter::fSHUFFLEInst(SHUFFLEInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += formatOp(inst.getOpcode()) + " ";
    ret += formatValue(*inst.getVector1()) + ", ";
    ret += formatValue(*inst.getVector2()) + ", ";
    ret += formatValue(*inst.getMask());
    return ret;
}

std::string IRFormatter::fSELECTInst(SELECTInst &inst) {
    std::string ret;
    ret += inst.getName();
    ret += " = ";
    ret += formatOp(inst.getOpcode()) + " ";
    ret += formatValue(*inst.getCond()) + ", ";
    ret += formatValue(*inst.getTrueVal()) + ", ";
    ret += formatValue(*inst.getFalseVal());
    return ret;
}

std::string IRFormatter::fHELPERInst(HELPERInst &inst) {
    switch (inst.getHlpType()) {
    case HELPERTY::IF: {
        auto &if_inst = inst.as_ref<IFInst>();
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
        auto &while_inst = inst.as_ref<WHILEInst>();
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
