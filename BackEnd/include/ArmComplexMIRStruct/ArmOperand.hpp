#ifndef ARM_OPERAND
#define ARM_OPERAND
#pragma once
#include <list>
#include <string>
#include <unordered_set>
#include <type_traits>
#include "./ArmInstruction.hpp"
#include "../tools/ArmTools.hpp"
#include "../../Arm.hpp"


enum OperandType{
    INT, FLOAT, VOID
};
class ArmStruct::Operand{
    public:
        Operand(OperandType, std::string*);
        ~Operand()=default;
        virtual void toString();
        bool operator==(ArmStruct::Operand);
        bool operator!=(ArmStruct::Operand);

        std::unordered_set<ArmStruct::Operand*> adjList;
        std::unordered_set<ArmStruct::Instruction*> moveList; // the moveInst which use this ArmStruct::Operand
        ArmStruct::Operand* alias = nullptr;
        unsigned int color = -1;
        unsigned int adjDegree = 0;
        ArmTools::CoreRegisterName rx = ArmTools::vir;
        // ExtensionRegisterName sx=Exvir;
        OperandType ValType;
        std::string *Indentifier = NULL;
};
#endif