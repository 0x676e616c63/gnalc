#ifndef ARM_BB
#define ARM_BB
#pragma once
#include <list>
#include <vector>
#include <memory>
#include <unordered_set>
#include "../../Arm.hpp"
#include "../tools/ArmTools.hpp"

class ArmStruct::Terminator{
    /// @brief terminator结构体用于描述当前bb的分支属性
    /// @brief 包括具体的分支指令, 分支bb
    /// @brief 当前的bb是显示还是隐式
    /// @brief 以及MkfallThrough用于将汇编层面上多余的块隐藏
    public:
        Terminator();
        ~Terminator()=default;
        Instruction &branchInst;
        BB& trueBlock;
        BB& falseBlock;
        bool isImplicity = false; // 是否隐式出现
        void RotateCondition(); // to set condition for branchInst
        void MkFallThrough(); // to set isImplicity as true
};

class ArmStruct::BB{
    public:
        BB(IR::BasicBlock&);
        ~BB()=default;
        
        std::string& toString();

        Terminator& Terminator;
        std::string label;
        std::list<Instruction*> InstList;
        std::unordered_set<std::reference_wrapper<Operand>, ArmTools::HashOperandReferWrap, ArmTools::HashOperandReferWrapEqual> LiveOut;
    private:
};
#endif