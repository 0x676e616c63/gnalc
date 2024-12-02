#ifndef LOWERIR2MIR
#define LOWERIR2MIR
#pragma once
#include "../../Arm.hpp"
#include "../ArmComplexMIRStruct/ArmModule.hpp"
#include "../../../include/ir/module.h"
/// @todo 消除phi函数
/// @todo 插入寄存器保护指令
/// @todo 生成MIR的Def集和Use集
/// @todo 处理Imm和全局全局变量---检查指令是否可以使用Imm或者全局变量
/// @todo ---单独维护Imm和全局变量(不为其维护寄存器)

/// @note 如果设计为递归地转化为IR的话, 无疑会复杂include, 所以比较好的办法是, 设计一个
/// @note 统一的接口将IR转MIR
class ArmTools::LowerIR2MIR{
    public:
        LowerIR2MIR(IR::Module&);
        ~LowerIR2MIR()=default;
        void run(IR::Module&);
        
        std::unique_ptr<ArmStruct::Module> getMIRModule();
    private:
        std::unique_ptr<ArmStruct::Module> Module;
};
#endif