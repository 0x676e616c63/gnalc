#pragma once
#ifndef GNALC_CONFIG_CONFIG_HPP
#define GNALC_CONFIG_CONFIG_HPP
#define GNALC_EXTENSION_A32 1

namespace Config::IR {
// IRGenerator
constexpr auto REGISTER_TEMP_NAME = "%%__GNALC_IR_TEMP_NAME";
constexpr auto MEMSET_INTRINSIC_NAME = "@llvm.memset.p0i8.i32";
constexpr auto MEMCPY_INTRINSIC_NAME = "@llvm.memcpy.p0.p0.i32";
constexpr auto LOCAL_ARRAY_MEMSET_THRESHOLD = 32;

// Memoization
constexpr auto MEMOIZATION_LOOKUP_INTRINSIC_NAME = "@gnalc.memoization.lookup";

// GVN-PRE
// Some operations in GVN-PRE are time-consuming,
// so we set some thresholds to ensure acceptable compilation times.
// Maximum number of blocks
constexpr auto GVNPRE_SKIP_BLOCK_THRESHOLD = 1000;
// Maximum allowed expression nesting depth
constexpr auto GVNPRE_SKIP_NESTED_EXPR_THRESHOLD = 128;

// Function Inline
constexpr auto FUNCTION_INLINE_INST_THRESHOLD = 1000;

// Loop Elimination
// LoopElim attempts to expand SCEVExpr to make loops trivially eliminable.
// However, excessive expansion can be a pessimization.
// Therefore, we apply a cost threshold:
// If the number of instructions expansion will generate > COST_RATIO * loop instruction count,
// we will skip the expansion.
// FIXME: I don't know if this threshold is reasonable.
constexpr auto LOOP_ELIMINATION_EXPANSION_COST_RATIO = 10;

// Loop Strength Reduce
// LSR attempts to expand AddRec to reduce multiple to addition.
// We don't expand if that will insert more than `THRESHOLD` instructions.
// a base + a step + an update + a phi
// FIXME: I don't know if this threshold is reasonable.
constexpr auto LSR_EXPANSION_THRESHOLD = 8;

// Internalize
// Avoid internalizing global variables whose size is larger than this threshold.
constexpr auto INTERNALIZE_GLOBAL_SIZE_THRESHOLD = 1024 * 1024; // 1 MB

// Loop Unroll
constexpr unsigned LOOP_UNROLLING_PEEL_COUNT = 10;
constexpr unsigned LOOP_UNROLLING_FULLY_UNROLL_SIZE = 200;
constexpr unsigned LOOP_UNROLLING_FULLY_UNROLL_COUNT = 16;
constexpr unsigned LOOP_UNROLLING_PARTIALLY_UNROLL_SIZE = 200;
constexpr unsigned LOOP_UNROLLING_PARTIALLY_UNROLL_COUNT = 8;
constexpr unsigned LOOP_UNROLLING_RUNTIME_UNROLL_SIZE = 200;
constexpr unsigned LOOP_UNROLLING_RUNTIME_UNROLL_COUNT = 8;
constexpr unsigned LOOP_UNROLLING_MAX_PROCESS_SIZE = 100;

// If Conversion
constexpr auto IF_CONVERSION_DUPLICATION_THRESHOLD = 4;

// Range Analysis
constexpr auto RANGE_ANALYSIS_MAX_PROCESS_CNT = 32;
} // namespace Config::IR

namespace Config::MIR {
// Register Allocation
constexpr auto CORE_REGISTER_MAX_NUM = 12; // r0 ~ r10 , with ip. most probably fp(r11), sometimes lr(r14)
constexpr auto FPU_REGISTER_MAX_NUM = 32;
} // namespace Config::MIR

namespace Config::MIR_new {
// Register Allocation
constexpr auto CORE_REGISTER_MAX_NUM = 30; // X0 ~ X29
constexpr auto FPU_REGISTER_MAX_NUM = 32;  // V0 ~ V31
} // namespace Config::MIR_new

#endif