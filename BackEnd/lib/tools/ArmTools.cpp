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

bool ArmTools::isImmCanBeEncodedInText(unsigned long long imme){
    for (int shift = 0; shift <= 32; shift += 2){
        if ((((imme << shift) | (imme >> (32 - shift))) & ~0xff) == 0){
            return true;
        }
    }
        return false;
}

bool ArmTools::isImmCanBeEncodedInText(float imme){
    float eps = 1e-14f;
    float a = imme * 128;
    for (int r = 0; r < 8; ++r) {
        for (int n = 16; n < 32; ++n) {
            if ((abs((n * (1 << (7 - r)) - a)) < eps) ||
                    (abs((n * (1 << (7 - r)) + a)) < eps))
                return true;
        }
    }
    return false;
}

std::string DecToHex(int dec){

}

std::string HexToDec(std::string hex){


}

std::string LiteralToIEEE(float lit){

}


std::pair<std::string, std::string> ArmTools::BreakInBit(float imme){ 
    ///@brief say my name! 
    std::string highBits;
    std::string lowBits;
    if(isImmCanBeEncodedInText(imme)){
        // lowBits = std::;
        // return std::make_pair<std::string, std::string>(highBits, );
    }
}

std::pair<std::string, std::string> ArmTools::BreakInBit(int imme){
    std::string highBits;
    std::string lowBits;

    
    if(isImmCanBeEncodedInText((unsigned long long)imme)){

    }
}

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