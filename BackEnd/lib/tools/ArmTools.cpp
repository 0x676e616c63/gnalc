#include <assert.h>
#include <string>
#include <cmath>
#include "../../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../include/tools/ArmTools.hpp"
#include "Arm.hpp"

namespace ArmTools{

bool ArmTools::isVLoadStoreOffsetLegal(int offset){
    //  适用于一个单位量四字节的向量运算
    if(!(offset % 4) && offset >= 0 && offset < 1024 ) return true;
}

///@note hashes

size_t HashEdge::operator()(const Edge& edge) const {
    return std::hash<int>()(edge.u.VirReg ^ edge.v.VirReg);
};

bool HashEdgeEqual::operator()(const ArmTools::Edge& a, const ArmTools::Edge& b) const {
    return (a.u == b.u && a.v == b.v) || (a.u == b.v && a.v == b.u);
}

size_t HashOperandReferWrap::operator()(const std::reference_wrapper<ArmStruct::Operand>& ref) const {
    return std::hash<int>()(ref.get().VirReg);
}

bool HashOperandReferWrapEqual::operator()(const std::reference_wrapper<ArmStruct::Operand>& a, const std::reference_wrapper<ArmStruct::Operand>& b) const {
    return a.get().VirReg == b.get().VirReg;
}

size_t HashInstReferWrap::operator()(const std::reference_wrapper<ArmStruct::Instruction>& ref) const {
    return std::hash<int>()(ref.get().id);
}

bool HashInstReferWrapEqual::operator()(const std::reference_wrapper<ArmStruct::Instruction>& a, const std::reference_wrapper<ArmStruct::Instruction>& b) const {
    return a.get().id == b.get().id;
}

size_t HashFrameObj::operator()(const std::reference_wrapper<ArmStruct::FrameObj>& ref) const {
    return std::hash<int>()(ref.get().offset);
}

bool HashFrameObjEqual::operator()(const std::reference_wrapper<ArmStruct::FrameObj>& a, const std::reference_wrapper<ArmStruct::FrameObj>& b) const {
    return a.get().offset == b.get().offset;
}

};