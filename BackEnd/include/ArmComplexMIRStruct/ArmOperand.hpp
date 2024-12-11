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
    INT, FLOAT, INTPTR, FLOATPTR, VOID, LABEL, BYTE, ASCIZ,
};
class ArmStruct::Operand{
    public:
        Operand(std::string);
        Operand(IR::Value*);
        Operand(OperandType, unsigned int);
        Operand(Operand&);
        ~Operand()=default;
        virtual std::string& toString();
        bool operator==(ArmStruct::Operand&);
        bool operator!=(ArmStruct::Operand&);

        OperandType ValType;
        // std::unique_ptr<std::string> Indentifier = NULL;
        unsigned int VirReg;


        /// @brief 寄存器分配相关, 拓展性几乎为零, 但是不建议改
        std::unordered_set<std::reference_wrapper<ArmStruct::Operand>, ArmTools::HashOperandReferWrap, ArmTools::HashOperandReferWrapEqual> adjList;
        std::unordered_set<std::reference_wrapper<ArmStruct::Instruction>, ArmTools::HashInstReferWrap, ArmTools::HashInstReferWrapEqual> moveList; // the moveInst which use this ArmStruct::Operand
        std::unique_ptr<ArmStruct::Operand> alias = nullptr; // 别名, 在寄存器分配中活跃区间高度重叠的操作数
        unsigned int color = -1;
        unsigned int adjDegree = 0;
    private:
        std::string str;
};

/// @note Imm是立即数或者是一个Label
/// @note 一个Inst中最多一个Imm, 有的Inst不允许Imm
/// @note 单独附加到inst的后面, 不放在def或者use集以避免分配寄存器
class ArmStruct::Imm{
    public:
        Imm();
        Imm(OperandType, std::string);
        ~Imm()=default;
        OperandType data_type;
        std::string data; // data or label 在创建对象时处理
        virtual std::string& toString();

};
class ArmStruct::MMptr : public ArmStruct::Imm{
    ///@note 关键在于能反向查找到对应的FrameObj, 同时能够被FrameObj寻址
    public:
        MMptr();
        ~MMptr()=default;
        /// @note data 在下面的方法中创建通过FrameObj创建, 先不初始化
        OperandType ptrType;
        FrameObj* space = nullptr;
        unsigned int VirReg;    // 有虚拟寄存器, 但是不参与寄存器分配
        std::string& toString() final;
};
class ArmStruct::Global : public ArmStruct::Imm{
    public:
        Global();
        ~Global()=default;
        std::string GlobalId;
        virtual std::string& toString();
};

class ArmStruct::Bss : public ArmStruct::Global{
    public:
        Bss();
        ~Bss()=default;
        bool isAlign = true;
        unsigned int ValSize;
        std::string& toString();
};
#endif