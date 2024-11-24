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
        virtual std::string& toString();
        bool operator==(ArmStruct::Operand);
        bool operator!=(ArmStruct::Operand);

        std::unordered_set<ArmStruct::Operand*> adjList;
        std::unordered_set<ArmStruct::Instruction*> moveList; // the moveInst which use this ArmStruct::Operand
        ArmStruct::Operand* alias = nullptr;
        unsigned int VirReg; // VirReg passed from mid-end
        unsigned int color = -1; // the register sequence
        unsigned int adjDegree = 0;
        OperandType ValType;
        std::string *Indentifier = NULL;
};

class ArmStruct::Imm : public ArmStruct::Operand{
    public:
        Imm();
        ~Imm()=default;
        std::string data_begin;
        std::string& toString() final;
};
#endif