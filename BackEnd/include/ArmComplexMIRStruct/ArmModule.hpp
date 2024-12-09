#pragma once
#include <string>
#include <vector>
#include "../../../include/ir/module.hpp"
#include "../../Arm.hpp"
#include "./ArmOperand.hpp"


class ArmStruct::Module{
    public:
        Module(IR::Module&);       // IR -> MIR
        ~Module(); // 记得手动释放
        void AddFunction(Function*);
        void AddDataVar(Global*);
        void AddBssVar(Bss*);
        void AddEquDef(Global*);
        
        void Legalize(); // MIR -> close arm asm

        std::string& toString(); // MIR -> asm string

    private:
        std::string ModuleName;
        std::string include = "";   // 可能会结合调试使用
        std::string arch = ".arch armv7ve\n.fpu vfpv3-d16";
        
        std::string testSection = ".text\n";
        std::string InstSet = ".arm\n";
        std::vector<Function*> FunctionList;    // .globl func \n fun:  
        std::vector<Global*> dataSection; // .data 注意使用 .align(可能直接被优化掉)
        std::vector<Bss*> bssSection; // .bss 注意使用 .align .zero 1234
        std::vector<Global*> equSection; // .equ PI 3.14 \n ldr r0, =PI
        // std::vector<std::unique_ptr<Global>> globalSection; // .global cnt\n cnt: .word 1234

        ///@note bss data 等使用ldr或者str等操作的对象都是对应的label的地址
};