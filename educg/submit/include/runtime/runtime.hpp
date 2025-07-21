// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_RUNTIME_RUNTIME_HPP
#define GNALC_RUNTIME_RUNTIME_HPP

#include "../utils/exception.hpp"

#include <string_view>

#define GNALC_RUNTIME_TABLE                                                                                            \
    GNALC_RUNTIME_TABLE_ENTRY(thread_ll, gnalc_thread_runtime_ll)                                                      \
    GNALC_RUNTIME_TABLE_ENTRY(thread_armv8_s, gnalc_thread_runtime_armv8_s)

#define MAKE_RUNTIME_DECL(name, xxd_name)                                                                              \
    extern unsigned char(xxd_name)[];                                                                                  \
    extern unsigned int xxd_name##_len;                                                                                \
    namespace Runtime::Artifacts {                                                                                     \
    extern std::string_view name;                                                                                      \
    }

#define GNALC_RUNTIME_TABLE_ENTRY(name, xxd_name) MAKE_RUNTIME_DECL(name, xxd_name)
GNALC_RUNTIME_TABLE
#undef GNALC_RUNTIME_TABLE_ENTRY

namespace Runtime {
enum class RtType { Thread };

enum class RtTarget { LLVM, ARMv8, ARMv7, RISCV64, BrainFk, BrainFk3Tape };

constexpr std::string_view getRuntime(RtType type, RtTarget target) {
    switch (type) {
    case RtType::Thread:
        switch (target) {
        case RtTarget::LLVM:
            return Artifacts::thread_ll;
        case RtTarget::ARMv8:
            return Artifacts::thread_armv8_s;
        case RtTarget::ARMv7:
        case RtTarget::RISCV64:
        case RtTarget::BrainFk:
        case RtTarget::BrainFk3Tape:
            Err::not_implemented("No thread runtime for this target.");
            return "";
        }
        break;
    }
    return "";
}
} // namespace Runtime

#undef MAKE_RUNTIME_DECL
#endif
