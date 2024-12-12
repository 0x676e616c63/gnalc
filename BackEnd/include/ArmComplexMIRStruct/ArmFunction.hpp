#ifndef ARM_FUNCTION
#define ARM_FUNCTION
#pragma once
#include <vector>
#include <string>
#include <list>
#include <memory>
#include "../../../include/ir/function.hpp"
#include "../tools/ArmTools.hpp"
#include "./ArmOperand.hpp"
#include "../../Arm.hpp"

/// @brief Frame系列数据结构用于管理溢出变量在栈上的内存分配
/// @brief FrameObj用来存放栈中的一个或者多个(向量化)的字长内存, 便于合法化ldr, str之类的指令
/// @brief 对应的一组(或者几组)ldr/str, 分配一个FrameObj

class ArmStruct::FrameObj{
    public:
        FrameObj(MMptr&);
        // FrameObj(); // 用于加载非栈上的地址, 需要手动选定基址寄存器

        ~FrameObj();
        
        int offset; // in the subframe
        ArmTools::CoreRegisterName baseReg = ArmTools::CoreRegisterName::sp;
       
        unsigned int vitualReg; // 标记MIR中与之绑定的ptr
        unsigned int val_size;
        OperandType valType;
};

class ArmStruct::SubFrame{
    public:
        SubFrame();
        ~SubFrame();
        unsigned int offset = 4; // 即 r7 + 4 的位置, 因为需要返回值
        unsigned int sizeTotal;
        // 相对寻址应该不会是FPU寄存器
        ArmTools::CoreRegisterName baseReg = ArmTools::CoreRegisterName::r7;
        std::list<FrameObj*> ObjList;

        // SubFrame& operator=(ArmStruct::SubFrame&);
        void addFrameObj(ArmStruct::MMptr&);
        // void bindOnFrameObj(ArmStruct::MMptr&);
        bool findFrameObj(ArmStruct::MMptr&);

};
class ArmStruct::Function{
    public:
        Function(IR::Function&); // waiting...
        ~Function();
        bool isStackInst(Instruction&); // stack分配相关的指令
        
        ///@note 在寄存器分配之前存在, 由于虚拟寄存器无限, 栈空间只会被local使用, 也就是处理alloca指令, 由于alloca指令都在func的最前端, 并且带初始化, 所以其实很难去回收空间
        ///@note 在处理完alloca之后, 遍历
        void MkFrameInit(); 
        ///@note 在寄存器分配之后, 多出来了一些用于管理temp区的load/store指令
        void MkFrameFinal();

        ///@note 插入寄存器保护指令, 希望寄存器分配阶段消除多余的指令

        void LegalizeInit();

        /// @note gcc armv7的栈空间管理很抽象, 但是这个优化只能之后再做
        /* @todo
            push {r7, lr}
            sub sp, sp, #stack_size
            add r7, sp, #0
            ...
            mov r0, %retval
            add r7, r7, #stack_size
            mov sp, r7
            pop {r7, pc}
        */
        void LegalizeFinal();

        void TerminatorPredict();
        
        std::string& toString();
        
        std::list<BB*> BBList;
        
        std::map<unsigned int, Operand*> VirRegOperandMap; // 当前函数中虚拟寄存器的映射, 同时也是存放指针的空间

        unsigned int InstCnt = 0;
        std::string Identifier;
    
    private:
        // std::unordered_set<std::reference_wrapper<ArmStruct::FrameObj>&, ArmTools::HashFrameObj, ArmTools::HashFrameObjEqual> free_chunk;
        SubFrame local;
        SubFrame temp;
        SubFrame params;
        std::string str;

};

#endif