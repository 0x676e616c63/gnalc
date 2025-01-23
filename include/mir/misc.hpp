#ifndef GNALC_MIR_FRAME_HPP
#define GNALC_MIR_FRAME_HPP
#include "base.hpp"
#include <sstream>
#include <variant>

namespace MIR {

enum class FrameTrait {
    Alloca,
    Spill,
    Arg,
    RetAddress,
    LastFramePtr,
};

class FrameObj {
private:
    unsigned int id{};

    size_t size;
    size_t offset{};
    FrameTrait ftrait;

public:
    FrameObj() = delete;
    FrameObj(FrameTrait _ftrait, size_t _size) : ftrait(_ftrait), size(_size) {}

    void setOffset(size_t _offset) { offset = _offset; }
    size_t getOffset() const { return offset; }

    void setId(unsigned int _id) { id = _id; }
    unsigned int getId() const { return id; }

    std::string toString() const; // printf info
    ~FrameObj() = default;
};

using Encoding = std::pair<uint16_t, uint16_t>; // low-high

class ConstObj {
private:
    unsigned int id{};

    std::variant<std::string, unsigned int, std::ostringstream, Encoding>
        literal;
    unsigned int size;

public:
    ConstObj() = delete;
    ConstObj(std::string _glo, unsigned int _size)
        : literal(std::move(_glo)), size(_size) {}
    explicit ConstObj(float imme);
    explicit ConstObj(int imme);

    bool isGlo() const { return literal.index() == 0; }
    bool isImme() const { return literal.index() != 0; }

    void setId(unsigned int _id) { id = _id; }
    unsigned int getId() const { return id; }

    std::string toString() const; // printf info
    ~ConstObj() = default;
};

}; // namespace MIR

#endif