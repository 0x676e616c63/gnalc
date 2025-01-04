/**
 * @brief 将IR结构输出为.ll文件
 */

#pragma once
#ifndef GNALC_IRVISITORS_IRPRINTER_HPP
#define GNALC_IRVISITORS_IRPRINTER_HPP

#define PRINT_BB_LIVEINFO 0
#define PRINT_INST_LIVEINFO 0

#include "../utils/exception.hpp"
#include "../ir/visitor.hpp"
#include <iostream>
#include <fstream>

namespace IR
{
class IRFormatter;

// 线性IR打印（未划分基本块）
class LIRPrinter : public IRVisitor {
protected:
    std::ostream& outStream;

    template <typename T>
    void write(T&& obj) {
        outStream << obj;
    }

    template <typename T>
    void writeln(T&& obj) {
        outStream << obj << std::endl;
    }

public:
    explicit LIRPrinter(std::ostream& out);
    ~LIRPrinter();

    void printout(Module& module);

    void visit(GlobalVariable& node) override;
    void visit(Function& node) override;
    void visit(FunctionDecl& node) override;
    void visit(Instruction& node) override;
};

class IRPrinter : public LIRPrinter {
public:
    explicit IRPrinter(std::ostream& out) : LIRPrinter(out) {};
    ~IRPrinter() = default;
    
    void visit(Function& node) override;
    void visit(BasicBlock& node) override;
};

/**
 * @brief 将IR输出为格式化文本，Printer的辅助类，亦可作调试用
 * @attention 由于目前一些类中的get函数都是非const的，因此暂时未将下列函数的参数声明为const
 * @todo 指针问题；const和非const函数；
 */
class IRFormatter {
public:
    static std::string formatSTOCLASS(STOCLASS cls);
    static std::string formatOp(OP op);
    static std::string formatCMPOP(ICMPOP cond);
    static std::string formatCMPOP(FCMPOP cond);
    static std::string formatHELPERTY(HELPERTY hlpty);

    static std::string formatValue(Value& val); // -> i32 %a
    static std::string formatBB(BasicBlock& bb);
    // static std::string formatConstInt(ConstantInt& ci); // 和formatValue重了
    // static std::string formatConstFloat(ConstantFloat& cf);
    static std::string formatFunc(Function& func); // define dso_local void @fu(i32 noundef %a, i32 noundef %b)
    static std::string formatFuncDecl(FunctionDecl& func);
    static std::string formatGV(GlobalVariable& gv);
    static std::string formatInst(Instruction& inst);

private:
    // 以下私有函数仅供formatInst调用
    static std::string fBinaryInst(BinaryInst& inst);
    static std::string fFNEGInst(FNEGInst& inst);
    static std::string fICMPInst(ICMPInst& inst);
    static std::string fFCMPInst(FCMPInst& inst);
    static std::string fRETInst(RETInst& inst);
    static std::string fBRInst(BRInst& inst);
    static std::string fCALLInst(CALLInst& inst);
    static std::string fFPTOSIInst(FPTOSIInst& inst);
    static std::string fSITOFPInst(SITOFPInst& inst);
    static std::string fALLOCAInst(ALLOCAInst& inst);
    static std::string fLOADInst(LOADInst& inst);
    static std::string fSTOREInst(STOREInst& inst);
    static std::string fGEPInst(GEPInst& inst);
    static std::string fPHIInst(PHIInst& inst);

    static std::string fHELPERInst(HELPERInst& inst);
};
}


#endif
