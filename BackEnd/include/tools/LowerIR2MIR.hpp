#ifndef LOWERIR2MIR
#define LOWERIR2MIR
#include "../../Arm.hpp"
/// @todo 消除phi函数
/// @todo 插入寄存器保护指令
/// @todo 生成MIR的Def集和Use集
/// @todo 处理Imm和全局全局变量---检查指令是否可以使用Imm或者全局变量
/// @todo ---单独维护Imm和全局变量(不为其维护寄存器)
class ArmTools::LowerIR2MIR{
    LowerIR2MIR();
    ~LowerIR2MIR()=default;
    
};
#endif