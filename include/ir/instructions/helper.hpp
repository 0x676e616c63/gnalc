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
};

class IFBEnd : public Instruction {
public:
};

class ELSEBEntry : public Instruction {
public:
};

class ELSEBEnd : public Instruction {
public:
};

class WHILEBEntry : public Instruction {
public:
};

class WHILEBEnd : public Instruction {
public:
};

}

#endif