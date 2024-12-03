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
        FrameObj(Operand&, Imm&);
        // FrameObj(); // 用于加载非栈上的地址, 需要手动选定基址寄存器

        ~FrameObj()=default;
        
        int offset; // in the subframe
        ArmTools::CoreRegisterName baseReg = ArmTools::CoreRegisterName::sp;
       
        unsigned int vitualReg; // 标记MIR中与之绑定的ptr
        unsigned int val_size;
        OperandType valType;
};

class ArmStruct::SubFrame{
    public:
        SubFrame();
        ~SubFrame()=default;
        unsigned int offset = 4; // 即 r7 + 4 的位置, 因为需要返回值
        unsigned int sizeTotal;
        // 相对寻址应该不会是FPU寄存器
        ArmTools::CoreRegisterName baseReg = ArmTools::CoreRegisterName::r7;
        std::list<std::unique_ptr<FrameObj>> ObjList;

        SubFrame& operator=(ArmStruct::SubFrame&);
        void addFrameObj(ArmStruct::Operand&, ArmStruct::Imm&);
        // void bindOnFrameObj(ArmStruct::MMptr&);

};
class ArmStruct::Function{
    public:
        Function(IR::Function); // waiting...
        ~Function()=default;
        bool isStackInst(Instruction&); // stack分配相关的指令
        
        ///@note 在寄存器分配之前存在, 由于虚拟寄存器无限, 栈空间只会被local使用, 也就是处理alloca指令, 由于alloca指令都在func的最前端, 并且带初始化, 所以其实很难去回收空间
        ///@note 在处理完alloca之后, 遍历
        void MkFrameInit(); 
        ///@note 在寄存器分配之后, 多出来了一些用于管理temp区的load/store指令
        void MkFrameFinal();

        // auto mid_end_func 可能是用于标记那些特殊作为的函数入口的BB
        /// @todo mid_end_func不如放在每个BB内部, 用于替换普通的label
        /// @todo 具体如何去做需要进一步研究
        
        // void RenameLabel();
        void TerminatorPredict();
        
        std::string& toString();
        
        std::list<std::reference_wrapper<ArmStruct::BB>> BBList;
        
        unsigned int InstCnt = 0;
        std::string Identifier;
    private:
        std::unordered_set<std::reference_wrapper<ArmStruct::FrameObj>&, ArmTools::HashFrameObj, ArmTools::HashFrameObjEqual> free_chunk;
        SubFrame local;
        SubFrame temp;
        SubFrame params;
};

#endif