#ifndef ARM_OPERAND
#define ARM_OPERAND
#pragma once
#include <list>
#include <string>
#include <memory>
#include <unordered_set>
#include <type_traits>
#include "../../Arm.hpp"

enum OperandType{
    // 可拓展
    INT, FLOAT, VOID
};
class ArmStruct::Operand{
    public:
        Operand(OperandType, std::string*);
        Operand(Operand&);
        ~Operand()=default;
        virtual std::string& toString();
        bool operator==(ArmStruct::Operand&);
        bool operator!=(ArmStruct::Operand&);

        std::unordered_set<std::reference_wrapper<ArmStruct::Operand>, ArmTools::HashOperandReferWrap, ArmTools::HashOperandReferWrapEqual> adjList;
        std::unordered_set<std::reference_wrapper<ArmStruct::Instruction>, ArmTools::HashInstReferWrap, ArmTools::HashInstReferWrapEqual> moveList; // the moveInst which use this ArmStruct::Operand
        std::unique_ptr<ArmStruct::Operand> alias = nullptr; //
        unsigned int VirReg;
        unsigned int color = -1;
        unsigned int adjDegree = 0;
        OperandType ValType;
        std::unique_ptr<std::string> Indentifier = NULL;
};

class ArmStruct::Imm : public ArmStruct::Operand{
    public:
        Imm();
        ~Imm()=default;
        std::string data_begin;
        std::string& toString() final;
};
#endif