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
    case FrameTrait::CalleeSaved:
        return "CalleeSaved";
    case FrameTrait::LastFramePtr:
        return "LastFramePtr";
    case FrameTrait::FixStack:
        return "FixStk";
    case FrameTrait::Padding:
        return "padding";
    }
    Err::unreachable();
    return "unknown FrameTrait";
}

template <> inline std::string enum_name<RegisterBank>(RegisterBank t) {
    switch (t) {
    case RegisterBank::gpr:
        return "gpr";
    case RegisterBank::spr:
        return "spr";
    case RegisterBank::dpr:
        return "dpr";
    case RegisterBank::qpr:
        return "qpr";
    }
    Err::unreachable();
    return "unknown RegisterBank";
}

template <> inline std::string enum_name<ShiftOP::inlineShift>(ShiftOP::inlineShift t) {
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
    // case CoreRegister::none: // maybe used in debug
    //     return "none";
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
        return "fp";
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
        return "EQ";
    case CondCodeFlag::ne:
        return "NE";
    case CondCodeFlag::mi:
        return "MI";
    case CondCodeFlag::pl:
        return "PL";
    case CondCodeFlag::lt:
        return "LT";
    case CondCodeFlag::gt:
        return "GT";
    case CondCodeFlag::le:
        return "LE";
    case CondCodeFlag::ge:
        return "GE";
    }
}

template <> inline std::string enum_name<OpCode>(OpCode t) {
    switch (t) {
    case OpCode::MOV:
        return "MOV";
    case OpCode::MVN:
        return "MVN";
    case OpCode::STR:
        return "STR";
    case OpCode::LDR:
        return "LDR";
    case OpCode::NEG:
        return "NEG";
    case OpCode::ADD:
        return "ADD";
    case OpCode::SUB:
        return "SUB";
    case OpCode::RSB:
        return "RSB";
    case OpCode::ORR:
        return "ORR";
    case OpCode::AND:
        return "AND";
    case OpCode::EOR:
        return "EOR";
    case OpCode::ORN:
        return "ORN";
    case OpCode::BIC:
        return "BIC";
    case OpCode::ASR:
        return "ASR";
    case OpCode::LSL:
        return "LSL";
    case OpCode::LSR:
        return "LSR";
    case OpCode::ROR:
        return "ROR";
    case OpCode::RRX:
        return "RRX";
    case OpCode::MUL:
        return "MUL";
    case OpCode::DIV:
        return "DIV";
    case OpCode::SDIV:
        return "SDIV";
    case OpCode::SMULL:
        return "SMULL";
    case OpCode::SMMUL:
        return "SMMUL";
    case OpCode::SMMLA:
        return "smmla";
    case OpCode::SMMLS:
        return "SMMLS";
    case OpCode::MLA:
        return "MLA";
    case OpCode::MLS:
        return "MLS";
    case OpCode::SWI:
        return "SWI";
    case OpCode::B:
        return "B";
    case OpCode::BX_RET:
        return "BX_RET";
    case OpCode::BX_SET_SWI:
        return "BX_SWITCH";
    case OpCode::BL:
        return "BL";
    case OpCode::BLX:
        return "BLX";
    case OpCode::CMP:
        return "CMP";
    case OpCode::CMN:
        return "CMN";
    case OpCode::TST:
        return "TST";
    case OpCode::TEQ:
        return "TEQ";
    case OpCode::COPY:
        return "COPY";
    case OpCode::PUSH:
        return "PUSH";
    case OpCode::POP:
        return "POP";
    case OpCode::VPUSH:
        return "VPUSH";
    case OpCode::VPOP:
        return "VPOP";
    case OpCode::RET:
        return "RET";
    case OpCode::PHI:
        return "You_are_not_supposed_to_see_this";
    }
    Err::unreachable();
    return "unknown OpCode";
}

template <> inline std::string enum_name<NeonOpCode>(NeonOpCode t) {
    switch (t) {
    case NeonOpCode::VMOV:
        return "VMOV";
    case NeonOpCode::VSTR:
        return "VSTR";
    case NeonOpCode::VLDR:
        return "VLDR";
    case NeonOpCode::VSTX:
        return "VSTX";
    case NeonOpCode::VLDX:
        return "VLDX";
    case NeonOpCode::VADD:
        return "VADD";
    case NeonOpCode::VSUB:
        return "VSUB";
    case NeonOpCode::VMUL:
        return "VMUL";
    case NeonOpCode::VDIV:
        return "VDIV";
    case NeonOpCode::VNEG:
        return "VNEG";
    case NeonOpCode::VADDV:
        return "VADDV";
    case NeonOpCode::VMAXV:
        return "VMAXV";
    case NeonOpCode::VMINV:
        return "VMINV";
    case NeonOpCode::VCMP:
        return "VCMP";
    case NeonOpCode::VCVT:
        return "VCVT";
    case NeonOpCode::VMRS:
        return "VMRS";
    }
    Err::unreachable();
    return "unknown NeonOperCode";
}

template <> inline std::string enum_name<bitType>(bitType t) {
    switch (t) {
    case bitType::DEFAULT32:
        return "32";
    case bitType::f32:
        return "f32";
    case bitType::s32:
        return "s32";
    }
}

template <> inline std::string enum_name<SourceOperandType>(SourceOperandType t) {
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

template <> inline std::string enum_name<std::pair<bitType, bitType>>(std::pair<bitType, bitType> t) {
    std::string str;

    if (t.first == bitType::DEFAULT32 && t.second == bitType::DEFAULT32) {
        str = ".32";
    } else if (t.first == bitType::f32 && t.second == bitType::DEFAULT32) {
        str = ".f32";
    } else if (t.first == bitType::s32 && t.second == bitType::f32) {
        str = ".s32.f32";
    } else if (t.first == bitType::f32 && t.second == bitType::s32) {
        str = ".f32.s32";
    } else {
        Err::todo("NeonInstruction::bitTage: unknown bitwides");
    }

    return str;
}

} // namespace MIR

#endif