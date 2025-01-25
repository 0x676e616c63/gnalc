// Creating a separate .hpp is to avoid potential circular inclusion between .hpp
#pragma once
#ifndef GNALC_MIRTOOLS_ENUM_NAME_HPP
#define GNALC_MIRTOOLS_ENUM_NAME_HPP

#include "../utils/exception.hpp"
#include "../mir/misc.hpp"
#include "../mir/operand.hpp"

#include <string>

namespace MIR {
template <typename T>
std::string enum_name(T t) = delete;

template <>
inline std::string enum_name<FrameTrait>(FrameTrait t) {
    switch (t) {
    case FrameTrait::Alloca:          return "Alloca";
    case FrameTrait::Spill:           return "Spill";
    case FrameTrait::Arg:             return "Arg";
    case FrameTrait::RetAddress:      return "RetAddress";
    case FrameTrait::LastFramePtr:    return "LastFramePtr";
    }
    Err::unreachable();
    return "unknown FrameTrait";
}

template <>
inline std::string enum_name<RegisterBank>(RegisterBank t) {
    switch (t) {
    case RegisterBank::gpr:          return "gpr";
    case RegisterBank::gprnopc:      return "gprnopc";
    case RegisterBank::spr:          return "spr";
    case RegisterBank::dpr:          return "dpr";
    }
    Err::unreachable();
    return "unknown RegisterBank";
}

template <>
inline std::string enum_name<ShiftOP::inlineShift>(ShiftOP::inlineShift t) {
    switch (t) {
    case ShiftOP::inlineShift::asr:          return "asr";
    case ShiftOP::inlineShift::lsl:          return "lsl";
    case ShiftOP::inlineShift::lsr:          return "lsr";
    case ShiftOP::inlineShift::ror:          return "ror";
    case ShiftOP::inlineShift::rrx:          return "rrx";
    }
    Err::unreachable();
    return "unknown inlineShift";
}

template <>
inline std::string enum_name<CoreRegister>(CoreRegister t) {
    switch (t) {
    // case CoreRegister::none:          return "none";
    case CoreRegister::r0:          return "r0";
    case CoreRegister::r1:          return "r1";
    case CoreRegister::r2:          return "r2";
    case CoreRegister::r3:          return "r3";
    case CoreRegister::r4:          return "r4";
    case CoreRegister::r5:          return "r5";
    case CoreRegister::r6:          return "r6";
    case CoreRegister::r7:          return "r7";
    case CoreRegister::r8:          return "r8";
    case CoreRegister::r9:          return "r9";
    case CoreRegister::r10:         return "r10";
    case CoreRegister::r11:         return "r11";
    // case CoreRegister::r12:          return "r12";
    // case CoreRegister::r13:          return "r13";
    // case CoreRegister::r14:          return "r14";
    // case CoreRegister::r15:          return "r15";
    case CoreRegister::ip:          return "ip";
    case CoreRegister::sp:          return "sp";
    case CoreRegister::lr:          return "lr";
    case CoreRegister::pc:          return "pc";
    default: Err::unreachable();
    }
    Err::unreachable();
    return "unknown CoreRegister";
}

template <>
inline std::string enum_name<FPURegister>(FPURegister t) {
    switch (t) {
        // case FPURegister::none:          return "none";
    case FPURegister::s0:          return "s0";
    case FPURegister::s1:          return "s1";
    case FPURegister::s2:          return "s2";
    case FPURegister::s3:          return "s3";
    case FPURegister::s4:          return "s4";
    case FPURegister::s5:          return "s5";
    case FPURegister::s6:          return "s6";
    case FPURegister::s7:          return "s7";
    case FPURegister::s8:          return "s8";
    case FPURegister::s9:          return "s9";
    case FPURegister::s10:         return "s10";
    case FPURegister::s11:         return "s11";
    case FPURegister::s12:         return "s12";
    case FPURegister::s13:         return "s13";
    case FPURegister::s14:         return "s14";
    case FPURegister::s15:         return "s15";
    case FPURegister::s16:         return "s16";
    case FPURegister::s17:         return "s17";
    case FPURegister::s18:         return "s18";
    case FPURegister::s19:         return "s19";
    case FPURegister::s20:         return "s20";
    case FPURegister::s21:         return "s21";
    case FPURegister::s22:         return "s22";
    case FPURegister::s23:         return "s23";
    case FPURegister::s24:         return "s24";
    case FPURegister::s25:         return "s25";
    case FPURegister::s26:         return "s26";
    case FPURegister::s27:         return "s27";
    case FPURegister::s28:         return "s28";
    case FPURegister::s29:         return "s29";
    case FPURegister::s30:         return "s30";
    case FPURegister::s31:         return "s31";
    default: Err::unreachable();
    }
    Err::unreachable();
    return "unknown FPURegister";
}
}

#endif