#include "../include/mir/misc.hpp"
#include "../include/mirtools/magic_enum.hpp"
#include <cctype>
#include <iomanip>

std::string MIR::FrameObj::toString() {
    std::string str;
    str += "- {";

    str += " id: " + std::to_string(id);
    str += ", size = " + std::to_string(size);
    str += ", local-offset = " + std::to_string(offset);
    str +=
        ", type = " + static_cast<std::string>(magic_enum::enum_name(ftrait));

    str += "}";
    return str;
}

bool isImmCanBeEncodedInText(unsigned int imme) {
    ///@bug imme为size_t时语义不正确, 但不为size_t时godbolt.org clang-arm32
    ///-o2报错,
    /// 但是本地clang-x86 -o2没问题
    for (int shift = 0; shift <= 32; shift += 2) {
        if ((((imme << shift) | (imme >> (32 - shift))) & ~0xff) == 0) {
            return true;
        }
    }
    return false;
}

bool isImmCanBeEncodedInText(float imme) {
    float eps = 1e-14f;
    float a = imme * 128;
    for (int r = 0; r < 8; ++r) {
        for (int n = 16; n < 32; ++n) {
            if ((std::abs((n * (1 << (7 - r)) - a)) < eps) ||
                (std::abs((n * (1 << (7 - r)) + a)) < eps))
                return true;
        }
    }
    return false;
}

MIR::ConstObj::ConstObj(int imme) {
    unsigned int imm = (unsigned int)imme;
    if (isImmCanBeEncodedInText(imm)) {
        literal = imm;
    } else {
        ///@brief turn into movw/movt
        uint16_t lowbits = imm & 0xffff;
        uint16_t highbits = imm >> 16;
        literal = Encoding(lowbits, highbits);
    }
    size = 4;
}

MIR::ConstObj::ConstObj(float imme) {
    if (isImmCanBeEncodedInText(imme)) {
        std::ostringstream oss; // 为了和string字面量区分
        oss << std::scientific << imme;
        literal.emplace<std::ostringstream>(std::move(oss)); // ?
    } else {
        ///@brief turn into movw/movt
        unsigned int imm = *reinterpret_cast<unsigned int *>(&imme);
        uint16_t lowbits = imm & 0xffff;
        uint16_t highbits = imm >> 16;
        literal = Encoding(lowbits, highbits);
    }
    size = 4;
}

std::string MIR::ConstObj::toString() {
    std::string str;
    str += "- {";

    str += " id: " + std::to_string(id);

    str += ", literal = ";
    if (isGlo())
        str += "'" + std::get<std::string>(literal) + "'";
    else if (literal.index() == 1)
        str += "'" + std::to_string(std::get<unsigned int>(literal)) + "'";
    else if (literal.index() == 2)
        str += "'" + std::get<std::ostringstream>(literal).str() + "'";
    else
        str += "'" + std::to_string(std::get<Encoding>(literal).first) +
               std::to_string(std::get<Encoding>(literal).second) + "'";

    str += ", size = " + std::to_string(size);

    str += ", isEncInText = ";
    if (isGlo() || literal.index() == 3)
        str += "false";
    else
        str += "true";

    str += " }";

    return str;
}
