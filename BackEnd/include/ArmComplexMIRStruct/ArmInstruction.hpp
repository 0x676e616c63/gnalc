#ifndef ARM_ArmStruct
#define ARM_ArmStruct
#pragma once
#include <list>
#include <vector>
#include <string>
#include <memory>
#include "../../Arm.hpp"
#include "../tools/ArmTools.hpp"

/// @note MIR 即 instruction
/// @note OpCode中不一定所有都会用到，尤其是只有有符号数时
/// @note asm codegen采用宏展开方法, 对每个inst(mir)调用一次lowering实现1对1的map
/// @note 但是对于特殊的inst, 需要生成多条指令

class ArmStruct::Instruction{
    public:
        Instruction();
        ~Instruction()=default;
        ArmTools::OperCode opcode;
        unsigned int id; // 用于查找以及映射
        /// @brief Def集一般只有一个元素, 但是不排除SIMD指令, 所以先放个表
        /// @brief Use集可能一个或是两个
        std::vector<std::reference_wrapper<Operand>> DefOperandList;
        std::vector<std::reference_wrapper<Operand>> UseOperandList;
        Imm& attach; // 当无法找到Def集或者Use集中的内容时, 启用attach
                    // attach可能是立即数, 
        /// @brief 用于反向查找
        BB &BasicBlock;
        bool operator==(Instruction&) const;
        virtual std::string &toString();
};
#endif