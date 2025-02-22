#pragma once
#ifndef GNALC_CONFIG_CONFIG_HPP
#define GNALC_CONFIG_CONFIG_HPP

// Extension
#define GNALC_EXTENSION_BRAINFK 0

namespace Config::IR {
// IRGenerator
constexpr auto REGISTER_TEMP_NAME = "%%__GNALC_IR_TEMP_NAME";
constexpr auto BUILTIN_MEMSET = "llvm.memset.p0i8.i32";
constexpr auto LOCAL_ARRAY_MEMSET_THRESHOLD = 32;

// VerifyPass
constexpr auto ABORT_WHEN_VERIFY_FAILED = false;

// GVN-PRE
// Some operations in GVN-PRE are time-consuming,
// so we set some thresholds to ensure acceptable compilation times.
// Maximum number of blocks
constexpr auto GVNPRE_SKIP_BLOCK_THRESHOLD = 1000;
// Maximum allowed expression nesting depth
constexpr auto GVNPRE_SKIP_NESTED_EXPR_THRESHOLD = 1000;

// Function Inline
// TODO: A abstract cost or a specific size (?)
// constexpr auto FUNCTION_INLINE_COST_THRESHOLD = 100;
} // namespace Config::IR

#endif