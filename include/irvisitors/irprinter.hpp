/**
 * @brief 将IR结构输出为.ll文件
 */

#pragma once
#ifndef GNALC_IRVISITORS_IRPRINTER_HPP
#define GNALC_IRVISITORS_IRPRINTER_HPP

#include "../ir/visitor.hpp"
#include <iostream>
#include <fstream>

namespace IR {

class IRFormatter;

// 线性IR打印（未划分基本块）
class LIRPrinter : public IRVisitor {
private:
    std::ofstream outFile;
    void write(const std::string& str);
    void writeln(const std::string& str);
public:
    LIRPrinter(const std::string& filename);
    ~LIRPrinter();

    void printout(Module& module);

    // virtual void visit(Module& node) override;
    virtual void visit(GlobalVariable& node) override;
    virtual void visit(Function& node) override;
    virtual void visit(Instruction& node) override;
    // virtual void visit(ConstantInt& node) override;
    // virtual void visit(ConstantFloat& node) override;

};

class IRPrinter : public IRVisitor {
};

/**
 * @brief 将IR输出为格式化文本，Printer的辅助类，亦可作调试用
 * @attention 由于目前一些类中的get函数都是非const的，因此暂时未将下列函数的参数声明为const
 * @todo 指针问题；const和非const函数；
 */
class IRFormatter {
public:
    static std::string formatIRTYPE(IRTYPE type);
    static std::string formatSTOCLASS(STOCLASS cls);
    static std::string formatValue(Value& val); // -> i32 %a
    // static std::string formatBB(BasicBlock& bb);
    // static std::string formatConstInt(ConstantInt& ci); // 和formatValue重了
    // static std::string formatConstFloat(ConstantFloat& cf);
    static std::string formatFunc(Function& func); // define dso_local void @fu(i32 noundef %a, i32 noundef %b)
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
};


}


#endif