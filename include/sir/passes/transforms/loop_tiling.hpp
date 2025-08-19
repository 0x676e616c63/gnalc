// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Loop Tiling
// Reference:
//   - Optimizing Compilers for Modern Architectures, 9.3 Blocking
//   - 一篇文章了解 Loop Tiling 优化: https://zhuanlan.zhihu.com/p/477023757
//   - 循环优化之循环分块（loop tiling）: https://zhuanlan.zhihu.com/p/292539074
//   - 循环优化之循环分块（loop tiling）二: https://zhuanlan.zhihu.com/p/301905385
#pragma once
#ifndef GNALC_SIR_PASSES_TRANSFORMS_LOOP_TILING_HPP
#define GNALC_SIR_PASSES_TRANSFORMS_LOOP_TILING_HPP

#include "sir/passes/pass_manager.hpp"

namespace SIR {
class LoopTilingPass : public PM::PassInfo<LoopTilingPass> {
public:
    PM::PreservedAnalyses run(LinearFunction &function, LFAM &lfam);
};

} // namespace SIR
#endif
