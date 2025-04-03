#include "mir/misc.hpp"
#include "ir/constant.hpp"
#include "mirtools/enum_name.hpp"
#include "mirtools/tool.hpp"
#include <iomanip>
#include <sstream>

using namespace MIR;

FrameObj::FrameObj(FrameTrait _ftrait, size_t _size) : ftrait(_ftrait), size(_size) {}
FrameObj::FrameObj(FrameTrait _ftrait, size_t _size, unsigned _seq) : ftrait(_ftrait), size(_size), seq(_seq) {}

void FrameObj::setOffset(int _offset) { offset = _offset; }
int FrameObj::getOffset() const { return offset; }

FrameTrait FrameObj::getTrait() { return ftrait; }

void FrameObj::setId(unsigned int _id) { id = _id; }
unsigned int FrameObj::getId() const { return id; }

size_t FrameObj::getSize() const { return size; }

void FrameObj::setAliagnment(unsigned _aliagnment) { aliagnment = _aliagnment; }
unsigned FrameObj::getAliagnment() { return aliagnment; }

unsigned FrameObj::getSeq() { return seq; }

std::string FrameObj::toString() const {
    std::string str;
    str += "- {";

    str += " id: " + std::to_string(id);
    str += ", size = " + std::to_string(size) + " B";
    str += ", local-offset = " + std::to_string(offset);
    str += ", type = " + enum_name(ftrait);

    str += "}";
    return str;
}

std::string GlobalObj::toString() const {
    std::string str;
    variant_const_toString visitor;

    str += "- {";

    str += " name: " + name;
    str += ", size = " + std::to_string(size);

    str += ", initial: [";
    for (const auto &init : initializer) {
        if (init.first) {
            str += std::visit(visitor, init.second);
        } else {
            str += "NullByte x " + std::visit(visitor, init.second);
        }
        str += ", ";
    }
    str = str.substr(0, str.length() - 2); // delete last ", "
    str += "] }";

    return str;
}

GlobalObj::GlobalObj(const IR::GlobalVariable &midEnd_Glo) {
    name = midEnd_Glo.getName();
    size = midEnd_Glo.getIniter().getIniterType()->getBytes();
    mkInitializer(midEnd_Glo.getIniter());
    initializerMerge();
}

void GlobalObj::mkInitializer(const IR::GVIniter &midEnd_GVIniter) {
    ///@brief flat midEnd GVIniter

    if (!midEnd_GVIniter.isArray()) {
        if (midEnd_GVIniter.isZero())
            initializer.emplace_back(false, 4); // sizeof(int) or sizeof(float)
        else {
            // IR's Global Variable must be ConstantInt or ConstantFloat
            if (auto ci32 = std::dynamic_pointer_cast<IR::ConstantInt>(midEnd_GVIniter.getConstVal())) {
                initializer.emplace_back(true, ci32->getVal());
            } else if (auto cf = std::dynamic_pointer_cast<IR::ConstantFloat>(midEnd_GVIniter.getConstVal())) {
                initializer.emplace_back(true, cf->getVal());
            } else
                Err::unreachable("Invalid GlobalVariable's initializer");
        }
    }
    /// Array
    else {
        if (midEnd_GVIniter.isZero()) {

            auto &midEnd_type = midEnd_GVIniter.getIniterType();
            initializer.emplace_back(false, midEnd_type->getBytes());

        } else {
            const auto &midEnd_inner_initer = midEnd_GVIniter.getInnerIniter();

            for (const auto &initer : midEnd_inner_initer) {
                mkInitializer(initer);
            }
        }
    }
}

void GlobalObj::initializerMerge() {
    for (auto it = initializer.begin(); it != initializer.end();) {
        if (it->first) // true
            ++it;
        else { // false
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

void GlobalObj::setAlignment(unsigned _alignment) { alignment = _alignment; };

std::string GlobalObj::getName() const { return name; }

unsigned GlobalObj::getAlignment() const { return alignment; }

const std::list<std::pair<bool, std::variant<int, float, size_t>>> &GlobalObj::getInitializer() const {
    return initializer;
}

ConstObj::ConstObj(unsigned int _id, std::string _glo) : id(_id), literal(std::move(_glo)) {}

ConstObj::ConstObj(unsigned int _id, int imme) : id(_id) {
    auto imm = static_cast<unsigned int>(imme);
    if (imme <= -1 && imme >= -257) {
        literal = imme;
    } else if (isImmCanBeEncodedInText(imm)) {
        literal = imme;
    } else {
        ///@brief turn into movw/movt
        uint16_t lowbits = imm & 0xffff;
        uint16_t highbits = imm >> 16;
        literal = Encoding(lowbits, highbits);
    }
}

ConstObj::ConstObj(unsigned int _id, float imme) : id(_id) {
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

ConstObj::ConstObj(unsigned int _id, bool imme) : id(_id), literal(imme) {}
ConstObj::ConstObj(unsigned int _id, char imme) : id(_id), literal(imme) {}

bool ConstObj::isGlo() const { return literal.index() == 0; }
bool ConstObj::isImme() const { return literal.index() != 0; }
bool ConstObj::isEncoded() const { return literal.index() == 5; }
bool ConstObj::isFloat() const { return literal.index() == 2; }

void ConstObj::setId(unsigned int _id) { id = _id; }
unsigned int ConstObj::getId() const { return id; }

unsigned int ConstObj::getType() { return literal.index(); }
// std::string getStr();

bool ConstObj::operator==(const ConstObj &other) const { return other.literal == literal; }

// auto ConstObj::getLiteral() const { return literal; }

std::string ConstObj::toString() const {
    std::string str;
    str += "- {";

    str += " id: " + std::to_string(id);

    str += ", literal = ";
    if (isGlo()) {

        str += "'" + std::get<std::string>(literal) + "'";
        str += ", type = DataSectionAddr";

    } else if (literal.index() == 1) {
        str += "'" + std::to_string(std::get<int>(literal)) + "'";
        str += ", type = int32";
    } else if (literal.index() == 2) {

        str += "'" + std::to_string(std::get<float>(literal)) + "'";
        str += ", type = float32";

    } else if (literal.index() == 3) {

        str += "'" + std::to_string(std::get<bool>(literal)) + "'";
        str += ", type = boolen";

    } else if (literal.index() == 4) {

        str += "'" + std::to_string(std::get<char>(literal)) + "'";
        str += ", type = int8";
    } else if (literal.index() == 5) {
        // hex
        std::ostringstream hex_ss;
        uint16_t low = std::get<Encoding>(literal).first;
        uint16_t high = std::get<Encoding>(literal).second;

        hex_ss << "0x";
        if (high)
            hex_ss << std::hex << high;
        hex_ss << std::hex << low;

        str += "'" + hex_ss.str() + "'";
        str += ". type = int32";
    }

    str += ", isEncInText = ";
    if (isEncoded() || isGlo())
        str += "true";
    else
        str += "false";

    str += " }";

    return str;
}
