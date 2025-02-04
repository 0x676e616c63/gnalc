#ifndef GNALC_MIR_FRAME_HPP
#define GNALC_MIR_FRAME_HPP
#include "../ir/global_var.hpp"
#include "base.hpp"
#include <list>
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
    size_t offset{}; // 相对与sp或者fp或者r7
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

class GlobalObj {
private:
    std::string name;

    size_t size;

    // <true, value> <false, size>
    std::list<std::pair<bool, std::variant<int, float, size_t>>> initializer;

public:
    GlobalObj();
    explicit GlobalObj(IR::GlobalVariable &);

    void mkInitializer(const IR::GVIniter &);

    void initializerMerge(); // 合并相邻的零散的0

    std::string toString() const;
    ~GlobalObj() = default;
};

/// @note 上面两个Obj用于记录内存分配

using Encoding = std::pair<uint16_t, uint16_t>; // low-high

class ConstObj {
private:
    unsigned int id;

    std::variant<std::string, int, float, bool, char, Encoding> literal;

public:
    ConstObj() = delete;
    ConstObj(unsigned int _id, std::string _glo)
        : id(_id), literal(std::move(_glo)) {}
    explicit ConstObj(unsigned int _id, float imme);
    explicit ConstObj(unsigned int _id, int imme);
    explicit ConstObj(unsigned int _id, bool imme);
    explicit ConstObj(unsigned int _id, char imme);

    bool isGlo() const { return literal.index() == 0; }
    bool isImme() const { return literal.index() != 0; }
    bool isEncoded() const { return literal.index() == 5; }

    void setId(unsigned int _id) { id = _id; }
    unsigned int getId() const { return id; }

    std::string toString() const; // printf info
    ~ConstObj() = default;
};

}; // namespace MIR

#endif