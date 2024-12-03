#ifndef ARM
#define ARM
#pragma once
#include <iostream>
#include <vector>
#include <map>

namespace ArmStruct{
    class Module;       // 修改自中端传来的Module
    
    class Function;     // 各个Func的信息，包括指令链，开栈，需要维护冲突图
    class SubFrame;
    class FrameObj;
    
    class BB;
    class Terminator; // dddd
    std::map<std::string, BB&> BBLabelMap;

    class Instruction;   // 指令选择
    class MemInstruction; // load / store

    class Operand;      // 操作数，较长立即量的插入
    class Imm;
    class MMptr;
    class Global;       // 全局变量
    class Bss;

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

    /// @brief hash映射 + 比较方法
    struct HashOperandReferWrap;
    struct HashOperandReferWrapEqual;
    struct HashInstReferWrap;
    struct HashInstReferWrapEqual;
    struct HashFrameObj;
    struct HashFrameObjEqual;

    class LabelTable; // 用于查找标签
    bool isImmCanBeEncodedInText(int Imm);
    bool isImmCanBeEncodedInText(float Imm);
    bool isVLoadStoreOffsetLegal(int offset);
    class RegisterAlloc;    // 寄存器分配
    class LowerMIR2ASM;       // 打印
    class LowerIR2MIR;    // 生成instruction
    ///@warning ISO C++ forbids forward references to 'enum' types
    // enum CoreRegisterName;
    // std::map<CoreRegisterName, std::string> CoreRegisterMap;
    // enum ExtensionRegisterName;
    // std::map<ExtensionRegisterName, std::string> ExtensionRegisterMap;
    // enum OpCode;
    // std::map<OpCode, std::string> OpCodeMap;
    
};

namespace ArmOpt{
    class SIMDInstructions; // Noen指令集优化
    class PeepHole;         // 窥孔优化
};

#endif