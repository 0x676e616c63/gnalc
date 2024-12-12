#ifndef ARM_ArmStruct
#define ARM_ArmStruct
#pragma once
#include <list>
#include <vector>
#include <string>
#include <memory>
#include <initializer_list>
#include "../../Arm.hpp"
#include "../../../include/ir/instruction.hpp"
#include "../tools/ArmTools.hpp"

///@todo 关于构造函数, 为了实现一对多和多对一的映射, 选择让从属BB控制inst的构造

namespace ArmStruct{
class Instruction{
    public:
        Instruction(OperCode, Imm*, BB&,
        std::initializer_list<std::reference_wrapper<Operand>> Defs, 
        std::initializer_list<std::reference_wrapper<Operand>> Uses); // signal def, no SIMD
        Instruction(ArmStruct::Instruction& , ArmTools::OperCode, unsigned int);
        ~Instruction()=default;
        ArmTools::OperCode opcode;
        unsigned int id; // 用于查找以及映射 cnt

        /// @brief Def集一般只有一个元素, 但是不排除SIMD指令, 所以先放个表
        /// @brief Use集可能一个或是两个
        std::vector<std::reference_wrapper<Operand>> DefOperandList;
        std::vector<std::reference_wrapper<Operand>> UseOperandList;
        
        Imm* attach = nullptr; // 当无法找到Def集或者Use集中的内容时, 启用attach
                    // attach可能是立即数, 或者一个label(用于branch指令)
                    // 注意这里本质上是func中valmap的一个不方便初始化的引用, 不应该在析构中delete
        
        /// @brief 用于反向查找
        BB &BasicBlock;
        bool operator==(Instruction&) const;
        virtual std::string &toString();
    private:
        std::string str;
};

class MemInstruction : public Instruction{
    ///@note alloca, free, fetch...
    ///@note %1 = alloca i32 4 .align
    ///@note attach 已被占用, 所以新加一个MMptr
    ///@note 不算push和pop, str, ldr
    public:
        MemInstruction(ArmTools::OperCode, MMptr*, BB&);
        ~MemInstruction()=default;

        MMptr* MMptr;
};

};
#endif