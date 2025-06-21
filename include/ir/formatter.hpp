/**
* @brief 将 IR 输出为格式化文本，Printer 的辅助类，亦可作调试用
*/
#ifndef GNALC_IR_FORMATTER_HPP
#define GNALC_IR_FORMATTER_HPP

#pragma once
#include "base.hpp"
#include "global_var.hpp"
#include "instructions/compare.hpp"
#include "instructions/helper.hpp"

#include <string>

namespace IR {
class IRFormatter {
public:
    static std::string formatSTOCLASS(STOCLASS cls);
    static std::string formatOp(OP op);
    static std::string formatCMPOP(ICMPOP cond);
    static std::string formatCMPOP(FCMPOP cond);
    static std::string formatHELPERTY(HELPERTY hlpty);

    static std::string formatValue(Value &val); // -> i32 %a
    static std::string formatBB(BasicBlock &bb);
    static std::string formatFunc(Function &func); // define dso_local void @fu(i32 noundef %a, i32 noundef %b)
    static std::string formatLinearFunc(LinearFunction &func); // define dso_local void @fu(i32 noundef %a, i32 noundef %b)
    static std::string formatFuncDecl(FunctionDecl &func);
    static std::string formatGV(GlobalVariable &gv);
    static std::string formatInst(Instruction &inst);

private:
    // 以下私有函数仅供formatInst调用
    static std::string fBinaryInst(BinaryInst &inst);
    static std::string fCastInst(CastInst &inst);
    static std::string fFNEGInst(FNEGInst &inst);
    static std::string fICMPInst(ICMPInst &inst);
    static std::string fFCMPInst(FCMPInst &inst);
    static std::string fRETInst(RETInst &inst);
    static std::string fBRInst(BRInst &inst);
    static std::string fCALLInst(CALLInst &inst);
    static std::string fALLOCAInst(ALLOCAInst &inst);
    static std::string fLOADInst(LOADInst &inst);
    static std::string fSTOREInst(STOREInst &inst);
    static std::string fGEPInst(GEPInst &inst);
    static std::string fPHIInst(PHIInst &inst);
    static std::string fEXTRACTInst(EXTRACTInst &inst);
    static std::string fINSERTInst(INSERTInst &inst);
    static std::string fSHUFFLEInst(SHUFFLEInst &inst);
    static std::string fSELECTInst(SELECTInst &inst);
};
} // namespace IR

#endif
