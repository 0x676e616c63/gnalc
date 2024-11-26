#ifndef ARM
#define ARM
#pragma once
#include <iostream>
#include <vector>

namespace ArmStruct{
    class Module;       // 修改自中端传来的Module
    class Function;     // 各个Func的信息，包括指令链，开栈，需要维护冲突图
    class SubFrame;
    class FrameObj;
    class BB;
    class Instruction;   // 指令选择
    class Operand;      // 操作数，较长立即量的插入
    class Imm;
    class Global;       // 全局变量
    ///@note MIR 子类
    class CallInst;
    class GetElementPtrInst;
    class PhiInst;
    class BrInst;
};

namespace ArmTools{
    class MyUnOrderedSet;

    class Edge;
    struct HashEdge;
    struct EdgeEdgeEqual;

    struct HashOperandReferWrap;
    struct HashOperandReferWrapEqual;
    struct HashInstReferWrap;
    struct HashInstReferWrapEqual;

    class LabelTable; // 用于查找标签
    bool isImmCanBeEncodedInText(int Imm);
    bool isImmCanBeEncodedInText(float Imm);
    bool isVLoadStoreOffsetLegal(int offset);
    class RegisterAlloc;    // 寄存器分配
    class LowerMIR2ASM;       // 打印
    class LowerIR2MIR;    // 生成instruction
};

namespace ArmOpt{
    class SIMDInstructions; // Noen指令集优化
    class PeepHole;         // 窥孔优化
};

#endif