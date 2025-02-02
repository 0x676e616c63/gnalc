#include "../../include/mir/misc.hpp"
#include "../../include/ir/constant.hpp"
#include "../../include/mirtools/enum_name.hpp"
#include "../../include/mirtools/tool.hpp"
#include <cctype>
#include <iomanip>

std::string MIR::FrameObj::toString() const {
    std::string str;
    str += "- {";

    str += " id: " + std::to_string(id);
    str += ", size = " + std::to_string(size);
    str += ", local-offset = " + std::to_string(offset);
    str += ", type = " + enum_name(ftrait);

    str += "}";
    return str;
}

std::string MIR::GlobalObj::toString() const {
    std::string str;
    variant_toString visitor;

    str += "- {";

    str += " name: " + name;
    str += ", size = " + std::to_string(size);

    str += ", initial: [ ";
    for (auto &init : initializer) {
        if (init.first) {
            str += std::visit(visitor, init.second);
        } else {
            str += "0x" + std::visit(visitor, init.second);
        }
        str += ", ";
    }

    str += "] }";

    return str;
}

MIR::GlobalObj::GlobalObj(IR::GlobalVariable &midEnd_Glo) {
    name = midEnd_Glo.getName();
    mkInitializer(midEnd_Glo.getIniter());
    initializerMerge();
}

void MIR::GlobalObj::mkInitializer(const IR::GVIniter &midEnd_GVIniter) {
    ///@brief flat midEnd GVIniter

    if (midEnd_GVIniter.isArray()) {
        if (midEnd_GVIniter.isZero())
            initializer.emplace_back(false, 1);
        else {
            if (auto ci1 = std::dynamic_pointer_cast<IR::ConstantI1>(
                    midEnd_GVIniter.getConstVal())) {
                size += 1;
                initializer.emplace_back(true, ci1->getVal());
            } else if (auto ci8 = std::dynamic_pointer_cast<IR::ConstantI8>(
                           midEnd_GVIniter.getConstVal())) {
                size += 1;
                initializer.emplace_back(true, ci8->getVal());
            } else if (auto ci32 = std::dynamic_pointer_cast<IR::ConstantInt>(
                           midEnd_GVIniter.getConstVal())) {
                size += 4;
                initializer.emplace_back(true, ci32->getVal());
            } else if (auto cf = std::dynamic_pointer_cast<IR::ConstantFloat>(
                           midEnd_GVIniter.getConstVal())) {
                size += 4;
                initializer.emplace_back(true, cf->getVal());
            } else {
                // UNDIFINE
            }
        }
    }
    /// Array
    else {
        if (midEnd_GVIniter.isZero()) {

            auto &midEnd_type = midEnd_GVIniter.getIniterType();
            initializer.emplace_back(false, midEnd_type->getBytes());

        } else {
            auto &midEnd_inner_initer = midEnd_GVIniter.getInnerIniter();

            for (auto &initer : midEnd_inner_initer) {
                mkInitializer(initer);
            }
        }
    }
}

void MIR::GlobalObj::initializerMerge() {
    for (auto it = initializer.begin(); it != initializer.end();) {
        if (!it->first)
            ++it;
        else {
            auto next_it = std::next(it);
            if (next_it == initializer.end())
                break;

            if (next_it->first)
                ++it;
            else {
                // it为0, next_it也为0
                auto &ref = std::get<size_t>(it->second);
                ref += std::get<size_t>(next_it->second); // merge size

                initializer.erase(next_it); // del next_it, it remain
            }
        }
    }
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
