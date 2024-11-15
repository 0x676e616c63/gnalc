#include <list>
#include <utility>
#include "../../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"

class ArmTools::RegisterAlloc{
    public:
        /// @brief 是否采用首先溢出至浮点寄存器
        bool ifOverflowToFloatReg = false;
        /// @brief 以Function为单位进行寄存器分配, Instruction中应有LiveInfo
        RegisterAlloc(ArmStruct::Function&, bool);
        ~RegisterAlloc()=default;
        bool InterferenceSort(ArmStruct::Operand *Oper1, ArmStruct::Operand *Oper2);
        /// @brief 制图, 填色图
        void GraphColoring();
        bool GraphSimplize();
        bool GraphNodeSpill();
        /// @brief 替换虚拟寄存器
        void ReplaceVirtualReg();
    private:
        std::vector<std::pair<ArmStruct::Operand*, bool>> VarStack;
        unsigned int AvailableNum = 13; // r0 - r12
        /// @brief Function结构
        ArmStruct::Function curFunc;
        /// @brief 活跃变量冲突图, Operand中需要有冲突数, 冲突表, 以及和物理寄存器的映射
        std::list<ArmStruct::Operand*> InterferenceGraph;
};