#ifndef ARMTOOLS
#define ARMTOOLS
#pragma once
#include <map>
#include <list>
#include "../Arm.hpp"

namespace ArmTools{
class Edge{
    public:
        Edge(ArmStruct::Operand& u, ArmStruct::Operand& v):u(u), v(v){};
        ~Edge()=default;
        ArmStruct::Operand& u;
        ArmStruct::Operand& v;
};

/// @brief unordered_map/set 的hash和equal方法

struct HashEdge{
    size_t operator()(const Edge& edge) const;
};
struct HashEdgeEqual{
    bool operator()(const ArmTools::Edge& a, const ArmTools::Edge& b) const;
};
struct HashOperandReferWrap{
    size_t operator()(const std::reference_wrapper<ArmStruct::Operand>& ref) const;
};
struct HashOperandReferWrapEqual{
    bool operator()(const std::reference_wrapper<ArmStruct::Operand>& a, const std::reference_wrapper<ArmStruct::Operand>& b) const ;
};
struct HashInstReferWrap{
    size_t operator()(const std::reference_wrapper<ArmStruct::Instruction>& ref) const;
};
struct HashInstReferWrapEqual{
    bool operator()(const std::reference_wrapper<ArmStruct::Instruction>& a, const std::reference_wrapper<ArmStruct::Instruction>& b) const; 
};
struct HashFrameObj{
    size_t operator()(const std::reference_wrapper<ArmStruct::FrameObj>& ref) const;
};
struct HashFrameObjEqual{
    bool operator()(const std::reference_wrapper<ArmStruct::FrameObj>& a, const std::reference_wrapper<ArmStruct::FrameObj>& b) const;
};


enum CoreRegisterName{
    vir = -1,
    r0, r1, r2, r3, // 由调用者保存
    r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, // 由被调者恢复
    ip = r12,
    sp = r13,
    lr = r14,
    pc = r15
};
extern std::map<CoreRegisterName, std::string> CoreRegisterMap;

enum ExtensionRegisterName{
    Exvir = -1,
    s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, // 调用者保存 
    s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31 // 被调者恢复
};
extern std::map<ExtensionRegisterName, std::string> ExtensionRegisterMap;

extern std::map<OperCode, std::string> OperCodeMap;

};
#endif