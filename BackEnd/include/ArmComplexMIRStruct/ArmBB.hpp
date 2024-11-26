#ifndef ARM_BB
#define ARM_BB
#pragma once
#include <list>
#include <vector>
#include <memory>
#include <unordered_set>
#include "../../Arm.hpp"
#include "../tools/ArmTools.hpp"

class ArmStruct::BB{
    public:
        BB();
        ~BB()=default;
        void TerminatorPredict();
        BB& Terminator;
        std::list<std::reference_wrapper<Instruction>> InstList;
        std::unordered_set<std::reference_wrapper<Operand>, ArmTools::HashOperandReferWrap, ArmTools::HashOperandReferWrapEqual> LiveOut;
    private:
};
#endif