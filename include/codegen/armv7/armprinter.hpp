#pragma once
#ifndef GNALC_CODEGEN_ARMV7_ARMPRINTER_HPP
#define GNALC_CODEGEN_ARMV7_ARMPRINTER_HPP

#include "../../../include/mir/instructions/memory.hpp"
#include "../../../include/mirtools/tool.hpp"
#include "../../mir/module.hpp"
#include <iostream>

namespace MIR {
/// @warning 不同机器制表符 '\t' 的宽度可能不同
/// @todo 目前只有mov用上了条件执行
class ARMPrinter {
private:
    Function const *cur_func;
    std::ostream &outStream;
    variant_const_toString visitor_c; // ret a string
    variant_opcode_toString visitor_op;
    variant_reg_toString visitor_reg;

public:
    explicit ARMPrinter(std::ostream &outStream_) : outStream(outStream_) {}

    void printout(const Module &);
    void printout(const GlobalObj &);
    void printout(const Function &);
    void printout(const BasicBlock &);
    void printout(const std::shared_ptr<Instruction> &);

private:
    // inst helpers
    bool instTryHelp(const std::shared_ptr<Instruction> &);
    bool movInstHelper(const std::shared_ptr<Instruction> &);
    void calleesaveHelper(const std::shared_ptr<Instruction> &);
    void vmrsHelper();
    void memoryHelper(const std::shared_ptr<Instruction> &);
    void branchHelper(const std::shared_ptr<Instruction> &);
    void retHelper();
};
} // namespace MIR

#endif