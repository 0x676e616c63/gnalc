#ifndef ARM_FUNCTION
#define ARM_FUNCTION
#pragma once
#include <vector>
#include <string>
#include <list>
#include <memory>
#include "../tools/ArmTools.hpp"
#include "./ArmOperand.hpp"
#include "../../Arm.hpp"
/// @brief Frame系列数据结构用于管理溢出变量在栈上的内存分配
/// @brief FrameObj用来存放栈中的一个或者多个(向量化)的字长内存, 便于合法化ldr, str之类的指令
/// @brief 对应的一组(或者几组)ldr/str, 分配一个FrameObj
class ArmStruct::FrameObj{
    public:
        unsigned int offset;
        unsigned int val_size;
        // 相对寻址应该不会是FPU寄存器
        ArmTools::CoreRegisterName baseReg;
        OperandType valType;
};
class ArmStruct::SubFrame{
    public:
        unsigned int offset;
        unsigned int sizeTotal;
        unsigned int sizeRemain;
        std::list<std::unique_ptr<FrameObj>> ObjList;
        void operator=(ArmStruct::SubFrame&) const;
};
class ArmStruct::Function{
    public:
        Function(); // waiting...
        ~Function()=default;
        void AddBB(BB);
        void AddInst(Instruction);
        void MkFrame(); // 这里打算在寄存器分配完成之后, 遍历BB和inst,从而计算出每个Frame, 不想再进一步复杂寄存器分配算法
        
        ///@todo 方案一: 完全静态的Frame: 每个SubFrame都是静态的, FrameObj也是静态, 也就是在占据该栈空间的操作数生命周期结束后, 无法释放对应的空间
        ///@todo 方案二: 相对静态的Frame: 实现Frame内部的FrameObj的内存回收(活跃区间结束时回收), 但各个SubFrame的大小和边界不变 
        ///@todo 方案三: 动态Frame: FrameObj可以回收, 同时SubFrame的边界随着SubFrame内存的回收或者释放而变化(不如不分块)
        
        std::string& toString();
        // mid_end_func
        std::list<std::reference_wrapper<BB>> BBList;
        std::list<std::reference_wrapper<Operand>> GlobalList;
    private:
        /// @brief 类似cache中的组相联映射
        SubFrame local;
        SubFrame temp;
        SubFrame params;
        std::string Identifier;
};

#endif