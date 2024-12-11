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

    void printModule(Module* module);

};

class IRPrinter : public IRVisitor {
};

// 将IR输出为格式化文本，Printer的辅助类，亦可作调试用
class IRFormatter {
public:
    static std::string formatIRTYPE(IRTYPE type);
    static std::string formatInst(const Instruction& inst);
    static std::string formatGV(const GlobalVariable& gv);
    static std::string formatFunc(const Function& func);
private:
    static std::string fBinaryInst(const BinaryInst& inst);
};


}


#endif