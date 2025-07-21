// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_FRAME_HPP
#define GNALC_LEGACY_MIR_FRAME_HPP
#include "base.hpp"
#include "../ir/global_var.hpp"
#include <list>
#include <variant>

namespace LegacyMIR {

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
    int offset; // 相对与sp或者fp或者r7
    FrameTrait ftrait;
    unsigned int aliagnment = 4; // 4, 8, 16
    unsigned seq = -1;           // sequence of the arg on stack

public:
    FrameObj() = delete;
    FrameObj(FrameTrait _ftrait, size_t _size);
    FrameObj(FrameTrait _ftrait, size_t _size, unsigned _seq);

    void setOffset(int _offset);
    int getOffset() const;

    FrameTrait getTrait();

    void setId(unsigned int _id);
    unsigned int getId() const;

    size_t getSize() const;

    void setAliagnment(unsigned _aliagnment);
    unsigned getAliagnment();

    unsigned getSeq();

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
    GlobalObj() = delete;
    explicit GlobalObj(const IR::GlobalVariable &);

    void mkInitializer(const IR::GVIniter &);

    void initializerMerge(); // 合并相邻的零散的0

    void setAlignment(unsigned _alignment);

    std::string getName() const;

    unsigned getAlignment() const;

    const std::list<std::pair<bool, std::variant<int, float, size_t>>> &getInitializer() const;

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
    std::variant<std::string, int, float> original;

public:
    ConstObj() = delete;
    ConstObj(unsigned int _id, std::string _glo);
    explicit ConstObj(unsigned int _id, float imme);
    explicit ConstObj(unsigned int _id, int imme);
    explicit ConstObj(unsigned int _id, bool imme);
    explicit ConstObj(unsigned int _id, char imme);

    bool isGlo() const;
    bool isImme() const;
    bool isEncoded() const;
    bool isFloat() const;

    void setId(unsigned int _id);
    unsigned int getId() const;

    unsigned int getType();
    // std::string getStr();

    bool operator==(const ConstObj &other) const;

    auto getLiteral() const { return literal; }
    auto getOriginal() const { return original; }

    std::string toString() const; // printf info
    ~ConstObj() = default;
};

}; // namespace MIR

#endif
#endif