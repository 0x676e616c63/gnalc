#pragma once
#ifndef GNALC_CONFIG_CONFIG_HPP
#define GNALC_CONFIG_CONFIG_HPP

// Extension
#define GNALC_EXTENSION_BRAINFK 0

namespace Config::IR {
constexpr auto REGISTER_TEMP_NAME = "%%__GNALC_IR_TEMP_NAME";
constexpr auto BUILTIN_MEMSET = "llvm.memset.p0i8.i32";
constexpr auto LOCAL_ARRAY_MEMSET_THRESHOLD = 32;
} // namespace Config::IR

#endif