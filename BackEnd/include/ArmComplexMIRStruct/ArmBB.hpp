#ifndef ARM_BB
#define ARM_BB
#pragma once
#include <list>
#include <vector>
#include <unordered_set>
#include "../../Arm.hpp"

class ArmStruct::BB{
    public:
        BB();
        ~BB()=default;
        BB* BBIn;
        BB* BBout;
        // std::list<ArmStruct::Operand*> LiveOut;
        std::list<Instruction*> InstList;
        std::unordered_set<Operand*, std::hash<Operand*>> LiveOut;
    private:
};
#endif