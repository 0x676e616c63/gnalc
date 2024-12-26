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
    // INT 和 FLOAT主要用于Operand区分使用什么寄存器
    // imm中主要区分是否是LABEL类
    INT, FLOAT, PTR, VOID, LABEL, BYTE, ASCIZ,
};
class ArmStruct::Operand{
    public:    
        Operand(OperandType, unsigned int color);
        Operand(OperandType, std::string);
        Operand(Operand&);
        ~Operand()=default;
        virtual std::string toString();
        bool operator==(ArmStruct::Operand&);
        bool operator!=(ArmStruct::Operand&);

        OperandType ValType;    // 好像也没用?
        // std::unique_ptr<std::string> Indentifier = NULL;
        unsigned long long VirReg;


        /// @brief 寄存器分配相关, 拓展性几乎为零, 但是不建议改
        std::unordered_set<std::reference_wrapper<ArmStruct::Operand>, ArmTools::HashOperandReferWrap, ArmTools::HashOperandReferWrapEqual> adjList;
        std::unordered_set<std::reference_wrapper<ArmStruct::Instruction>, ArmTools::HashInstReferWrap, ArmTools::HashInstReferWrapEqual> moveList; // the moveInst which use this ArmStruct::Operand
        std::unique_ptr<ArmStruct::Operand> alias = nullptr; // 别名, 在寄存器分配中活跃区间高度重叠的操作数
        unsigned int color = -1;    //  预着色改这个
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
        virtual std::string toString();

};
class ArmStruct::MMptr : public ArmStruct::Imm{
    ///@note 关键在于能反向查找到对应的FrameObj, 同时能够被FrameObj寻址
    public:
        // for allocainst
        MMptr(FrameObj* loc, OperandType type, unsigned long long idx): space(loc), ptrType(type), VirReg(idx){};
        // for gepinst
        MMptr(FrameObj* loc, OperandType type, unsigned long long idx, unsigned int off)
            : space(loc), ptrType(type), VirReg(idx), offset(off){};
        MMptr(std::string);
        ~MMptr()=default;

        OperandType getType(){return ptrType;}
        FrameObj* getFrameObj(){return space;}
        void setOffset(unsigned int newOffset){offset = newOffset;}
        unsigned int getOffset(){return offset;}
        unsigned long long getVirReg(){return VirReg;}

        void setBase(Operand *base){baseVirReg = base;};        
        Operand* getBase(){return baseVirReg;};        

        bool isStatic(){return baseVirReg == nullptr;};

        std::string toString() final;

    private:
        OperandType ptrType;    // int bool float ...
        FrameObj* space;
        Operand *baseVirReg = nullptr;  // 为null表示它的基址为r7
        unsigned int offset = 0;
        unsigned long long VirReg;    // 有虚拟寄存器, 用于被寻找
};

class ArmStruct::Global : public ArmStruct::Imm{
    public:
        Global();
        ~Global()=default;
        std::string GlobalId;
        virtual std::string toString();
};

class ArmStruct::Bss : public ArmStruct::Global{
    public:
        Bss();
        ~Bss()=default;
        bool isAlign = true;
        unsigned int ValSize;
        std::string toString();
};
#endif