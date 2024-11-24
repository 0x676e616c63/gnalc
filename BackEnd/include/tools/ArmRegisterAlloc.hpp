#ifndef TOOLS_REGISTERALLOC
#define TOOLS_REGISTERALLOC
#pragma once 
#include <list>
#include <utility>
#include <unordered_set>
#include <set>
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"

namespace ArmTools{
class Edge{
    public:
        Edge(ArmStruct::Operand* u, ArmStruct::Operand* v):u(u), v(v){};
        ~Edge()=default;
        ArmStruct::Operand* u;
        ArmStruct::Operand* v;
};
struct HashEqual{
    bool operator()(const ArmTools::Edge* a, const ArmTools::Edge* b) const {
        return (a->u == b->u && a->v == b->v) || (a->u == b->v && a->v == b->u);
    }
};
class MyUnOrderedSet{
    public:
        MyUnOrderedSet();
        ~MyUnOrderedSet()=default;
        std::unordered_set<ArmTools::Edge*, std::hash<Edge*>, HashEqual> set;
        bool find(ArmTools::Edge*);
};

class RegisterAlloc{
    public:
        RegisterAlloc(ArmStruct::Function&, unsigned int);
        ~RegisterAlloc()=default;
        bool InterferenceSort(ArmStruct::Operand *Oper1, ArmStruct::Operand *Oper2);
        
        void GraphColoring(); // main procedure
        
        void BuildGraph();  // used in main 
        void Simplify();
        void Coalesce();
        void Freeze();
        void SelectSpill();
        void AssignColors();
        void ReWriteProgram();

        void AddEdge(ArmStruct::Operand *u, ArmStruct::Operand *v); // used in sub function
        bool isMoveInst(ArmStruct::Instruction*);
        void MkworkList();
        void DecrementDegree(ArmStruct::Operand*);
        ArmStruct::Operand* GetAlias(ArmStruct::Operand*);
        void AddWorkList(ArmStruct::Operand*);
        bool OK(ArmStruct::Operand*, ArmStruct::Operand*);
        bool Conservative(std::unordered_set<ArmStruct::Operand*>&);
        void Combine(ArmStruct::Operand*, ArmStruct::Operand*);
        void FreezeMoves(ArmStruct::Operand*);

        std::unordered_set<ArmStruct::Operand*>* Adjacent(ArmStruct::Operand*);  // sub functions
        std::unordered_set<ArmStruct::Instruction*>* NodeMoves(ArmStruct::Operand*);
        bool isMoveRelated(ArmStruct::Operand*);
        void EnableMoves(std::unordered_set<ArmStruct::Operand*>&);
    private:
        unsigned int availableColors;
        bool isPreColoredAlready = false;
        ArmStruct::Function curFunc;
        /// @brief nodes sets
        /// @note precolored is in each operand (-1 == not precolored)
        /// @note initial is the operand not be preassign a color and not be handle by algorithm
        std::unordered_set<ArmStruct::Operand*> initial;
        std::unordered_set<ArmStruct::Operand*> simplifyWorkList;
        std::unordered_set<ArmStruct::Operand*> freezeWorkList;
        std::unordered_set<ArmStruct::Operand*> spillWorkList;
        std::unordered_set<ArmStruct::Operand*> spilledNodes;
        std::unordered_set<ArmStruct::Operand*> coalescedNodes;
        std::unordered_set<ArmStruct::Operand*> coloredNodes;
        std::vector<ArmStruct::Operand*> selectStack;
        /// @brief movInst sets
        std::unordered_set<ArmStruct::Instruction*> coalescedMoves;
        std::unordered_set<ArmStruct::Instruction*> constrainedMoves;
        std::unordered_set<ArmStruct::Instruction*> frozenMoves;
        std::unordered_set<ArmStruct::Instruction*> worklistMoves;
        std::unordered_set<ArmStruct::Instruction*> activeMoves;
        /// @brief others structure
        MyUnOrderedSet adjSet;
        /// @note adjList and moveList and so on is in each Operand node
        /// @brief Function结构
};
};
#endif