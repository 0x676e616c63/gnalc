#ifndef TOOLS_REGISTERALLOC
#define TOOLS_REGISTERALLOC
#pragma once 
#include <list>
#include <utility>
#include <unordered_set>
#include <set>
#include "../../Arm.hpp"
#include "../ArmComplexMIRStruct/ArmFunction.hpp"


using OperRefHashPtr = std::unique_ptr<std::unordered_set<std::reference_wrapper<ArmStruct::Operand>, ArmTools::HashOperandReferWrap, ArmTools::HashOperandReferWrapEqual>>;
using OperRefHash = std::unordered_set<std::reference_wrapper<ArmStruct::Operand>, ArmTools::HashOperandReferWrap, ArmTools::HashOperandReferWrapEqual>;
using InstRefHashPtr = std::unique_ptr<std::unordered_set<std::reference_wrapper<ArmStruct::Instruction>, ArmTools::HashInstReferWrap, ArmTools::HashInstReferWrapEqual>>;
using InstRefHash = std::unordered_set<std::reference_wrapper<ArmStruct::Instruction>, ArmTools::HashInstReferWrap, ArmTools::HashInstReferWrapEqual>;


namespace ArmTools{

class MyUnOrderedSet{
    public:
        MyUnOrderedSet();
        ~MyUnOrderedSet()=default;
        std::unordered_set<ArmTools::Edge, ArmTools::HashEdge, ArmTools::HashEdgeEqual> set;
        bool find(const ArmTools::Edge&);
};

class RegisterAlloc{
    public:
        RegisterAlloc(ArmStruct::Function&, OperandType, unsigned int);
        ~RegisterAlloc()=default;
        
        void GraphColoring(); // main procedure
        
        void BuildGraph();  // used in main 
        void Simplify();
        void Coalesce();
        void Freeze();
        void SelectSpill();
        void AssignColors();
        void ReWriteProgram();

        void AddEdge(ArmStruct::Operand& u, ArmStruct::Operand& v); // used in sub function
        bool isMoveInst(ArmStruct::Instruction&);
        void MkworkList();
        void DecrementDegree(ArmStruct::Operand&);
        ArmStruct::Operand& GetAlias(ArmStruct::Operand&);
        void AddWorkList(ArmStruct::Operand&);
        bool OK(ArmStruct::Operand&, ArmStruct::Operand&);
        bool Conservative(OperRefHash&);
        void Combine(ArmStruct::Operand&, ArmStruct::Operand&);
        void FreezeMoves(ArmStruct::Operand&);

        OperRefHashPtr Adjacent(ArmStruct::Operand&);  // sub functions
        InstRefHashPtr NodeMoves(ArmStruct::Operand&);
        bool isMoveRelated(ArmStruct::Operand&);
        void EnableMoves(OperRefHash&);
    private:
        OperandType RegType;
        
        unsigned int availableColors;
        bool isPreColoredAlready = false;
        ArmStruct::Function& curFunc;
        /// @brief nodes sets
        /// @note precolored is in each operand (-1 == not precolored)
        /// @note initial is the operand not be preassign a color and not be handle by algorithm
        OperRefHash initial;
        OperRefHash simplifyWorkList;
        OperRefHash freezeWorkList;
        OperRefHash spillWorkList;
        OperRefHash spilledNodes;
        OperRefHash coalescedNodes;
        OperRefHash coloredNodes;
        std::vector<std::reference_wrapper<ArmStruct::Operand>> selectStack;
        /// @brief movInst sets
        InstRefHash coalescedMoves;
        InstRefHash constrainedMoves;
        InstRefHash frozenMoves;
        InstRefHash worklistMoves;
        InstRefHash activeMoves;
        /// @brief others structure
        MyUnOrderedSet adjSet;
        /// @note adjList and moveList and so on is in each Operand node
        /// @brief Function结构
};
};
#endif