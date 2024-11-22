#ifndef ARM_ArmStruct
#define ARM_ArmStruct
#pragma once
#include <list>
#include <vector>
#include "../../include/tools/ArmTools.hpp"
#include "./ArmOperand.hpp"
#include "../../Arm.hpp"

class ArmStruct::Instruction{
    public:
        Instruction();
        ~Instruction()=default;
        virtual void toString();
        /// @brief Def集一般只有一个元素, 但是不排除SIMD指令
        /// @brief Use集可能一个或是两个
        std::vector<Operand*> DefOperandList;
        std::vector<Operand*> UseOperandList;
        /// @brief 用于反向查找
        BB &BasicBlock;
};

#endif