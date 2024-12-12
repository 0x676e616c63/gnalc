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

// 线性LR打印（未划分基本块）
class LIRPrinter : public IRVisitor {
private:
    std::ofstream outfile;
    void write(const std::string& str);

};

class IRPrinter : public IRVisitor {
};

}


#endif