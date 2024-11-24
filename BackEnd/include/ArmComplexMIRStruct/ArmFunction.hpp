#ifndef ARM_FUNCTION
#define ARM_FUNCTION
#pragma once
#include <vector>
#include <string>
#include <list>
#include "../../Arm.hpp"

class ArmStruct::Function{
    public:
        Function(); // waiting...
        ~Function()=default;
        void AddBB(BB);
        void AddInst(Instruction);
        void toString();
        std::list<BB*> BBList;
        std::list<Instruction*> InstList;
    private:
        std::string Identifier;
};

#endif