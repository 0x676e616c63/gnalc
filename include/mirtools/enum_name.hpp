// Creating a separate .hpp is to avoid potential circular inclusion between
// .hpp
#pragma once
#ifndef GNALC_MIRTOOLS_ENUM_NAME_HPP
#define GNALC_MIRTOOLS_ENUM_NAME_HPP

#include "../mir/instruction.hpp"
#include "../mir/misc.hpp"
#include "../mir/operand.hpp"
#include "../utils/exception.hpp"

#include <string>

namespace MIR {
template <typename T> std::string enum_name(T t) = delete;

template <> inline std::string enum_name<FrameTrait>(FrameTrait t) {
    switch (t) {
    case FrameTrait::Alloca:
        return "Alloca";
    case FrameTrait::Spill:
        return "Spill";
    case FrameTrait::Arg:
        return "Arg";
    case FrameTrait::RetAddress:
        return "RetAddress";
    case FrameTrait::LastFramePtr:
        return "LastFramePtr";
    }
    Err::unreachable();
    return "unknown FrameTrait";
}

template <> inline std::string enum_name<RegisterBank>(RegisterBank t) {
    switch (t) {
    case RegisterBank::gpr:
        return "gpr";
    case RegisterBank::gprnopc:
        return "gprnopc";
    case RegisterBank::spr:
        return "spr";
    case RegisterBank::dpr:
        return "dpr";
    }
    Err::unreachable();
    return "unknown RegisterBank";
}

template <>
inline std::string enum_name<ShiftOP::inlineShift>(ShiftOP::inlineShift t) {
    switch (t) {
    case ShiftOP::inlineShift::asr:
        return "asr";
    case ShiftOP::inlineShift::lsl:
        return "lsl";
    case ShiftOP::inlineShift::lsr:
        return "lsr";
    case ShiftOP::inlineShift::ror:
        return "ror";
    case ShiftOP::inlineShift::rrx:
        return "rrx";
    }
    Err::unreachable();
    return "unknown inlineShift";
}

template <> inline std::string enum_name<CoreRegister>(CoreRegister t) {
    switch (t) {
    // case CoreRegister::none:          return "none";
    case CoreRegister::r0:
        return "r0";
    case CoreRegister::r1:
        return "r1";
    case CoreRegister::r2:
        return "r2";
    case CoreRegister::r3:
        return "r3";
    case CoreRegister::r4:
        return "r4";
    case CoreRegister::r5:
        return "r5";
    case CoreRegister::r6:
        return "r6";
    case CoreRegister::r7:
        return "r7";
    case CoreRegister::r8:
        return "r8";
    case CoreRegister::r9:
        return "r9";
    case CoreRegister::r10:
        return "r10";
    case CoreRegister::r11:
        return "r11";
    // case CoreRegister::r12:          return "r12";
    // case CoreRegister::r13:          return "r13";
    // case CoreRegister::r14:          return "r14";
    // case CoreRegister::r15:          return "r15";
    case CoreRegister::ip:
        return "ip";
    case CoreRegister::sp:
        return "sp";
    case CoreRegister::lr:
        return "lr";
    case CoreRegister::pc:
        return "pc";
    default:
        Err::unreachable();
    }
    Err::unreachable();
    return "unknown CoreRegister";
}

template <> inline std::string enum_name<FPURegister>(FPURegister t) {
    switch (t) {
        // case FPURegister::none:          return "none";
    case FPURegister::s0:
        return "s0";
    case FPURegister::s1:
        return "s1";
    case FPURegister::s2:
        return "s2";
    case FPURegister::s3:
        return "s3";
    case FPURegister::s4:
        return "s4";
    case FPURegister::s5:
        return "s5";
    case FPURegister::s6:
        return "s6";
    case FPURegister::s7:
        return "s7";
    case FPURegister::s8:
        return "s8";
    case FPURegister::s9:
        return "s9";
    case FPURegister::s10:
        return "s10";
    case FPURegister::s11:
        return "s11";
    case FPURegister::s12:
        return "s12";
    case FPURegister::s13:
        return "s13";
    case FPURegister::s14:
        return "s14";
    case FPURegister::s15:
        return "s15";
    case FPURegister::s16:
        return "s16";
    case FPURegister::s17:
        return "s17";
    case FPURegister::s18:
        return "s18";
    case FPURegister::s19:
        return "s19";
    case FPURegister::s20:
        return "s20";
    case FPURegister::s21:
        return "s21";
    case FPURegister::s22:
        return "s22";
    case FPURegister::s23:
        return "s23";
    case FPURegister::s24:
        return "s24";
    case FPURegister::s25:
        return "s25";
    case FPURegister::s26:
        return "s26";
    case FPURegister::s27:
        return "s27";
    case FPURegister::s28:
        return "s28";
    case FPURegister::s29:
        return "s29";
    case FPURegister::s30:
        return "s30";
    case FPURegister::s31:
        return "s31";
    default:
        Err::unreachable();
    }
    Err::unreachable();
    return "unknown FPURegister";
}

template <> inline std::string enum_name<CondCodeFlag>(CondCodeFlag t) {
    switch (t) {
    case CondCodeFlag::AL:
        return "";
    case CondCodeFlag::eq:
        return "eq";
    case CondCodeFlag::ne:
        return "ne";
    case CondCodeFlag::mi:
        return "mi";
    case CondCodeFlag::pl:
        return "pl";
    case CondCodeFlag::lt:
        return "lt";
    case CondCodeFlag::gt:
        return "gt";
    case CondCodeFlag::le:
        return "le"; // AL,
    case CondCodeFlag::ge:
        return "ge";
    }
}

template <> inline std::string enum_name<OpCode>(OpCode t) {
    switch (t) {
    case OpCode::MOV:
        return "mov";
    case OpCode::STR:
        return "str";
    case OpCode::LDR:
        return "ldr";
    case OpCode::NEG:
        return "neg";
    case OpCode::ADD:
        return "add";
    case OpCode::SUB:
        return "sub";
    case OpCode::RSB:
        return "rsb";
    case OpCode::ORR:
        return "orr";
    case OpCode::AND:
        return "and";
    case OpCode::EOR:
        return "eor";
    case OpCode::ORN:
        return "orn";
    case OpCode::BIC:
        return "bic";
    case OpCode::ASR:
        return "asr";
    case OpCode::LSL:
        return "lsl";
    case OpCode::LSR:
        return "lsr";
    case OpCode::ROR:
        return "ror";
    case OpCode::RRX:
        return "rrx";
    case OpCode::MUL:
        return "mul";
    case OpCode::MULS:
        return "muls";
    case OpCode::DIV:
        return "div";
    case OpCode::SDIV:
        return "sdiv";
    case OpCode::SMULL:
        return "smull";
    case OpCode::MLA:
        return "mla";
    case OpCode::MLS:
        return "mls";
    case OpCode::SWI:
        return "swi";
    case OpCode::B:
        return "b";
    case OpCode::BX_RET:
        return "bx_ret";
    case OpCode::BX_SET_SWI:
        return "bx_switch";
    case OpCode::BL:
        return "bl";
    case OpCode::BLX:
        return "blx";
    case OpCode::CMP:
        return "cmp";
    case OpCode::CMN:
        return "cmn";
    case OpCode::COPY:
        return "COPY";
    }
    Err::unreachable();
    return "unknown OpCode";
}

template <> inline std::string enum_name<NeonOpCode>(NeonOpCode t) {
    switch (t) {
    case NeonOpCode::VMOV:
        return "vmov";
    case NeonOpCode::VSTR:
        return "vstr";
    case NeonOpCode::VLDR:
        return "vldr";
    case NeonOpCode::VSTX:
        return "vstx";
    case NeonOpCode::VLDX:
        return "vldx";
    case NeonOpCode::VADD:
        return "vadd";
    case NeonOpCode::VSUB:
        return "vsub";
    case NeonOpCode::VMUL:
        return "vmul";
    case NeonOpCode::VDIV:
        return "vdiv";
    case NeonOpCode::VNEG:
        return "vneg";
    case NeonOpCode::VADDV:
        return "vaddv";
    case NeonOpCode::VMAXV:
        return "vmaxv";
    case NeonOpCode::VMINV:
        return "vminv";
    case NeonOpCode::VCMP:
        return "vcmp";
    case NeonOpCode::VSITOF:
        return "vcvt.s32.f32";
    case NeonOpCode::VFTOSI:
        return "vcvt.f32.s32";
    }
    Err::unreachable();
    return "unknown NeonOperCode";
}

template <>
inline std::string enum_name<SourceOperandType>(SourceOperandType t) {
    switch (t) {
    case SourceOperandType::a:
        return "a";
    case SourceOperandType::cp:
        return "cp";
    case SourceOperandType::r:
        return "r";
    case SourceOperandType::i:
        return "i";
    case SourceOperandType::i12:
        return "i12";
    case SourceOperandType::i16:
        return "i16";
    case SourceOperandType::i32:
        return "i32";
    case SourceOperandType::rr:
        return "rr";
    case SourceOperandType::rrr:
        return "rrr";
    case SourceOperandType::ri:
        return "ri";
    case SourceOperandType::rsi:
        return "rsi";
    case SourceOperandType::ra:
        return "ra";
    }
    Err::unreachable();
    return "unknown SourceOperandType";
}

} // namespace MIR

#endif