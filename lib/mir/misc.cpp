#include "../../include/mir/misc.hpp"
#include "../../include/mirtools/magic_enum.hpp"
#include <cctype>
#include <iomanip>

std::string MIR::FrameObj::toString() const {
    std::string str;
    str += "- {";

    str += " id: " + std::to_string(id);
    str += ", size = " + std::to_string(size);
    str += ", local-offset = " + std::to_string(offset);
    str += ", type = " + std::string{magic_enum::enum_name(ftrait)};

    str += "}";
    return str;
}

bool isImmCanBeEncodedInText(unsigned int imme) {
    if (imme < 256)
        return true; // 防止 >> 32 产生ud

    for (int shift = 1; shift <= 32; shift += 2) {
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
            if ((std::abs(((float)(n * (1 << (7 - r))) - a)) < eps) ||
                (std::abs(((float)(n * (1 << (7 - r))) + a)) < eps))
                return true;
        }
    }
    return false;
}

MIR::ConstObj::ConstObj(unsigned int _id, int imme) : id(_id) {
    auto imm = static_cast<unsigned int>(imme);
    if (isImmCanBeEncodedInText(imm)) {
        literal = imm;
    } else {
        ///@brief turn into movw/movt
        uint16_t lowbits = imm & 0xffff;
        uint16_t highbits = imm >> 16;
        literal = Encoding(lowbits, highbits);
    }
}

MIR::ConstObj::ConstObj(unsigned int _id, float imme) : id(_id) {
    if (isImmCanBeEncodedInText(imme)) {
        literal = imme;
    } else {
        ///@brief turn into movw/movt
        unsigned int imm = *reinterpret_cast<unsigned int *>(&imme);
        uint16_t lowbits = imm & 0xffff;
        uint16_t highbits = imm >> 16;
        literal = Encoding(lowbits, highbits);
    }
}

std::string MIR::ConstObj::toString() const {
    std::string str;
    str += "- {";

    str += " id: " + std::to_string(id);

    str += ", literal = ";
    if (isGlo())
        str += "'" + std::get<std::string>(literal) + "'";
    else if (literal.index() == 1)
        str += "'" + std::to_string(std::get<unsigned int>(literal)) + "'";
    else if (literal.index() == 2)
        str += "'" + std::to_string(std::get<float>(literal)) + "'";
    else
        str += "'" + std::to_string(std::get<Encoding>(literal).first) +
               std::to_string(std::get<Encoding>(literal).second) + "'";

    str += ", isEncInText = ";
    if (isGlo() || literal.index() == 3)
        str += "false";
    else
        str += "true";

    str += " }";

    return str;
}
