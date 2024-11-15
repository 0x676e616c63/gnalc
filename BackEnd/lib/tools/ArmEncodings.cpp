#include <assert.h>
#include <string>
#include "../../Arm.hpp"
#include "../../include/tools/ArmTools.hpp"

bool ArmTools::isImmCanBeEncodedInText(int imme){
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
bool ArmTools::isVLoadStoreOffsetLegal(int offset){
    //  适用于一个单位量四字节的向量运算
    if(!(offset % 4) && offset >= 0 && offset < 1024 ) return true;
}
/// @brief 寄存器分配算法使用填色图算法