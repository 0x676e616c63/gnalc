#include "mirtools/tool.hpp"
#include "../../include/utils/logger.hpp"

namespace MIR {

std::string variant_const_toString::operator()(const int &val) const { return std::to_string(val); }

std::string variant_const_toString::operator()(const size_t &val) const { return std::to_string(val); }

std::string variant_const_toString::operator()(const float &val) const {
    float stage = val;
    return std::to_string(*reinterpret_cast<unsigned *>(&stage));
    // turn to encoding format
}

std::string variant_opcode_toString::operator()(const OpCode &opcode) const { return enum_name(opcode); }
std::string variant_opcode_toString::operator()(const NeonOpCode &opcode) const { return enum_name(opcode); }

std::string variant_reg_toString::operator()(CoreRegister emVal) { return enum_name(emVal); }

std::string variant_reg_toString::operator()(FPURegister emVal) { return enum_name(emVal); }

bool isImmCanBeEncodedInText(unsigned int imme) {
    if (imme < 256)
        return true; // 防止 >> 32 产生ud

    ///@note 感觉写麻烦了, 直接计算前导和后驱的0就行了
    unsigned ld = clz_wrapper(imme);
    unsigned tl = ctz_wrapper(imme);

    if (tl == 32 || ld + tl > 24 || ld + tl == 24 && tl % 2 == 0)
        return true;

    return false;
}

bool isImmCanBeEncodedInText(float imme) {
    float eps = 1e-14f;
    float a = imme * 128;
    for (int r = 0; r < 8; ++r) {
        for (int n = 16; n < 32; ++n) {
            if ((std::abs(((float)(n * (1 << (7 - r))) - a)) < eps) ||
                (std::abs(((float)(n * (1 << (7 - r))) + a)) < eps))
                return true;
        }
    }
    return false;
}

///@note 获取一个大于imme的最小8bits位图数
int ceilEncoded(int imme) {
    if (isImmCanBeEncodedInText((unsigned int)imme))
        return imme;

    int original = imme;

    while (true) {
        unsigned ld = clz_wrapper(imme);
        unsigned tl = ctz_wrapper(imme);

        Logger::logDebug("ceil to a neg number detected: " + std::to_string(original));

        Err::gassert(ld, "ceil to a neg number detected: " + std::to_string(original));

        ///@note ld 不会大于31, 在0时tl最大为32
        if (tl == 32 || ld + tl > 24 || ld + tl == 24 && tl % 2 == 0)
            break;

        imme += 1 << tl;
    }

    return imme;
}

} // namespace MIR