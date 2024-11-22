#ifndef ARM
#define ARM
#pragma once
#include <iostream>
#include <vector>

namespace ArmStruct{
    class Module;       // 修改自中端传来的Module
    class Function;     // 各个Func的信息，包括指令链，开栈，需要维护冲突图
    class BB;
    class Instruction;   // 指令选择
    class Operand;      // 操作数，较长立即量的插入
    class Global;       // 全局变量
};

namespace ArmTools{
    bool isImmCanBeEncodedInText(int Imm);
    bool isImmCanBeEncodedInText(float Imm);
    bool isVLoadStoreOffsetLegal(int offset);
    class RegisterAlloc;    // 寄存器分配
    class LiveInfo;         // 活跃信息
    class PhiEliminate;     // phi函数消除
    class MInstructionSelector; // 指令选择
    class AsmPrinter;       // 打印 ?
    class MyUnOrderedSet;
    class Edge;
    struct EdgeEqual;
};

namespace ArmOpt{
    class SIMDInstructions; // Noen指令集优化
    class PeepHole;         // 窥孔优化
};
#endif