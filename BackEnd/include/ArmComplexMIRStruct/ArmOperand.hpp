#ifndef ARM_OPERAND
#define ARM_OPERAND
#pragma once
#include <list>
#include <string>
#include <memory>
#include <unordered_set>
#include <type_traits>
#include "../../Arm.hpp"
#include "../tools/ArmTools.hpp"

enum OperandType{
    // 可拓展
    INT, FLOAT, VOID, LABLE
};
class ArmStruct::Operand{
    public:
        Operand(OperandType, std::string*);
        Operand(Operand&);
        ~Operand()=default;
        virtual std::string& toString();
        bool operator==(ArmStruct::Operand&);
        bool operator!=(ArmStruct::Operand&);

        std::unordered_set<std::reference_wrapper<ArmStruct::Operand>, ArmTools::HashOperandReferWrap, ArmTools::HashOperandReferWrapEqual> adjList;
        std::unordered_set<std::reference_wrapper<ArmStruct::Instruction>, ArmTools::HashInstReferWrap, ArmTools::HashInstReferWrapEqual> moveList; // the moveInst which use this ArmStruct::Operand
        std::unique_ptr<ArmStruct::Operand> alias = nullptr; //
        unsigned int VirReg;
        unsigned int color = -1;
        unsigned int adjDegree = 0;
        OperandType ValType;
        std::unique_ptr<std::string> Indentifier = NULL;
};

/// @note Imm是立即数或者是一个Label
/// @note 一个Inst中最多一个Imm, 有的Inst不允许Imm
/// @note 单独附加到inst的后面, 不放在def或者use集以避免分配寄存器
class ArmStruct::Imm{
    public:
        Imm();
        ~Imm()=default;
        OperandType data_type;
        std::string data; // data or label 在创建对象时处理
        virtual std::string& toString();
};
class ArmStruct::ValOnStack : public ArmStruct::Imm{
    public:
        ValOnStack();
        ~ValOnStack()=default;
        /// @note data 在下面的方法中创建
        FrameObj& space;
        std::string& toString() final;
};
#endif