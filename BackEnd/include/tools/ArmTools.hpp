#pragma once
#include <map>
#include <list>

namespace ArmTools{
enum CoreRegisterName{
    vir,
    r0, r1, r2, r3, // 由调用者保存
    r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, // 由被调者恢复
    sp = r13,
    lr = r14,
    pc = r15
};
enum ExtensionRegisterName{
    Exvir,
    s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, // 调用者保存 
    s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31 // 被调者恢复
};
bool isImmCanBeEncodedInText(int imme);
bool isImmCanBeEncodedInText(float imme);
bool isVLoadStoreOffsetLegal(int offset);
};
