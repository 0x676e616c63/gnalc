#ifndef ARM_GLOBAL
#define ARM_GLOBAL
#pragma once
#include <string>
#include "../../Arm.hpp"

class ArmStruct::Global{
    ///@note global基本上都是 .word伪指令, 实际上是 _DWord的长度
    public:
        Global();
        ~Global()=default;
        std::string& toString();
    private:
        std::string Label;
        std::string encoding;
};
#endif