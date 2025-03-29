#pragma once
#ifndef GNALC_MIR_FRAME_HPP
#define GNALC_MIR_FRAME_HPP
#include "../ir/global_var.hpp"
#include "base.hpp"
#include <list>
#include <sstream>
#include <variant>

namespace MIR {

enum class FrameTrait {
    Alloca,       // %1 = alloca ...
    Spill,        // spill by RA
    Arg,          // Args when call a function
    FixStack,     // Args pass by caller
    CalleeSaved,  //
    LastFramePtr, // like *$rbp, maybe not in use
    Padding,      // maybe in use
};

class FrameObj {
private:
    unsigned int id{};

    size_t size;
    long long offset{}; // 相对与sp或者fp或者r7
    FrameTrait ftrait;
    unsigned int aliagnment = 4; // 4, 8, 16
    unsigned seq = -1;           // sequence of the arg on stack

public:
    FrameObj() = delete;
    FrameObj(FrameTrait _ftrait, size_t _size) : ftrait(_ftrait), size(_size) {}
    FrameObj(FrameTrait _ftrait, size_t _size, unsigned _seq) : ftrait(_ftrait), size(_size), seq(_seq) {}

    void setOffset(size_t _offset) { offset = _offset; }
    size_t getOffset() const { return offset; }

    FrameTrait getTrait() { return ftrait; }

    void setId(unsigned int _id) { id = _id; }
    unsigned int getId() const { return id; }

    size_t getSize() const { return size; }

    void setAliagnment(unsigned _aliagnment) { aliagnment = _aliagnment; }
    unsigned getAliagnment() { return aliagnment; }

    unsigned getSeq() { return seq; }

    std::string toString() const; // printf info
    ~FrameObj() = default;
};

class GlobalObj {
private:
    std::string name;

    size_t size;

    unsigned alignment = 4; // 4, 8, 16

    // <true, value> <false, size> (size_t reference to size)
    std::list<std::pair<bool, std::variant<int, float, size_t>>> initializer;

public:
    GlobalObj();
    explicit GlobalObj(const IR::GlobalVariable &);

    void mkInitializer(const IR::GVIniter &);

    void initializerMerge(); // 合并相邻的零散的0

    void setAlignment(unsigned _alignment) { alignment = _alignment; };

    std::string getName() const { return name; }

    unsigned getAlignment() const { return alignment; }

    const auto &getInitializer() const { return initializer; }

    std::string toString() const;
    ~GlobalObj() = default;
};

/// @note 上面两个Obj用于记录内存分配

using Encoding = std::pair<uint16_t, uint16_t>; // low-high

class ConstObj {
private:
    unsigned int id;

    /// @brief std::string代表常量地址, 仅在mov中出现
    ///@note float 需要转化为科学计数法
    std::variant<std::string, int, float, bool, char, Encoding> literal;

public:
    ConstObj() = delete;
    ConstObj(unsigned int _id, std::string _glo) : id(_id), literal(std::move(_glo)) {}
    explicit ConstObj(unsigned int _id, float imme);
    explicit ConstObj(unsigned int _id, int imme);
    explicit ConstObj(unsigned int _id, bool imme);
    explicit ConstObj(unsigned int _id, char imme);

    bool isGlo() const { return literal.index() == 0; }
    bool isImme() const { return literal.index() != 0; }
    bool isEncoded() const { return literal.index() == 5; }
    bool isFloat() const { return literal.index() == 2; }

    void setId(unsigned int _id) { id = _id; }
    unsigned int getId() const { return id; }

    unsigned int getType() { return literal.index(); }
    // std::string getStr();

    bool operator==(const ConstObj &other) const { return other.literal == literal; }

    auto getLiteral() const { return literal; }

    std::string toString() const; // printf info
    ~ConstObj() = default;
};

}; // namespace MIR

#endif