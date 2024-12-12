/**
 * @brief 由于采取的IR生成策略是先生成指令流，再划分基本块，故定义一些LLVM IR中没有的指令用于辅助标记
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_HELPER_HPP
#define GNALC_IR_INSTRUCTIONS_HELPER_HPP

#include "../instruction.hpp"

namespace IR {

// IF Block Entry
class IFBEntry : public Instruction {
public:
    void accept(IRVisitor& visitor) override;
};

class IFBEnd : public Instruction {
public:
    void accept(IRVisitor& visitor) override;
};

class ELSEBEntry : public Instruction {
public:
    void accept(IRVisitor& visitor) override;
};

class ELSEBEnd : public Instruction {
public:
    void accept(IRVisitor& visitor) override;
};

class WHILEBEntry : public Instruction {
public:
    void accept(IRVisitor& visitor) override;
};

class WHILEBEnd : public Instruction {
public:
    void accept(IRVisitor& visitor) override;
};

}

#endif