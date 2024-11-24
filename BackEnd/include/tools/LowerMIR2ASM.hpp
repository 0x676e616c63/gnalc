#ifndef LOWERMIR2ASM
#define LOWERMIR2ASM
#pragma once
#include "../../Arm.hpp"
#include "../../include/tools/LowerMIR2ASM.hpp"
///@todo 指令合法化
///@todo 指令调度


class ArmTools::LowerMIR2ASM{
    public:
        LowerMIR2ASM();
        ~LowerMIR2ASM()=default;
        void ToString();
};


#endif